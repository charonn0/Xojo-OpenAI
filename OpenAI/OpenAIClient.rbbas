#tag Class
Private Class OpenAIClient
	#tag Method, Flags = &h0
		Sub Constructor()
		  #If USE_RBLIBCURL Then
		    Dim curl As New cURLClient
		    curl.EasyHandle.FailOnServerError = False
		    curl.BearerToken = APIKey
		    curl.RequestHeaders.SetHeader("User-Agent", USER_AGENT_STRING)
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
		    mClient = curl
		    
		  #ElseIf RBVersion > 2018.03 Then
		    Dim connection As New URLConnection
		    connection.RequestHeader("Authorization") = "Bearer " + APIKey
		    connection.RequestHeader("User-Agent") = USER_AGENT_STRING
		    mClient = connection
		    
		  #Else
		    Dim err As New OpenAIException(Nil)
		    err.Message = "This version of RealStudio is not supported."
		    Raise err
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Destructor()
		  #If USE_RBLIBCURL Then
		    Dim share As libcURL.ShareHandle = ShareHandle
		    If share = Nil Then Return
		    Dim curl As cURLClient = mClient
		    share.RemoveTransfer(curl.EasyHandle)
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SendRequest(APIURL As String, Request As OpenAI.Request, RequestMethod As String = "POST") As JSONItem
		  mMaskBuffer = Nil
		  mImageBuffer = Nil
		  
		  #If USE_RBLIBCURL Then
		    Return SendRequest_RBLibcurl(APIURL, Request, RequestMethod)
		  #ElseIf USE_MBS Then
		    Return SendRequest_MBS(APIURL, Request, RequestMethod)
		  #ElseIf RBVersion > 2018.03 Then
		    Return SendRequest_URLConnection(APIURL, Request, RequestMethod)
		  #Else
		    #pragma Unused APIURL
		    #pragma Unused Request
		    #pragma Unused RequestMethod
		    Dim err As New OpenAIException(Nil)
		    err.Message = "This version of RealStudio is not supported."
		    Raise err
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SendRequest(APIURL As String, RequestMethod As String = "GET") As JSONItem
		  mMaskBuffer = Nil
		  mImageBuffer = Nil
		  
		  #If USE_RBLIBCURL Then
		    Return SendRequest_RBLibcurl(APIURL, RequestMethod)
		  #ElseIf USE_MBS Then
		    Return SendRequest_MBS(APIURL, RequestMethod)
		  #ElseIf RBVersion > 2018.03 Then
		    Return SendRequest_URLConnection(APIURL, RequestMethod)
		  #Else
		    #pragma Unused APIURL
		    #pragma Unused RequestMethod
		    Dim err As New OpenAIException(Nil)
		    err.Message = "This version of RealStudio is not supported."
		    Raise err
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function SendRequest_MBS(APIURL As String, Request As OpenAI.Request, RequestMethod As String = "POST") As JSONItem
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
		            If mb.Size > 1024 * 1024 * 4 Then
		              Dim err As New OpenAIException
		              err.Message = "Pictures submitted to the API may be no larger than 4MB."
		              Raise err
		            End If
		            curl.FormAddFile(name, "image.png", mb, "image/png")
		          Case IsA OpenAI.File
		            Break
		          Else
		            Raise New OpenAIException(Nil)
		          End Select
		        End Select
		      Next
		      curl.FormFinish()
		    Else
		      curl.OptionUpload = True
		      curl.InputData = req.StringValue
		      curl.SetOptionHTTPHeader(Array("Content-Type: application/json"))
		    End If
		    
		    curl.OptionURL = OPENAI_URL + APIURL
		    If curl.Perform() <> 0 Then
		      Dim data As String = curl.OutputData
		      Raise New OpenAIException(New JSONItem(data))
		    Else
		      Return New JSONItem(curl.OutputData)
		    End If
		  #Else
		    #pragma Unused APIURL
		    #pragma Unused Request
		    #pragma Unused RequestMethod
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function SendRequest_MBS(APIURL As String, RequestMethod As String = "GET") As JSONItem
		  #If USE_MBS Then
		    Dim curl As CURLSMBS = mClient
		    curl.OptionURL = OPENAI_URL + APIURL
		    curl.OptionCustomRequest = RequestMethod
		    Dim err As Integer = curl.Perform()
		    If err <> 0 Then
		      Raise New OpenAIException(New JSONItem(curl.OutputData))
		    Else
		      Return New JSONItem(curl.OutputData)
		    End If
		  #Else
		    #pragma Unused APIURL
		    #pragma Unused RequestMethod
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function SendRequest_RBLibcurl(APIURL As String, Request As OpenAI.Request, RequestMethod As String = "POST") As JSONItem
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
		              Dim err As New OpenAIException(Nil)
		              err.Message = "Pictures submitted to the API may be no larger than 4MB."
		              Raise err
		            End If
		          Case IsA OpenAI.File
		            Break
		          Else
		            Raise New OpenAIException(Nil)
		          End Select
		        End Select
		      Next
		      
		      If Not client.Post(OPENAI_URL + APIURL, form) Then ' perform the request
		        Dim curlerr As New libcURL.cURLException(client.EasyHandle)
		        Dim openaierr As New OpenAIException(New JSONItem(client.GetDownloadedData))
		        openaierr.Message = openaierr.Message + EndOfLine + curlerr.Message
		        Raise openaierr
		      End If
		      
		    Else ' POST a JSONItem
		      Dim data As MemoryBlock = requestobj.StringValue
		      client.RequestHeaders.SetHeader("Content-Type", "application/json")
		      client.SetRequestMethod("POST")
		      If Not client.Put(OPENAI_URL + APIURL, data) Then ' perform the request
		        Dim curlerr As New libcURL.cURLException(client.EasyHandle)
		        Dim openaierr As New OpenAIException(New JSONItem(client.GetDownloadedData))
		        openaierr.Message = openaierr.Message + EndOfLine + curlerr.Message
		        Raise openaierr
		      End If
		      Return New JSONItem(client.GetDownloadedData)
		    End If
		    
		  #Else
		    #pragma Unused APIURL
		    #pragma Unused Request
		    #pragma Unused RequestMethod
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function SendRequest_RBLibcurl(APIURL As String, RequestMethod As String = "GET") As JSONItem
		  #If USE_RBLIBCURL Then
		    Dim client As cURLClient = mClient
		    client.SetRequestMethod(RequestMethod)
		    If Not client.Get(OPENAI_URL + APIURL) Then
		      Dim curlerr As New libcURL.cURLException(client.EasyHandle)
		      Dim openaierr As New OpenAIException(New JSONItem(client.GetDownloadedData))
		      openaierr.Message = openaierr.Message + EndOfLine + curlerr.Message
		      Raise openaierr
		    End If
		    Dim data As String = client.GetDownloadedData()
		    Return New JSONItem(data)
		  #Else
		    #pragma Unused APIURL
		    #pragma Unused RequestMethod
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function SendRequest_URLConnection(APIURL As String, Request As OpenAI.Request, RequestMethod As String = "POST") As JSONItem
		  #If RBVersion > 2018.03 Then
		    Dim client As URLConnection = mClient
		    Dim req As Variant = Request.ToObject
		    If req IsA Dictionary Then
		      Dim boundary As String = "--" + Right(EncodeHex(MD5(Str(Microseconds))), 24) + "-bOuNdArY"
		      Static CRLF As String = EndOfLine.Windows
		      Dim data As New MemoryBlock(0)
		      Dim out As New BinaryStream(data)
		      Dim formdata As Dictionary = req
		      For Each key As String In FormData.Keys
		        out.Write("--" + Boundary + CRLF)
		        If VarType(FormData.Value(Key)) = Variant.TypeString Then
		          out.Write("Content-Disposition: form-data; name=""" + key + """" + CRLF + CRLF)
		          out.Write(FormData.Value(key) + CRLF)
		        ElseIf FormData.Value(Key) IsA Picture Then
		          Dim pic As Picture = FormData.Value(key)
		          If key = "image" Then
		            out.Write("Content-Disposition: form-data; name=""" + key + """; filename=""image.png""" + CRLF)
		          Else
		            out.Write("Content-Disposition: form-data; name=""" + key + """; filename=""mask.png""" + CRLF)
		          End If
		          out.Write("Content-Type: image/png" + CRLF + CRLF)
		          Dim mb As MemoryBlock = pic.GetData(Picture.FormatPNG)
		          If mb.Size > 1024 * 1024 * 4 Then
		            Dim err As New OpenAIException(Nil)
		            err.Message = "Pictures submitted to the API may be no larger than 4MB."
		            Raise err
		          End If
		          out.Write(mb + CRLF)
		        End If
		      Next
		      out.Write("--" + Boundary + "--" + CRLF)
		      out.Close
		      client.SetRequestContent(data, "multipart/form-data; boundary=" + boundary)
		    Else
		      client.SetRequestContent(req.StringValue, "application/json")
		    End If
		    Dim result As String = client.SendSync(RequestMethod, OPENAI_URL + APIURL, 0)
		    Return New JSONItem(result)
		  #Else
		    #pragma Unused APIURL
		    #pragma Unused Request
		    #pragma Unused RequestMethod
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function SendRequest_URLConnection(APIURL As String, RequestMethod As String = "GET") As JSONItem
		  #If RBVersion > 2018.03 Then
		    Dim client As URLConnection = mClient
		    Dim data As String = client.SendSync(RequestMethod, OPENAI_URL + APIURL, 0)
		    Return New JSONItem(data)
		  #Else
		    #pragma Unused APIURL
		    #pragma Unused RequestMethod
		  #endif
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mClient As Variant
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mImageBuffer As MemoryBlock
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMaskBuffer As MemoryBlock
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Shared ShareHandle As Variant
	#tag EndProperty


End Class
#tag EndClass
