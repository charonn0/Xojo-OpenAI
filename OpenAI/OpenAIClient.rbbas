#tag Class
Private Class OpenAIClient
	#tag Method, Flags = &h0
		Sub Constructor()
		  #If USE_RBLIBCURL Then
		    Dim curl As New cURLClient
		    curl.EasyHandle.UseProgressEvent = False
		    curl.EasyHandle.FailOnServerError = False
		    curl.BearerToken = APIKey
		    curl.EasyHandle.UserAgent = USER_AGENT_STRING
		    mClient = curl
		    
		    Dim share As libcURL.ShareHandle = ShareHandle
		    If share = Nil Then
		      share = New libcURL.ShareHandle
		      share.ShareConnections = True
		      share.ShareCookies = True
		      share.ShareDNSCache = True
		      share.ShareSSL = True
		      ShareHandle = share
		    End If
		    share.AddTransfer(curl.EasyHandle)
		    
		    
		  #ElseIf USE_MBS Then
		    Const CURLAUTH_BEARER = 64
		    Dim curl As New CURLSMBS
		    curl.OptionVerbose = True
		    curl.CollectOutputData = True
		    curl.OptionXOAuth2Bearer = APIKey
		    curl.OptionHTTPAuth = CURLAUTH_BEARER
		    curl.OptionUserAgent = USER_AGENT_STRING
		    ' curl.OptionSSLVerifyHost = 2
		    ' curl.OptionSSLVerifyPeer = 1
		    mClient = curl
		    
		  #ElseIf RBVersion > 2018.03 Then
		    Dim connection As New URLConnection
		    connection.RequestHeader("Authorization") = "Bearer " + APIKey
		    connection.RequestHeader("User-Agent") = USER_AGENT_STRING
		    mClient = connection
		    
		  #Else
		    #pragma Warning "No supported HTTPS library enabled."
		    Raise New OpenAIException("No supported HTTPS library enabled.")
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function CreateMultipartForm(Fields As Dictionary, Request As OpenAI.Request, ByRef Boundary As String) As MemoryBlock
		  #If RBVersion > 2018.03 Then
		    Boundary = "--" + Right(EncodeHex(MD5(Str(Microseconds))), 24) + "-bOuNdArY"
		    Static CRLF As String = EndOfLine.Windows
		    Dim data As New MemoryBlock(0)
		    Dim out As New BinaryStream(data)
		    For Each key As String In Fields.Keys
		      out.Write("--" + Boundary + CRLF)
		      If VarType(Fields.Value(Key)) = Variant.TypeString Then
		        out.Write("Content-Disposition: form-data; name=""" + key + """" + CRLF + CRLF)
		        out.Write(Fields.Value(key) + CRLF)
		      ElseIf Fields.Value(Key) IsA Picture Then
		        Dim pic As Picture = Fields.Value(key)
		        If key = "image" Then
		          out.Write("Content-Disposition: form-data; name=""" + key + """; filename=""image.png""" + CRLF)
		        Else
		          out.Write("Content-Disposition: form-data; name=""" + key + """; filename=""mask.png""" + CRLF)
		        End If
		        out.Write("Content-Type: image/png" + CRLF + CRLF)
		        Dim mb As MemoryBlock = pic.GetData(Picture.FormatPNG)
		        If mb.Size > 1024 * 1024 * 4 Then Raise New OpenAIException("Pictures submitted to the API may be no larger than 4MB.")
		        out.Write(mb + CRLF)
		      ElseIf Fields.Value(key) IsA MemoryBlock Then
		        Dim v As MemoryBlock = Fields.Value(key)
		        out.Write("Content-Disposition: form-data; name=""" + key + """; filename=""" + Request.FileName + """" + CRLF)
		        out.Write("Content-Type: application/x-jsonlines" + CRLF + CRLF)
		        out.Write(v + CRLF)
		      End If
		    Next
		    out.Write("--" + Boundary + "--" + CRLF)
		    out.Close
		    Return data
		  #Else
		    #pragma Unused Fields
		    #pragma Unused Request
		    #pragma Unused Boundary
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Destructor()
		  #If USE_RBLIBCURL Then
		    Dim share As libcURL.ShareHandle = ShareHandle
		    If share = Nil Then Return
		    Dim curl As cURLClient = mClient
		    share.RemoveTransfer(curl.EasyHandle)
		  #ElseIf USE_MBS Then
		    Dim curl As CURLSMBS = mClient
		    curl.Cancel = True
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SendRequest(APIEndpoint As String, Request As OpenAI.Request, RequestMethod As String = "POST") As String
		  ' Upload the Request to the APIEndpoint using the specified HTTP request method.
		  
		  mMaskBuffer = Nil
		  mImageBuffer = Nil
		  
		  #If USE_RBLIBCURL Then
		    Return SendRequest_RBLibcurl(APIEndpoint, Request, RequestMethod)
		  #ElseIf USE_MBS Then
		    Return SendRequest_MBS(APIEndpoint, Request, RequestMethod)
		  #ElseIf RBVersion > 2018.03 Then
		    Return SendRequest_URLConnection(APIEndpoint, Request, RequestMethod)
		  #Else
		    #pragma Unused APIEndpoint
		    #pragma Unused Request
		    #pragma Unused RequestMethod
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SendRequest(APIEndpoint As String, RequestMethod As String = "GET") As String
		  ' Download a response from the APIEndpoint using the specified HTTP request method.
		  
		  mMaskBuffer = Nil
		  mImageBuffer = Nil
		  
		  #If USE_RBLIBCURL Then
		    Return SendRequest_RBLibcurl(APIEndpoint, RequestMethod)
		  #ElseIf USE_MBS Then
		    Return SendRequest_MBS(APIEndpoint, RequestMethod)
		  #ElseIf RBVersion > 2018.03 Then
		    Return SendRequest_URLConnection(APIEndpoint, RequestMethod)
		  #Else
		    #pragma Unused APIEndpoint
		    #pragma Unused RequestMethod
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function SendRequest_MBS(APIEndpoint As String, Request As OpenAI.Request, RequestMethod As String = "POST") As String
		  #If USE_MBS Then
		    Dim req As Variant = Request.ToObject()
		    Dim curl As CURLSMBS = mClient
		    curl.OptionCustomRequest = RequestMethod
		    If req IsA Dictionary Then
		      Dim d As Dictionary = req
		      For Each name As String In d.Keys
		        Select Case VarType(d.Value(name))
		        Case Variant.TypeString
		          curl.FormAddField(name, d.Value(name))
		        Case Variant.TypeInteger
		          Dim v As Integer = d.Value(name)
		          curl.FormAddField(name, Str(v, "##0"))
		        Case Variant.TypeSingle
		          Dim v As Single = d.Value(name)
		          curl.FormAddField(name, Str(v, "##0.0#"))
		        Case Variant.TypeObject
		          Select Case d.Value(name)
		          Case IsA Picture
		            Dim v As Picture = d.Value(name)
		            Dim mb As MemoryBlock = v.GetData(Picture.FormatPNG)
		            If mb.Size > 1024 * 1024 * 4 Then Raise New OpenAIException("Pictures submitted to the API may be no larger than 4MB.")
		            curl.FormAddFile(name, "image.png", mb, "image/png")
		            
		          Case IsA MemoryBlock
		            Dim v As MemoryBlock = d.Value(name)
		            curl.FormAddFile(name, Request.FileName, v, "application/x-jsonlines")
		            
		          Case IsA OpenAI.File
		            Break
		          Else
		            Raise New OpenAIException("Error while serializing the request (MBS)")
		          End Select
		        End Select
		      Next
		      curl.FormFinish()
		    Else
		      curl.OptionUpload = True
		      curl.InputData = req.StringValue
		      curl.SetOptionHTTPHeader(Array("Content-Type: application/json"))
		    End If
		    
		    curl.OptionURL = OPENAI_URL + APIEndpoint
		    If curl.PerformMT() = 0 Then Return curl.OutputData
		    
		    'error
		    Dim data As String = curl.OutputData
		    If data.Trim = "" Then
		      Raise New OpenAIException(Me)
		    Else
		      Raise New OpenAIException(New JSONItem(data))
		    End If
		  #Else
		    #pragma Unused APIEndpoint
		    #pragma Unused Request
		    #pragma Unused RequestMethod
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function SendRequest_MBS(APIEndpoint As String, RequestMethod As String = "GET") As String
		  #If USE_MBS Then
		    Dim curl As CURLSMBS = mClient
		    curl.OptionURL = OPENAI_URL + APIEndpoint
		    curl.OptionCustomRequest = RequestMethod
		    If curl.PerformMT() = 0 Then Return curl.OutputData
		    
		    'error
		    Dim data As String = curl.OutputData
		    If data.Trim = "" Then
		      Raise New OpenAIException(Me)
		    Else
		      Raise New OpenAIException(New JSONItem(data))
		    End If
		    
		  #Else
		    #pragma Unused APIEndpoint
		    #pragma Unused RequestMethod
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function SendRequest_RBLibcurl(APIEndpoint As String, Request As OpenAI.Request, RequestMethod As String = "POST") As String
		  #If USE_RBLIBCURL Then
		    Dim client As cURLClient = mClient
		    client.SetRequestMethod(RequestMethod)
		    Dim requestobj As Variant = Request.ToObject()
		    
		    
		    If requestobj IsA Dictionary Then ' POST an HTTP form
		      Dim d As Dictionary = requestobj
		      Dim form As New libcURL.MultipartForm
		      For Each name As String In d.Keys
		        Select Case VarType(d.Value(name))
		        Case Variant.TypeString
		          Dim v As String = d.Value(name)
		          form.AddElement(name, v)
		        Case Variant.TypeInteger
		          Dim v As Integer = d.Value(name)
		          form.AddElement(name, Str(v, "##0"))
		        Case Variant.TypeSingle
		          Dim v As Single = d.Value(name)
		          form.AddElement(name, Str(v, "##0.0#"))
		        Case Variant.TypeObject
		          Select Case d.Value(name)
		          Case IsA Picture
		            Dim v As Picture = d.Value(name)
		            If name = "image" Then
		              mImageBuffer = v.GetData(Picture.FormatPNG)
		              form.AddElement(name, mImageBuffer, "image.png", "image/png")
		            Else
		              mMaskBuffer = v.GetData(Picture.FormatPNG)
		              form.AddElement(name, mMaskBuffer, "mask.png", "image/png")
		            End If
		            If mImageBuffer <> Nil And mImageBuffer.Size > 1024 * 1024 * 4 Or _
		              mMaskBuffer <> Nil And mMaskBuffer.Size > 1024 * 1024 * 4 Then
		              Raise New OpenAIException("Pictures submitted to the API may be no larger than 4MB.")
		            End If
		            
		          Case IsA MemoryBlock
		            Dim v As MemoryBlock = d.Value(name)
		            form.AddElement(name, v, Request.FileName, "application/x-jsonlines")
		            
		          Case IsA OpenAI.File
		            Break
		          Else
		            Raise New OpenAIException("Error while serializing the request (RB-libcURL)")
		          End Select
		        End Select
		      Next
		      
		      ' perform the request
		      If client.Post(OPENAI_URL + APIEndpoint, form) Then Return client.GetDownloadedData
		      
		      ' error
		      Dim curlerr As New libcURL.cURLException(client.EasyHandle)
		      Dim data As String = client.GetDownloadedData
		      If data.Trim <> "" Then
		        Dim openaierr As New OpenAIException(New JSONItem(data))
		        curlerr.Message = openaierr.Message + EndOfLine + curlerr.Message
		      End If
		      Raise curlerr
		      
		      
		    Else ' POST a JSONItem
		      
		      Dim data As MemoryBlock = requestobj.StringValue()
		      client.RequestHeaders.SetHeader("Content-Type", "application/json")
		      client.SetRequestMethod("POST")
		      
		      ' perform the request
		      If client.Put(OPENAI_URL + APIEndpoint, data) Then Return client.GetDownloadedData
		      
		      ' error
		      Dim curlerr As New libcURL.cURLException(client.EasyHandle)
		      Dim page As String = client.GetDownloadedData
		      If page.Trim <> "" Then
		        Dim openaierr As New OpenAIException(New JSONItem(page))
		        curlerr.Message = openaierr.Message + EndOfLine + curlerr.Message
		      End If
		      Raise curlerr
		    End If
		    
		  #Else
		    #pragma Unused APIEndpoint
		    #pragma Unused Request
		    #pragma Unused RequestMethod
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function SendRequest_RBLibcurl(APIEndpoint As String, RequestMethod As String = "GET") As String
		  #If USE_RBLIBCURL Then
		    Dim client As cURLClient = mClient
		    client.SetRequestMethod(RequestMethod)
		    
		    ' perform the request
		    If client.Get(OPENAI_URL + APIEndpoint) Then Return client.GetDownloadedData()
		    
		    ' error
		    Dim curlerr As New libcURL.cURLException(client.EasyHandle)
		    Dim data As String = client.GetDownloadedData
		    If data.Trim = "" Then
		      Dim openaierr As New OpenAIException(New JSONItem(data))
		      curlerr.Message = openaierr.Message + EndOfLine + curlerr.Message
		    End If
		    Raise curlerr
		    
		  #Else
		    #pragma Unused APIEndpoint
		    #pragma Unused RequestMethod
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function SendRequest_URLConnection(APIEndpoint As String, Request As OpenAI.Request, RequestMethod As String = "POST") As String
		  #If RBVersion > 2018.03 Then
		    Dim client As URLConnection = mClient
		    Dim req As Variant = Request.ToObject
		    If req IsA Dictionary Then
		      Dim boundary As String
		      Dim data As MemoryBlock = CreateMultipartForm(req, Request, boundary)
		      client.SetRequestContent(data, "multipart/form-data; boundary=" + boundary)
		    Else
		      client.SetRequestContent(req.StringValue, "application/json")
		    End If
		    mURLConnectionError = Nil
		    Try
		      Return client.SendSync(RequestMethod, OPENAI_URL + APIEndpoint, 0)
		    Catch err
		      mURLConnectionError = err
		    End Try
		    
		  #Else
		    #pragma Unused APIEndpoint
		    #pragma Unused Request
		    #pragma Unused RequestMethod
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function SendRequest_URLConnection(APIEndpoint As String, RequestMethod As String = "GET") As String
		  #If RBVersion > 2018.03 Then
		    Dim client As URLConnection = mClient
		    mURLConnectionError = Nil
		    Try
		      Return client.SendSync(RequestMethod, OPENAI_URL + APIEndpoint, 0)
		    Catch err
		      mURLConnectionError = err
		    End Try
		  #Else
		    #pragma Unused APIEndpoint
		    #pragma Unused RequestMethod
		  #endif
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  #If USE_RBLIBCURL Then
			    Dim curl As cURLClient = mClient
			    Return curl.LastError
			    
			  #ElseIf USE_MBS Then
			    Dim curl As CURLSMBS = mClient
			    Return curl.Lasterror
			    
			  #ElseIf RBVersion > 2018.03 Then
			    If mURLConnectionError <> Nil Then Return mURLConnectionError.ErrorNumber
			    
			  #endif
			End Get
		#tag EndGetter
		LastErrorCode As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  #If USE_RBLIBCURL Then
			    Dim curl As cURLClient = mClient
			    Return curl.LastErrorMessage
			    
			  #ElseIf USE_MBS Then
			    Dim curl As CURLSMBS = mClient
			    Return curl.LasterrorMessage
			    
			  #ElseIf RBVersion > 2018.03 Then
			    If mURLConnectionError <> Nil Then Return mURLConnectionError.Reason
			    
			  #endif
			End Get
		#tag EndGetter
		LastErrorMessage As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  #If USE_RBLIBCURL Then
			    Dim curl As cURLClient = mClient
			    Return curl.LastStatusCode
			    
			  #ElseIf USE_MBS Then
			    Dim curl As CURLSMBS = mClient
			    Return curl.GetInfoResponseCode()
			    
			  #ElseIf RBVersion > 2018.03 Then
			    Dim connection As URLConnection = mClient
			    Return connection.HTTPStatusCode
			    
			  #endif
			End Get
		#tag EndGetter
		LastStatusCode As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mClient As Variant
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mImageBuffer As MemoryBlock
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastErrorCode As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMaskBuffer As MemoryBlock
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mURLConnectionError As RuntimeException
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Shared ShareHandle As Variant
	#tag EndProperty


End Class
#tag EndClass
