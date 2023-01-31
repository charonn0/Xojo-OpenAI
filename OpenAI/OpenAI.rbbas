#tag Module
Protected Module OpenAI
	#tag Method, Flags = &h21
		Private Function GetClient() As Variant
		  #If USE_RBLIBCURL Then
		    Static client As cURLClient
		    If client = Nil Then
		      client = New cURLClient
		      client.EasyHandle.FailOnServerError = False
		      client.BearerToken = APIKey
		    End If
		    client.RequestHeaders.Reset()
		    client.RequestHeaders.SetHeader("User-Agent", USER_AGENT_STRING)
		    Return client
		  #ElseIf USE_MBS Then
		    Const CURLAUTH_BEARER = 64
		    Dim curl As New CURLSMBS
		    curl.OptionVerbose = True
		    curl.CollectOutputData = True
		    curl.OptionXOAuth2Bearer = APIKey
		    curl.OptionHTTPAuth = CURLAUTH_BEARER
		    curl.OptionUserAgent = USER_AGENT_STRING
		    Return curl
		    
		  #ElseIf RBVersion > 2018.03 Then
		    Static client As URLConnection
		    If client = Nil Then
		      client = New URLConnection
		      client.RequestHeader("Authorization") = "Bearer " + APIKey
		      client.RequestHeader("User-Agent") = USER_AGENT_STRING
		    End If
		    Return client
		  #Else
		    Dim err As New OpenAIException(Nil)
		    err.Message = "This version of RealStudio is not supported."
		    Raise err
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function SendRequest(APIURL As String) As JSONItem
		  #If USE_RBLIBCURL Then
		    Return SendRequest_RBLibcurl(APIURL)
		  #ElseIf USE_MBS Then
		    Return SendRequest_MBS(APIURL)
		  #ElseIf RBVersion > 2018.03 Then
		    Return SendRequest_URLConnection(APIURL)
		  #Else
		    #pragma Unused APIURL
		    Dim err As New OpenAIException(Nil)
		    err.Message = "This version of RealStudio is not supported."
		    Raise err
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function SendRequest(APIURL As String, Request As OpenAI.Request) As JSONItem
		  #If USE_RBLIBCURL Then
		    Return SendRequest_RBLibcurl(APIURL, Request)
		  #ElseIf USE_MBS Then
		    Return SendRequest_MBS(APIURL, Request)
		  #ElseIf RBVersion > 2018.03 Then
		    Return SendRequest_URLConnection(APIURL, Request)
		  #Else
		    #pragma Unused APIURL
		    #pragma Unused Request
		    Dim err As New OpenAIException(Nil)
		    err.Message = "This version of RealStudio is not supported."
		    Raise err
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function SendRequest_MBS(APIURL As String) As JSONItem
		  #If USE_MBS Then
		    Dim curl As CURLSMBS = GetClient()
		    curl.OptionURL = OPENAI_URL + APIURL
		    Dim err As Integer = curl.Perform()
		    If err <> 0 Then
		      #If USE_MTCJSON Then
		        Raise New OpenAIException(New JSONItem_MTC(curl.OutputData))
		      #Else
		        Raise New OpenAIException(New JSONItem(curl.OutputData))
		      #EndIf
		    Else
		      #If USE_MTCJSON Then
		        Return New JSONItem_MTC(curl.OutputData)
		      #Else
		        Return New JSONItem(curl.OutputData)
		      #EndIf
		    End If
		  #Else
		    #pragma Unused APIURL
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function SendRequest_MBS(APIURL As String, Request As OpenAI.Request) As JSONItem
		  #If USE_MBS Then
		    Dim req As Variant = Request.ToObject()
		    Dim curl As CURLSMBS
		    If req IsA CURLMBS Then
		      curl = req
		    Else
		      curl = GetClient()
		      curl.InputData = req.StringValue
		      curl.OptionUpload = True
		      curl.OptionCustomRequest = "POST"
		      curl.SetOptionHTTPHeader(Array("Content-Type: application/json"))
		    End If
		    curl.OptionURL = OPENAI_URL + APIURL
		    If curl.Perform() <> 0 Then
		      Dim data As String = curl.OutputData
		      #If USE_MTCJSON Then
		        Raise New OpenAIException(New JSONItem_MTC(data))
		      #Else
		        Raise New OpenAIException(New JSONItem(data))
		      #EndIf
		    Else
		      #If USE_MTCJSON Then
		        Return New JSONItem_MTC(curl.OutputData)
		      #Else
		        Return New JSONItem(curl.OutputData)
		      #EndIf
		    End If
		  #Else
		    #pragma Unused APIURL
		    #pragma Unused Request
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function SendRequest_RBLibcurl(APIURL As String) As JSONItem
		  #If USE_RBLIBCURL Then
		    Dim client As cURLClient = GetClient()
		    client.SetRequestMethod("")
		    If Not client.Get(OPENAI_URL + APIURL) Then
		      Dim curlerr As New libcURL.cURLException(client.EasyHandle)
		      #If USE_MTCJSON Then
		        Dim openaierr As New OpenAIException(New JSONItem_MTC(client.GetDownloadedData))
		      #Else
		        Dim openaierr As New OpenAIException(New JSONItem(client.GetDownloadedData))
		      #EndIf
		      openaierr.Message = openaierr.Message + EndOfLine + curlerr.Message
		      Raise openaierr
		    End If
		    Dim data As String = client.GetDownloadedData()
		    #If USE_MTCJSON Then
		      Return New JSONItem_MTC(data)
		    #Else
		      Return New JSONItem(data)
		    #EndIf
		  #Else
		    #pragma Unused APIURL
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function SendRequest_RBLibcurl(APIURL As String, Request As OpenAI.Request) As JSONItem
		  #If USE_RBLIBCURL Then
		    Dim client As cURLClient = GetClient()
		    Dim form As Variant = Request.ToObject()
		    If form IsA libcURL.MultipartForm Then
		      Dim req As libcURL.MultipartForm = form
		      If Not client.Post(OPENAI_URL + APIURL, req) Then
		        Dim curlerr As New libcURL.cURLException(client.EasyHandle)
		        #If USE_MTCJSON Then
		          Dim openaierr As New OpenAIException(New JSONItem_MTC(client.GetDownloadedData))
		        #Else
		          Dim openaierr As New OpenAIException(New JSONItem(client.GetDownloadedData))
		        #EndIf
		        openaierr.Message = openaierr.Message + EndOfLine + curlerr.Message
		        Raise openaierr
		      End If
		    ElseIf form <> Nil Then
		      Dim req As MemoryBlock = form.StringValue
		      client.RequestHeaders.SetHeader("Content-Type", "application/json")
		      client.SetRequestMethod("POST")
		      If Not client.Put(OPENAI_URL + APIURL, req) Then
		        Dim curlerr As New libcURL.cURLException(client.EasyHandle)
		        #If USE_MTCJSON Then
		          Dim openaierr As New OpenAIException(New JSONItem_MTC(client.GetDownloadedData))
		        #Else
		          Dim openaierr As New OpenAIException(New JSONItem(client.GetDownloadedData))
		        #EndIf
		        openaierr.Message = openaierr.Message + EndOfLine + curlerr.Message
		        Raise openaierr
		      End If
		    Else
		      Dim err As New OpenAIException(Nil)
		      err.Message = "Invalid request object"
		      Raise err
		    End If
		    Dim data As String = client.GetDownloadedData()
		    #If USE_MTCJSON Then
		      Return New JSONItem_MTC(data)
		    #Else
		      Return New JSONItem(data)
		    #EndIf
		    
		  #Else
		    #pragma Unused APIURL
		    #pragma Unused Request
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function SendRequest_URLConnection(APIURL As String) As JSONItem
		  #If RBVersion > 2018.03 Then
		    Dim client As URLConnection = GetClient()
		    Dim data As String = client.SendSync("GET", OPENAI_URL + APIURL, 0)
		    #If USE_MTCJSON Then
		      Return New JSONItem_MTC(data)
		    #Else
		      Return New JSONItem(data)
		    #EndIf
		  #Else
		    #pragma Unused APIURL
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function SendRequest_URLConnection(APIURL As String, Request As OpenAI.Request) As JSONItem
		  #If RBVersion > 2018.03 Then
		    Dim client As URLConnection = GetClient()
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
		          out.Write("Content-Disposition: form-data; name=""" + key + """; filename=""image.png""" + CRLF)
		          out.Write("Content-Type: image/png" + CRLF + CRLF)
		          out.Write(pic.GetData(Picture.FormatPNG) + CRLF)
		        End If
		      Next
		      out.Write("--" + Boundary + "--" + CRLF)
		      out.Close
		      client.SetRequestContent(data, "multipart/form-data; boundary=" + boundary)
		    Else
		      client.SetRequestContent(req.StringValue, "application/json")
		    End If
		    Dim result As String = client.SendSync("POST", OPENAI_URL + APIURL, 0)
		    #If USE_MTCJSON Then
		      Return New JSONItem_MTC(result)
		    #Else
		      Return New JSONItem(result)
		    #EndIf
		  #Else
		    #pragma Unused APIURL
		    #pragma Unused Request
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function time_t(Count As Integer) As Date
		  Dim d As New Date(1970, 1, 1, 0, 0, 0, 0.0) 'UNIX epoch
		  d.TotalSeconds = d.TotalSeconds + Count
		  Return d
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		#tag Note
			You will need an OpenAI API key in order to interact with the OpenAI API
			
			https://platform.openai.com/account/api-keys
		#tag EndNote
		APIKey As String = "YOUR API KEY HERE"
	#tag EndProperty


	#tag Constant, Name = OPENAI_URL, Type = String, Dynamic = False, Default = \"https://api.openai.com", Scope = Private
	#tag EndConstant

	#tag Constant, Name = USER_AGENT_STRING, Type = String, Dynamic = False, Default = \"Xojo-OpenAI/0.1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = USE_MBS, Type = Boolean, Dynamic = False, Default = \"True", Scope = Private
	#tag EndConstant

	#tag Constant, Name = USE_MTCJSON, Type = Boolean, Dynamic = False, Default = \"False", Scope = Private
	#tag EndConstant

	#tag Constant, Name = USE_RBLIBCURL, Type = Boolean, Dynamic = False, Default = \"False", Scope = Private
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="APIKey"
			Group="Behavior"
			InitialValue="YOUR API KEY HERE"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			InheritedFrom="Object"
		#tag EndViewProperty
	#tag EndViewBehavior
End Module
#tag EndModule
