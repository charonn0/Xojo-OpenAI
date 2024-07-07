#tag Class
Private Class OpenAIClient
	#tag Method, Flags = &h0
		Sub Constructor()
		  #If USE_RBLIBCURL Then
		    Me.Constructor_RBLibcurl()
		    
		  #ElseIf USE_MBS Then
		    Me.Constructor_MBS()
		    
		  #ElseIf RBVersion > 2018.03 Then
		    Me.Constructor_URLConnection()
		    
		  #ElseIf RBVersion > 2014.02 Then
		    Me.Constructor_HTTPSecureSocket()
		    
		  #Else
		    #pragma Warning "No supported HTTPS library enabled."
		    Raise New OpenAIException("No supported HTTPS library enabled.")
		    ' At least one of the following HTTPS libraries must be available: 
		    ' 
		    '  * URLConnection class (Xojo 2018r3 or newer)
		    '  * HTTPSecureSocket class (Xojo 2014r3 to 2018r2; some API features limited)
		    '  * The RB-libcURL curl wrapper (Set OpenAI.USE_RBLIBCURL=True)
		    '  * The MonkeyBread curl plugin (Set OpenAI.USE_MBS=True)
		    '
		    ' See: https://github.com/charonn0/Xojo-OpenAI/wiki#using-rb-libcurl-or-mbs
		    
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Constructor_HTTPSecureSocket()
		  #If RBVersion > 2014.02 Then
		    Dim connection As New HTTPSecureSocket
		    AddHandler connection.ProxyAuthenticationRequired, WeakAddressOf HTTPSecurureSocketProxyAuthHandler
		    mClient = connection
		    connection.ConnectionType = SSLSocket.TLSv12
		    SetRequestHeader("Authorization", "Bearer " + OpenAI.APIKey)
		    SetRequestHeader("User-Agent", USER_AGENT_STRING)
		    If OpenAI.OrganizationID <> "" Then SetRequestHeader("OpenAI-Organization", OpenAI.OrganizationID)
		    If OpenAI.ProxyAddress <> "" Then
		      Me.ProxyAddress = OpenAI.ProxyAddress
		      Me.ProxyPort = OpenAI.ProxyPort
		      Me.ProxyType = OpenAI.ProxyType
		      If OpenAI.ProxyUsername <> "" Then Me.ProxyUsername = OpenAI.ProxyUsername
		      If OpenAI.ProxyPassword <> "" Then Me.ProxyPassword = OpenAI.ProxyPassword
		    End If
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Constructor_MBS()
		  #If USE_MBS Then
		    Const CURLAUTH_BEARER = 64
		    Dim curl As New CURLSMBS
		    mClient = curl
		    curl.OptionVerbose = True
		    curl.CollectOutputData = True
		    curl.OptionXOAuth2Bearer = OpenAI.APIKey
		    curl.OptionHTTPAuth = CURLAUTH_BEARER
		    curl.OptionUserAgent = USER_AGENT_STRING
		    If OpenAI.OrganizationID <> "" Then SetRequestHeader("OpenAI-Organization", OpenAI.OrganizationID)
		    If OpenAI.ProxyAddress <> "" Then
		      Me.ProxyAddress = OpenAI.ProxyAddress
		      Me.ProxyPort = OpenAI.ProxyPort
		      Me.ProxyType = OpenAI.ProxyType
		      If OpenAI.ProxyUsername <> "" Then Me.ProxyUsername = OpenAI.ProxyUsername
		      If OpenAI.ProxyPassword <> "" Then Me.ProxyPassword = OpenAI.ProxyPassword
		    End If
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Constructor_RBLibcurl()
		  #If USE_RBLIBCURL Then
		    Dim curl As New cURLClient
		    mClient = curl
		    curl.EasyHandle.UseProgressEvent = False
		    curl.EasyHandle.FailOnServerError = False
		    curl.BearerToken = OpenAI.APIKey
		    curl.EasyHandle.UserAgent = USER_AGENT_STRING
		    If OpenAI.OrganizationID <> "" Then SetRequestHeader("OpenAI-Organization", OpenAI.OrganizationID)
		    If OpenAI.ProxyAddress <> "" Then
		      Me.ProxyAddress = OpenAI.ProxyAddress
		      Me.ProxyPort = OpenAI.ProxyPort
		      Me.ProxyType = OpenAI.ProxyType
		      If OpenAI.ProxyUsername <> "" Then Me.ProxyUsername = OpenAI.ProxyUsername
		      If OpenAI.ProxyPassword <> "" Then Me.ProxyPassword = OpenAI.ProxyPassword
		    End If
		    
		    ' A curl "share" handle allows multiple transfers to share connection caches (among other things)
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
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Constructor_URLConnection()
		  #If RBVersion > 2018.03 Then
		    Dim connection As New URLConnection
		    mClient = connection
		    AddHandler connection.ContentReceived, WeakAddressOf URLConnectionContentsReceivedHandler
		    AddHandler connection.Error, WeakAddressOf URLConnectionErrorHandler
		    SetRequestHeader("Authorization", "Bearer " + OpenAI.APIKey)
		    SetRequestHeader("User-Agent", USER_AGENT_STRING)
		    If OpenAI.OrganizationID <> "" Then SetRequestHeader("OpenAI-Organization", OpenAI.OrganizationID)
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function CreateMultipartForm(Fields As Dictionary, Request As OpenAI.Request, ByRef Boundary As String) As MemoryBlock
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
		      out.Write("Content-Type: " + Request.FileMIMEType + CRLF + CRLF)
		      out.Write(v + CRLF)
		    End If
		  Next
		  out.Write("--" + Boundary + "--" + CRLF)
		  out.Close
		  Return data
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function CreateRequestPayload(Request As OpenAI.Request, ByRef IsMultipart As Boolean) As Variant
		  If Request.SourceImage = Nil And Request.MaskImage = Nil And Request.File = Nil Then
		    Dim js As JSONItem = Request
		    js.Compact = True
		    IsMultipart = False
		    Return js.ToString()
		    
		  ElseIf Request.SourceImage <> Nil Then
		    Dim d As New Dictionary
		    If Request.Size <> "1024x1024" Then d.Value("size") = Request.Size
		    If Request.NumberOfResults > 1 Then d.Value("n") = Str(Request.NumberOfResults, "#0")
		    If Request.ResultsAsURL Then
		      d.Value("response_format") = "url"
		    Else
		      d.Value("response_format") = "b64_json"
		    End If
		    If Request.User <> "" Then d.Value("user") = Request.User
		    If Request.SourceImage <> Nil Then d.Value("image") = Request.SourceImage
		    If Request.MaskImage <> Nil Then d.Value("mask") = Request.MaskImage
		    If Request.Prompt <> "" Then d.Value("prompt") = Request.Prompt
		    IsMultipart = True
		    Return d
		    
		  ElseIf Request.File <> Nil Then
		    Dim d As New Dictionary
		    Dim js As JSONItem = Request
		    For i As Integer = 0 To js.Count - 1
		      Dim n As String = js.Name(i)
		      Dim v As String = js.Value(n)
		      d.Value(n) = v
		    Next
		    d.Value("file") = Request.File
		    IsMultipart = True
		    Return d
		  End If
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

	#tag Method, Flags = &h21
		Private Function HTTPSecurureSocketProxyAuthHandler(Sender As Object, Realm as String, Headers as InternetHeaders, ByRef Name as String, ByRef Password as String) As Boolean
		  #pragma Unused Sender
		  #pragma Unused Realm
		  #pragma Unused Headers
		  If mProxyUser <> "" Or mProxyPassword <> "" Then
		    Name = mProxyUser
		    Password = mProxyPassword
		    Return True
		  End If
		  
		End Function
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
		  #ElseIf RBVersion > 2014.02 Then
		    Return SendRequest_HTTPSecureSocket(APIEndpoint, Request, RequestMethod)
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
		  #ElseIf RBVersion > 2014.02 Then
		    Return SendRequest_HTTPSecureSocket(APIEndpoint, RequestMethod)
		  #Else
		    #pragma Unused APIEndpoint
		    #pragma Unused RequestMethod
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function SendRequest_HTTPSecureSocket(APIEndpoint As String, Request As OpenAI.Request, RequestMethod As String = "POST") As String
		  #If RBVersion > 2014.02 Then
		    If RequestMethod <> "POST" Then Raise New OpenAIException("The current HTTPS library does not support this operation.")
		    Dim client As HTTPSecureSocket = mClient
		    Dim ismultipart As Boolean
		    Dim req As Variant = CreateRequestPayload(Request, ismultipart)
		    If ismultipart Then
		      Dim boundary As String
		      Dim data As MemoryBlock = CreateMultipartForm(req, Request, boundary)
		      client.SetRequestContent(data, "multipart/form-data; boundary=" + boundary)
		    Else
		      client.SetRequestContent(req.StringValue, "application/json")
		    End If
		    
		    Return client.Post(OPENAI_URL + APIEndpoint, 0)
		    
		  #Else
		    #pragma Unused APIEndpoint
		    #pragma Unused Request
		    #pragma Unused RequestMethod
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function SendRequest_HTTPSecureSocket(APIEndpoint As String, RequestMethod As String = "GET") As String
		  #If RBVersion > 2014.02 Then
		    If RequestMethod <> "GET" Then Raise New OpenAIException("The current HTTPS library does not support this operation.")
		    Dim client As HTTPSecureSocket = mClient
		    Return client.Get(OPENAI_URL + APIEndpoint, 0)
		    
		  #Else
		    #pragma Unused APIEndpoint
		    #pragma Unused RequestMethod
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function SendRequest_MBS(APIEndpoint As String, Request As OpenAI.Request, RequestMethod As String = "POST") As String
		  #If USE_MBS Then
		    Dim ismultipart As Boolean
		    Dim req As Variant = CreateRequestPayload(Request, ismultipart)
		    Dim curl As CURLSMBS = mClient
		    curl.OptionCustomRequest = RequestMethod
		    If ismultipart Then
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
		            curl.FormAddFile(name, Request.FileName, v, Request.FileMIMEType)
		            
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
		      SetRequestHeader("Content-Type", "application/json")
		    End If
		    
		    curl.OptionURL = OPENAI_URL + APIEndpoint
		    If mMBSHeaders.Ubound > -1 Then curl.SetOptionHTTPHeader(mMBSHeaders)
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
		    If mMBSHeaders.Ubound > -1 Then curl.SetOptionHTTPHeader(mMBSHeaders)
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
		    Dim ismultipart As Boolean
		    Dim requestobj As Variant = CreateRequestPayload(Request, ismultipart)
		    
		    If ismultipart Then ' POST an HTTP form
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
		            form.AddElement(name, v, Request.FileName, Request.FileMIMEType)
		            
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
		      Raise New libcURL.cURLException(client.EasyHandle)
		      
		    Else ' POST a JSONItem
		      
		      Dim data As MemoryBlock = requestobj.StringValue()
		      client.RequestHeaders.SetHeader("Content-Type", "application/json")
		      
		      ' perform the request
		      If client.Put(OPENAI_URL + APIEndpoint, data) Then Return client.GetDownloadedData
		      
		      ' error
		      Raise New libcURL.cURLException(client.EasyHandle)
		      
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
		    Raise New libcURL.cURLException(client.EasyHandle)
		    
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
		    Dim ismultipart As Boolean
		    Dim req As Variant = CreateRequestPayload(Request, ismultipart)
		    If ismultipart Then
		      Dim boundary As String
		      Dim data As MemoryBlock = CreateMultipartForm(req, Request, boundary)
		      client.SetRequestContent(data, "multipart/form-data; boundary=" + boundary)
		    Else
		      client.SetRequestContent(req.StringValue, "application/json")
		    End If
		    mURLConnectionContent = ""
		    mURLConnectionError = Nil
		    client.Send(RequestMethod, OPENAI_URL + APIEndpoint, 0)
		    Do Until mURLConnectionContent <> "" Or mURLConnectionError <> Nil
		      #If RBVersion < 2020 Then
		        If App.CurrentThread = Nil Then
		          App.DoEvents()
		        Else
		          App.YieldToNextThread()
		        End If
		      #Else
		        If Thread.Current = Nil Then
		          App.DoEvents()
		        Else
		          Thread.YieldToNext()
		        End If
		      #EndIf
		    Loop
		    Return mURLConnectionContent
		    
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
		    mURLConnectionContent = ""
		    mURLConnectionError = Nil
		    client.Send(RequestMethod, OPENAI_URL + APIEndpoint, 0)
		    Do Until mURLConnectionContent <> "" Or mURLConnectionError <> Nil
		      #If RBVersion < 2020 Then
		        If App.CurrentThread = Nil Then
		          App.DoEvents()
		        Else
		          App.YieldToNextThread()
		        End If
		      #Else
		        If Thread.Current = Nil Then
		          App.DoEvents()
		        Else
		          Thread.YieldToNext()
		        End If
		      #EndIf
		    Loop
		    Return mURLConnectionContent
		  #Else
		    #pragma Unused APIEndpoint
		    #pragma Unused RequestMethod
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetRequestHeader(Name As String, Value As String)
		  #If USE_RBLIBCURL Then
		    Dim client As cURLClient = mClient
		    client.RequestHeaders.SetHeader(Name, Value)
		    
		  #ElseIf USE_MBS Then
		    mMBSHeaders.Append(Name + ": " + Value)
		    
		  #ElseIf RBVersion > 2018.03 Then
		    Dim client As URLConnection = mClient
		    client.RequestHeader(Name) = Value
		    
		  #ElseIf RBVersion > 2014.02 Then
		    Dim client As HTTPSecureSocket = mClient
		    client.SetRequestHeader(Name, Value)
		    
		  #Else
		    #pragma Unused Name
		    #pragma Unused Value
		    
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub URLConnectionContentsReceivedHandler(Sender As Object, URL As String, HTTPStatus As Integer, Content As String)
		  #pragma Unused Sender
		  #pragma Unused URL
		  #pragma Unused HTTPStatus
		  mURLConnectionContent = Content
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub URLConnectionErrorHandler(Sender As Object, err As RuntimeException)
		  #pragma Unused Sender
		  mURLConnectionError = err
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mForceHTTP1_1
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' If we're using RB-libcURL or CURLMBS then we might be using HTTP/2 by default.
			  ' Set this to True to force HTTP/1.1 for this instance of OpenAIClient. Changing
			  ' this setting may force curl to establish a new connection to the server.
			  
			  #If USE_RBLIBCURL Then
			    Dim curl As cURLClient = mClient
			    If value Then
			      curl.HTTPVersion = libcURL.HTTPVersion.HTTP1_1
			    Else
			      curl.HTTPVersion = libcURL.HTTPVersion.None
			    End If
			    mForceHTTP1_1 = value
			    
			  #ElseIf USE_MBS Then
			    Dim curl As CURLSMBS = mClient
			    If value Then
			      curl.OptionHTTPVersion = 2
			    Else
			      curl.OptionHTTPVersion = 0
			    End If
			    mForceHTTP1_1 = value
			    
			  #Else
			    #pragma Unused value
			  #EndIf
			End Set
		#tag EndSetter
		ForceHTTP1_1 As Boolean
	#tag EndComputedProperty

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
		Private mForceHTTP1_1 As Boolean = False
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
		Private mMBSHeaders() As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProxyPassword As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProxyUser As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mURLConnectionContent As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mURLConnectionError As RuntimeException
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  #If USE_RBLIBCURL Then
			    Dim client As cURLClient = mClient
			    Return client.Proxy.Address
			    
			  #ElseIf USE_MBS Then
			    Dim curl As CURLSMBS = mClient
			    Return curl.OptionProxy
			    
			  #ElseIf RBVersion > 2018.03 Then
			    Return "" ' not supported in URLConnection
			    
			  #ElseIf RBVersion > 2014.02 Then
			    Dim client As HTTPSecureSocket = mClient
			    Return client.HTTPProxyAddress
			    
			  #endif
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  #If USE_RBLIBCURL Then
			    Dim client As cURLClient = mClient
			    client.Proxy.Address = value
			    
			  #ElseIf USE_MBS Then
			    Dim curl As CURLSMBS = mClient
			    curl.OptionProxy = value
			    
			  #ElseIf RBVersion > 2018.03 Then
			    Raise New OpenAIException("The current HTTPS library does not support proxies.") ' not supported in URLConnection
			    
			  #ElseIf RBVersion > 2014.02 Then
			    Dim client As HTTPSecureSocket = mClient
			    client.HTTPProxyAddress = value
			    
			  #Else
			    #pragma Unused value
			    
			  #endif
			End Set
		#tag EndSetter
		ProxyAddress As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  #If USE_RBLIBCURL Then
			    Dim client As cURLClient = mClient
			    Return client.Proxy.Password
			    
			  #ElseIf USE_MBS Then
			    Dim curl As CURLSMBS = mClient
			    Return curl.OptionProxyPassword
			    
			  #ElseIf RBVersion > 2018.03 Then
			    Return "" ' not supported in URLConnection
			    
			  #ElseIf RBVersion > 2014.02 Then
			    Return mProxyPassword
			    
			  #endif
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  #If USE_RBLIBCURL Then
			    Dim client As cURLClient = mClient
			    client.Proxy.Password = value
			    
			  #ElseIf USE_MBS Then
			    Dim curl As CURLSMBS = mClient
			    curl.OptionProxyPassword = value
			    
			  #ElseIf RBVersion > 2018.03 Then
			    Raise New OpenAIException("The current HTTPS library does not support proxies.") ' not supported in URLConnection
			    
			  #ElseIf RBVersion > 2014.02 Then
			    mProxyPassword = value
			    
			  #Else
			    #pragma Unused value
			    
			  #endif
			End Set
		#tag EndSetter
		ProxyPassword As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  #If USE_RBLIBCURL Then
			    Dim client As cURLClient = mClient
			    Return client.Proxy.Port
			    
			  #ElseIf USE_MBS Then
			    Dim curl As CURLSMBS = mClient
			    Return curl.OptionProxyPort
			    
			  #ElseIf RBVersion > 2018.03 Then
			    Return 0
			    
			  #ElseIf RBVersion > 2014.02 Then
			    Dim client As HTTPSecureSocket = mClient
			    Return client.HTTPProxyPort
			    
			  #endif
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  #If USE_RBLIBCURL Then
			    Dim client As cURLClient = mClient
			    client.Proxy.Port = value
			    
			  #ElseIf USE_MBS Then
			    Dim curl As CURLSMBS = mClient
			    curl.OptionProxyPort = value
			    
			  #ElseIf RBVersion > 2018.03 Then
			    Raise New OpenAIException("The current HTTPS library does not support proxies.") ' not supported in URLConnection
			    
			  #ElseIf RBVersion > 2014.02 Then
			    Dim client As HTTPSecureSocket = mClient
			    client.HTTPProxyPort = value
			    
			  #Else
			    #pragma Unused value
			    
			  #endif
			End Set
		#tag EndSetter
		ProxyPort As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  #If USE_RBLIBCURL Then
			    Dim client As cURLClient = mClient
			    Dim type As libcURL.ProxyType = client.Proxy.Type
			    Return CType(type, Int32)
			    
			  #ElseIf USE_MBS Then
			    Dim curl As CURLSMBS = mClient
			    Return curl.OptionProxyType
			    
			  #ElseIf RBVersion > 2018.03 Then
			    Return -1
			    
			  #ElseIf RBVersion > 2014.02 Then
			    Return 0
			    
			  #endif
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  #If USE_RBLIBCURL Then
			    Dim client As cURLClient = mClient
			    client.Proxy.Type = CType(value, libcURL.ProxyType)
			    
			  #ElseIf USE_MBS Then
			    Dim curl As CURLSMBS = mClient
			    curl.OptionProxyType = value
			    
			  #ElseIf RBVersion > 2018.03 Then
			    Raise New OpenAIException("The current HTTPS library does not support proxies.") ' not supported in URLConnection
			    
			  #ElseIf RBVersion > 2014.02 Then
			    If value <> 0 Then
			      Raise New OpenAIException("The current HTTPS library only supports HTTP proxies.") ' not supported in HTTPSecureSocket
			    End If
			    
			  #Else
			    #pragma Unused value
			    
			  #endif
			End Set
		#tag EndSetter
		ProxyType As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  #If USE_RBLIBCURL Then
			    Dim client As cURLClient = mClient
			    Return client.Proxy.Username
			    
			  #ElseIf USE_MBS Then
			    Dim curl As CURLSMBS = mClient
			    Return curl.OptionProxyUsername
			    
			  #ElseIf RBVersion > 2018.03 Then
			    Return "" ' not supported in URLConnection
			    
			  #ElseIf RBVersion > 2014.02 Then
			    Return mProxyUser
			    
			  #endif
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  #If USE_RBLIBCURL Then
			    Dim client As cURLClient = mClient
			    client.Proxy.Username = value
			    
			  #ElseIf USE_MBS Then
			    Dim curl As CURLSMBS = mClient
			    curl.OptionProxyUsername = value
			    
			  #ElseIf RBVersion > 2018.03 Then
			    Raise New OpenAIException("The current HTTPS library does not support proxies.") ' not supported in URLConnection
			    
			  #ElseIf RBVersion > 2014.02 Then
			    mProxyUser = value
			    
			  #Else
			    #pragma Unused value
			    
			  #endif
			End Set
		#tag EndSetter
		ProxyUsername As String
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private Shared ShareHandle As Variant
	#tag EndProperty


	#tag Constant, Name = PAYLOADTYPE_JSON, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PAYLOADTYPE_MULTIPART, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

End Class
#tag EndClass
