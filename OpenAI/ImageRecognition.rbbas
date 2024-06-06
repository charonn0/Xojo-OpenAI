#tag Class
Protected Class ImageRecognition
Inherits OpenAI.ChatCompletion
	#tag Method, Flags = &h1001
		Protected Sub Constructor(ResponseData As JSONItem, Client As OpenAIClient, ChatLog As OpenAI.ChatCompletionData, OriginalRequest As OpenAI.Request)
		  // Calling the overridden superclass constructor.
		  // Constructor(ResponseData As JSONItem, Client As OpenAIClient, ChatLog As OpenAI.ChatCompletionData) -- From ChatCompletion
		  Super.Constructor(ResponseData, Client, ChatLog, OriginalRequest)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Create(Request As OpenAI.Request) As OpenAI.ImageRecognition
		  ' Starts a new chat according to the Request's parameters. Returns a new instance of ImageRecognition
		  ' containing the generated reply to that message. Call GenerateNext() on that instance to continue
		  ' the conversation in context.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.ImageRecognition.Create
		  ' https://platform.openai.com/docs/api-reference/chat/create
		  ' https://platform.openai.com/docs/guides/vision/vision
		  
		  If ImageRecognition.Prevalidate Then
		    Dim err As ValidationError = ImageRecognition.IsValid(Request)
		    If err <> ValidationError.None Then Raise New OpenAIException(err)
		  End If
		  Dim client As New OpenAIClient
		  Dim result As JSONItem = Response.CreateRaw(client, "/v1/chat/completions", request)
		  If result = Nil Or result.HasName("error") Then Raise New OpenAIException(result)
		  If Not result.HasName("model") And Request.Model <> Nil Then result.Value("model") = Request.Model.ID
		  Dim msgs As JSONItem = Request.Messages
		  Return New OpenAI.ImageRecognition(result, client, New ChatCompletionData(msgs), Request)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Create(Prompt As String, Images() As FolderItem, MaxTokens As Integer = 300, Model As OpenAI.Model = Nil) As OpenAI.ImageRecognition
		  ' Sends an array of image files to the AI chat assistant along with a Prompt indicating
		  ' what you would like the AI to do with the images.
		  '
		  ' Returns a new instance of ImageRecognition containing the AI's response. Call GenerateNext()
		  ' on that instance to continue the conversation in context.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.ImageRecognition.Create
		  ' https://platform.openai.com/docs/api-reference/chat/create
		  ' https://platform.openai.com/docs/guides/vision/vision
		  
		  Dim pics() As Picture
		  For i As Integer = 0 To UBound(Images)
		    If Not Images(i).Exists Then Continue
		    Dim p As Picture = Picture.Open(Images(i))
		    If p = Nil Then Continue
		    pics.Append(p)
		  Next
		  If UBound(pics) = -1 Then Raise New OpenAIException("No images were of a supported format.")
		  Return ImageRecognition.Create(Prompt, pics, MaxTokens, Model)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Create(Prompt As String, Image As FolderItem, MaxTokens As Integer = 300, Model As OpenAI.Model = Nil) As OpenAI.ImageRecognition
		  ' Sends an image file to the AI chat assistant along with a Prompt indicating what you would
		  ' like the AI to do with the image.
		  '
		  ' Returns a new instance of ImageRecognition containing the AI's response. Call GenerateNext()
		  ' on that instance to continue the conversation in context.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.ImageRecognition.Create
		  ' https://platform.openai.com/docs/api-reference/chat/create
		  ' https://platform.openai.com/docs/guides/vision/vision
		  
		  Dim p As Picture = Picture.Open(Image)
		  If p = Nil Then Raise New OpenAIException("Unsupported image format.")
		  Return ImageRecognition.Create(Prompt, p, MaxTokens, Model)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Create(Prompt As String, Images() As Picture, MaxTokens As Integer = 300, Model As OpenAI.Model = Nil) As OpenAI.ImageRecognition
		  ' Sends an array of Picture objects to the AI chat assistant along with a Prompt indicating
		  ' what you would like the AI to do with the Pictures.
		  '
		  ' Returns a new instance of ImageRecognition containing the AI's response. Call GenerateNext()
		  ' on that instance to continue the conversation in context.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.ImageRecognition.Create
		  ' https://platform.openai.com/docs/api-reference/chat/create
		  ' https://platform.openai.com/docs/guides/vision/vision
		  
		  Dim chatlog As New ChatCompletionData()
		  chatlog.AddMessage("user", Prompt, Images)
		  Dim request As New OpenAI.Request
		  If Model = Nil Then Model = "gpt-4o"
		  request.Model = Model
		  request.Messages = chatlog
		  request.MaxTokens = MaxTokens
		  Return ImageRecognition.Create(request)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Create(Prompt As String, Image As Picture, MaxTokens As Integer = 300, Model As OpenAI.Model = Nil) As OpenAI.ImageRecognition
		  ' Sends a Picture object to the AI chat assistant along with a Prompt indicating what you would
		  ' like the AI to do with the Picture.
		  '
		  ' Returns a new instance of ImageRecognition containing the AI's response. Call GenerateNext()
		  ' on that instance to continue the conversation in context.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.ImageRecognition.Create
		  ' https://platform.openai.com/docs/api-reference/chat/create
		  ' https://platform.openai.com/docs/guides/vision/vision
		  
		  Dim chatlog As New ChatCompletionData()
		  chatlog.AddMessage("user", Prompt, Image)
		  Dim request As New OpenAI.Request
		  If Model = Nil Then Model = "gpt-4o"
		  request.Model = Model
		  request.Messages = chatlog
		  request.MaxTokens = MaxTokens
		  Return ImageRecognition.Create(request)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Create(Prompt As String, ImageURLs() As String, MaxTokens As Integer = 300, Model As OpenAI.Model = Nil) As OpenAI.ImageRecognition
		  ' Sends an array of image URLs to the AI chat assistant along with a Prompt indicating
		  ' what you would like the AI to do with the images.
		  '
		  ' Returns a new instance of ImageRecognition containing the AI's response. Call GenerateNext()
		  ' on that instance to continue the conversation in context.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.ImageRecognition.Create
		  ' https://platform.openai.com/docs/api-reference/chat/create
		  ' https://platform.openai.com/docs/guides/vision/vision
		  
		  Dim chatlog As New ChatCompletionData()
		  chatlog.AddMessage("user", Prompt, ImageURLs)
		  Dim request As New OpenAI.Request
		  If Model = Nil Then Model = "gpt-4o"
		  request.Model = Model
		  request.Messages = chatlog
		  request.MaxTokens = MaxTokens
		  Return ImageRecognition.Create(request)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Create(Prompt As String, ImageURL As String, MaxTokens As Integer = 300, Model As OpenAI.Model = Nil) As OpenAI.ImageRecognition
		  ' Sends an image URL to the AI chat assistant along with a Prompt indicating what you would
		  ' like the AI to do with the image.
		  '
		  ' Returns a new instance of ImageRecognition containing the AI's response. Call GenerateNext()
		  ' on that instance to continue the conversation in context.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.ImageRecognition.Create
		  ' https://platform.openai.com/docs/api-reference/chat/create
		  ' https://platform.openai.com/docs/guides/vision/vision
		  
		  Dim chatlog As New ChatCompletionData()
		  chatlog.AddMessage("user", Prompt, ImageURL)
		  Dim request As New OpenAI.Request
		  If Model = Nil Then Model = "gpt-4o"
		  request.Model = Model
		  request.Messages = chatlog
		  request.MaxTokens = MaxTokens
		  Return ImageRecognition.Create(request)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function CreateNext(Request As OpenAI.Request, Client As OpenAIClient) As OpenAI.ImageRecognition
		  If ImageRecognition.Prevalidate Then
		    Dim err As ValidationError = ImageRecognition.IsValid(Request)
		    If err <> ValidationError.None Then Raise New OpenAIException(err)
		  End If
		  Dim response As JSONItem = Response.CreateRaw(Client, "/v1/chat/completions", request)
		  If response = Nil Or response.HasName("error") Then Raise New OpenAIException(response)
		  Dim msgs As JSONItem = Request.Messages
		  Return New OpenAI.ImageRecognition(response, Client, New ChatCompletionData(msgs), Request)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GenerateNext(Role As String, Content As String, Images() As FolderItem, MaxTokens As Integer = 300, Model As OpenAI.Model = Nil) As OpenAI.ImageRecognition
		  ' Pass the Role, Content, and an array of image files comprising the next chat message to
		  ' receive a new instance of ImageRecognition containing the generated reply to that message.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.ImageRecognition.GenerateNext
		  
		  Dim pics() As Picture
		  For i As Integer = 0 To UBound(Images)
		    If Not Images(i).Exists Then Continue
		    Dim p As Picture = Picture.Open(Images(i))
		    If p = Nil Then Continue
		    pics.Append(p)
		  Next
		  If UBound(pics) = -1 Then Raise New OpenAIException("No images were of a supported format.")
		  Return Me.GenerateNext(Role, Content, pics, MaxTokens, Model)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GenerateNext(Role As String, Content As String, Image As FolderItem, MaxTokens As Integer = 300, Model As OpenAI.Model = Nil) As OpenAI.ImageRecognition
		  ' Pass the Role, Content, and an image file comprising the next chat message to receive
		  ' a new instance of ImageRecognition containing the generated reply to that message.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.ImageRecognition.GenerateNext
		  
		  Dim p As Picture = Picture.Open(Image)
		  If p = Nil Then Raise New OpenAIException("Unsupported image format.")
		  Return Me.GenerateNext(Role, Content, p, MaxTokens, Model)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GenerateNext(Role As String, Content As String, Model As OpenAI.Model = Nil) As OpenAI.ImageRecognition
		  ' Pass the Role and Content of the next chat message to receive a new instance of ImageRecognition
		  ' containing the generated reply to that message.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.ImageRecognition.GenerateNext
		  
		  ChatLog.AddMessage(Role, Content)
		  Dim request As New OpenAI.Request
		  If Model = Nil Then Model = "gpt-4o"
		  request.Model = Model
		  request.Messages = ChatLog
		  Return ImageRecognition.CreateNext(request, mClient)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GenerateNext(Role As String, Content As String, Images() As Picture, MaxTokens As Integer = 300, Model As OpenAI.Model = Nil) As OpenAI.ImageRecognition
		  ' Pass the Role, Content, and an array of Picture objects comprising the next chat message to
		  ' receive a new instance of ImageRecognition containing the generated reply to that message.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.ImageRecognition.GenerateNext
		  
		  ChatLog.AddMessage(Role, Content, Images)
		  Dim request As New OpenAI.Request
		  If Model = Nil Then Model = "gpt-4o"
		  request.Model = Model
		  request.Messages = ChatLog
		  request.MaxTokens = MaxTokens
		  Return ImageRecognition.CreateNext(request, mClient)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GenerateNext(Role As String, Content As String, Image As Picture, MaxTokens As Integer = 300, Model As OpenAI.Model = Nil) As OpenAI.ImageRecognition
		  ' Pass the Role, Content, and a Picture object comprising the next chat message to receive
		  ' a new instance of ImageRecognition containing the generated reply to that message.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.ImageRecognition.GenerateNext
		  
		  ChatLog.AddMessage(Role, Content, Image)
		  Dim request As New OpenAI.Request
		  If Model = Nil Then Model = "gpt-4o"
		  request.Model = Model
		  request.Messages = ChatLog
		  request.MaxTokens = MaxTokens
		  Return ImageRecognition.CreateNext(request, mClient)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GenerateNext(Role As String, Content As String, ImageURLs() As String, MaxTokens As Integer = 300, Model As OpenAI.Model = Nil) As OpenAI.ImageRecognition
		  ' Pass the Role, Content, and an array of image URLs comprising the next chat message to
		  ' receive a new instance of ImageRecognition containing the generated reply to that message.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.ImageRecognition.GenerateNext
		  
		  ChatLog.AddMessage(Role, Content, ImageURLs)
		  Dim request As New OpenAI.Request
		  If Model = Nil Then Model = "gpt-4o"
		  request.Model = Model
		  request.Messages = ChatLog
		  request.MaxTokens = MaxTokens
		  Return ImageRecognition.CreateNext(request, mClient)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GenerateNext(Role As String, Content As String, ImageURL As String, MaxTokens As Integer = 300, Model As OpenAI.Model = Nil) As OpenAI.ImageRecognition
		  ' Pass the Role, Content, and a URL to an image comprising the next chat message to receive
		  ' a new instance of ImageRecognition containing the generated reply to that message.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.ImageRecognition.GenerateNext
		  
		  ChatLog.AddMessage(Role, Content, ImageURL)
		  Dim request As New OpenAI.Request
		  If Model = Nil Then Model = "gpt-4o"
		  request.Model = Model
		  request.Messages = ChatLog
		  request.MaxTokens = MaxTokens
		  Return ImageRecognition.CreateNext(request, mClient)
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Note
			When enabled, requests will be checked for basic sanity (using the IsValid() shared method) before
			being sent over the wire. This check is not fool-proof. Please report any requests that give false
			positives/negatives
		#tag EndNote
		#tag Getter
			Get
			  Return ValidationOpt And Response.Prevalidate
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ValidationOpt = value
			End Set
		#tag EndSetter
		Shared Prevalidate As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private Shared ValidationOpt As Boolean = True
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="ID"
			Group="Behavior"
			Type="String"
			InheritedFrom="OpenAI.Response"
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
			Name="PromptTokenCount"
			Group="Behavior"
			Type="Integer"
			InheritedFrom="OpenAI.Response"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ReplyTokenCount"
			Group="Behavior"
			Type="Integer"
			InheritedFrom="OpenAI.Response"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ResultCount"
			Group="Behavior"
			Type="Integer"
			InheritedFrom="OpenAI.Response"
		#tag EndViewProperty
		#tag ViewProperty
			Name="RevisedPrompt"
			Group="Behavior"
			Type="String"
			InheritedFrom="OpenAI.Response"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TokenCount"
			Group="Behavior"
			Type="Integer"
			InheritedFrom="OpenAI.Response"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			InheritedFrom="Object"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
