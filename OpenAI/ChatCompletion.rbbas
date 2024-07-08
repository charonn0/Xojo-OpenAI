#tag Class
Protected Class ChatCompletion
Inherits OpenAI.Response
	#tag Method, Flags = &h0
		Sub Constructor(ResponseData As JSONItem, Optional ChatLogData As JSONItem)
		  ' Loads a previously created chat completion and chat log that were stored as JSON.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.ChatCompletion.Constructor
		  
		  // Calling the overridden superclass constructor.
		  // Constructor(ResponseData As JSONItem, Client As OpenAIClient, OriginalRequest As OpenAI.Request) -- From Response
		  Super.Constructor(ResponseData, New OpenAIClient, Nil)
		  If ChatLogData <> Nil Then
		    mChatLog = New ChatCompletionData(ChatLogData)
		  Else
		    mChatLog = New ChatCompletionData()
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1001
		Protected Sub Constructor(ResponseData As JSONItem, Client As OpenAIClient, ChatLog As OpenAI.ChatCompletionData, OriginalRequest As OpenAI.Request)
		  // Calling the overridden superclass constructor.
		  // Constructor(ResponseData As JSONItem, Client As OpenAIClient, OriginalRequest As OpenAI.Request) -- From Response
		  Super.Constructor(ResponseData, Client, OriginalRequest)
		  mChatLog = ChatLog
		  ChatLog.AddMessage(GetResultRole, GetResult)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Create(ChatLog As OpenAI.ChatCompletionData, Role As String, Content As String, Model As OpenAI.Model = Nil) As OpenAI.ChatCompletion
		  ' Starts a new chat. ChatLog contains zero or more messages representing the context of
		  ' the conversation so far. Role is the name of the entity that is speaking (one of "user",
		  ' "assistant", and "system"). Content is the message they are sending to the chat.
		  '
		  ' Returns a new instance of ChatCompletion containing the generated reply to that message.
		  ' Call GenerateNext() on that instance to continue the conversation in context.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.ChatCompletion.Create
		  ' https://platform.openai.com/docs/api-reference/chat/create
		  
		  If ChatLog = Nil Then ChatLog = New ChatCompletionData()
		  ChatLog.AddMessage(Role, Content)
		  Dim request As New OpenAI.Request
		  If Model = Nil Then Model = "gpt-4"
		  request.Model = Model
		  request.Messages = ChatLog
		  Return ChatCompletion.Create(request)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Create(Request As OpenAI.Request) As OpenAI.ChatCompletion
		  ' Starts a new chat according to the Request's parameters. Returns a new instance of ChatCompletion
		  ' containing the generated reply to that message. Call GenerateNext() on that instance to continue
		  ' the conversation in context.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.ChatCompletion.Create
		  ' https://platform.openai.com/docs/api-reference/chat/create
		  
		  If ChatCompletion.Prevalidate Then
		    Dim err As ValidationError = ChatCompletion.IsValid(Request)
		    If err <> ValidationError.None Then Raise New OpenAIException(err)
		  End If
		  
		  If LogProbs And Request.Model.ID <> "gpt-4-vision-preview" Then
		    Request.LogProbabilities = True
		    Request.TopLogProbabilities = NumAlternates
		  End If
		  
		  Dim client As New OpenAIClient
		  Dim result As JSONItem = Response.CreateRaw(client, "/v1/chat/completions", request)
		  If result = Nil Or result.HasName("error") Then Raise New OpenAIException(result)
		  If Not result.HasName("model") And Request.Model <> Nil Then result.Value("model") = Request.Model.ID
		  Dim msgs As JSONItem = Request.Messages
		  Return New OpenAI.ChatCompletion(result, client, New ChatCompletionData(msgs), Request)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Create(Role As String, Content As String, Model As OpenAI.Model = Nil) As OpenAI.ChatCompletion
		  ' Starts a new chat. Role is the name of the entity that is speaking (one of "user",
		  ' "assistant", and "system"). Content is the message they are sending to the chat.
		  '
		  ' Returns a new instance of ChatCompletion containing the generated reply to that message.
		  ' Call GenerateNext() on that instance to continue the conversation in context.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.ChatCompletion.Create
		  ' https://platform.openai.com/docs/api-reference/chat/create
		  
		  Dim chatlog As New ChatCompletionData()
		  Return ChatCompletion.Create(chatlog, Role, Content, Model)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function CreateNext(Request As OpenAI.Request, Client As OpenAIClient) As OpenAI.ChatCompletion
		  If ChatCompletion.Prevalidate Then
		    Dim err As ValidationError = ChatCompletion.IsValid(Request)
		    If err <> ValidationError.None Then Raise New OpenAIException(err)
		  End If
		  If LogProbs And Request.Model.ID <> "gpt-4-vision-preview" Then
		    Request.LogProbabilities = True
		    Request.TopLogProbabilities = NumAlternates
		  End If
		  
		  Dim response As JSONItem = Response.CreateRaw(Client, "/v1/chat/completions", Request)
		  If response = Nil Or response.HasName("error") Then Raise New OpenAIException(response)
		  Dim msgs As JSONItem = Request.Messages
		  Return New OpenAI.ChatCompletion(response, Client, New ChatCompletionData(msgs), Request)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GenerateNext(Role As String, Content As String, Model As OpenAI.Model = Nil) As OpenAI.ChatCompletion
		  ' Pass the Role and Content of the next chat message to receive a new instance of ChatCompletion
		  ' containing the generated reply to that message.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.ChatCompletion.GenerateNext
		  
		  ChatLog.AddMessage(Role, Content)
		  Dim request As New OpenAI.Request
		  If Model = Nil Then Model = "gpt-4"
		  request.Model = Model
		  request.Messages = ChatLog
		  Return ChatCompletion.CreateNext(request, mClient)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetResult(Index As Integer = 0) As Variant
		  ' Returns the message at Index, as a string.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Response.GetResult
		  
		  Dim results As JSONItem = Super.GetResult(Index)
		  results = results.Value("message")
		  Dim txt As String = results.Value("content")
		  txt = DefineEncoding(txt, Encodings.UTF8)
		  Return txt
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetResultRole(Index As Integer = 0) As String
		  ' Returns the role part of the message at Index, as a String.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.ChatCompletion.GetResultRole
		  
		  Dim results As JSONItem = Super.GetResult(Index)
		  results = results.Value("message")
		  Return results.Value("role")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetResultType() As OpenAI.ResultType
		  Return OpenAI.ResultType.String
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function IsValid(Request As OpenAI.Request) As OpenAI.ValidationError
		  If Request.BatchSize <> 1 Then Return ValidationError.BatchSize
		  If Request.BestOf <> 1 Then Return ValidationError.BestOf
		  If Request.ClassificationBetas <> Nil Then Return ValidationError.ClassificationBetas
		  If Request.ClassificationNClasses <> 1 Then Return ValidationError.ClassificationNClasses
		  If Request.ClassificationPositiveClass <> "" Then Return ValidationError.ClassificationPositiveClass
		  If Request.ComputeClassificationMetrics <> False Then Return ValidationError.ComputeClassificationMetrics
		  If Request.Echo <> False Then Return ValidationError.Echo
		  If Request.File <> Nil Then Return ValidationError.File
		  ' If Request.File.Size > 1024 * 1024 * 25 Then Return ValidationError.File ' 25MB file size limit.
		  If Request.FileName <> "" Then Return ValidationError.FileName
		  If Request.FileMIMEType <> "" Then Return ValidationError.FileMIMEType
		  If Request.FineTuneID <> "" Then Return ValidationError.FineTuneID
		  ' If Request.FrequencyPenalty > 0.00001 Then Return ValidationError.FrequencyPenalty
		  If Request.IsSet("quality") Then Return ValidationError.HighQuality
		  If Request.Input <> "" Then Return ValidationError.Input
		  If Request.Instruction <> "" Then Return ValidationError.Instruction
		  If Request.Language <> "" Then Return ValidationError.Language
		  If Request.LearningRateMultiplier > 0.00001 Then Return ValidationError.LearningRateMultiplier
		  ' If Request.LogItBias <> Nil Then Return ValidationError.LogItBias
		  ' If Request.IsSet("logprobs") Then Return ValidationError.LogProbabilities
		  If Request.MaskImage <> Nil Then Return ValidationError.MaskImage
		  ' If Request.MaxTokens > 0 Then Return ValidationError.MaxTokens
		  If Request.Model = Nil Then Return ValidationError.Model ' required
		  If Request.NumberOfEpochs <> 1 Then Return ValidationError.NumberOfEpochs
		  ' If Request.NumberOfResults <> 1 Then Return ValidationError.NumberOfResults
		  ' If Request.PresencePenalty > 0.00001 Then Return ValidationError.PresencePenalty
		  ' If Request.Prompt <> "" Then Return ValidationError.Prompt
		  If Request.PromptLossWeight > 0.00001 Then Return ValidationError.PromptLossWeight
		  If Request.Purpose <> "" Then Return ValidationError.Purpose
		  If Request.ResultsAsBase64 = True Then Return ValidationError.ResultsAsType
		  If Request.ResultsAsJSON = True Then Return ValidationError.ResultsAsType
		  If Request.ResultsAsJSON_Verbose = True Then Return ValidationError.ResultsAsType
		  If Request.ResultsAsSRT = True Then Return ValidationError.ResultsAsType
		  If Request.ResultsAsText = True Then Return ValidationError.ResultsAsType
		  If Request.ResultsAsURL = True Then Return ValidationError.ResultsAsURL
		  If Request.ResultsAsVTT = True Then Return ValidationError.ResultsAsType
		  If Request.ResultsAsMP3 = True Then Return ValidationError.ResultsAsType
		  If Request.ResultsAsOpus = True Then Return ValidationError.ResultsAsType
		  If Request.ResultsAsAAC = True Then Return ValidationError.ResultsAsType
		  If Request.ResultsAsFLAC = True Then Return ValidationError.ResultsAsType
		  If Request.Size <> "" Then Return ValidationError.Size
		  If Request.IsSet("speed") Then Return ValidationError.Speed
		  If Request.SourceImage <> Nil Then Return ValidationError.SourceImage
		  ' If Request.Stop <> "" Then Return ValidationError.Stop
		  If Request.IsSet("style") Then Return ValidationError.Style
		  If Request.Suffix <> "" Then Return ValidationError.Suffix
		  ' If Request.Temperature > 0.00001 Then Return ValidationError.Temperature
		  ' If Request.Top_P > 0.00001 Then Return ValidationError.Top_P
		  If Request.TrainingFile <> "" Then Return ValidationError.TrainingFile
		  If Request.ValidationFile <> "" Then Return ValidationError.ValidationFile
		  If Request.Voice <> "" Then Return ValidationError.Voice
		  Return ValidationError.None
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Tokens(ResultIndex As Integer = 0) As OpenAI.TokenEngine
		  ' A reference to a TokenEngine object containing token usage statistics for the result
		  ' at ResultIndex. Not all endpoints provide token information. Set ChatCompletion.LogProbabilities=True
		  ' in your request to enable this on endpoints that support it. Set ChatCompletion.NumberOfAlternates to
		  ' specify how many alternate tokens to return.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Response.Tokens
		  
		  If UBound(mTokens) = -1 Then
		    For i As Integer = 0 To Me.ResultCount - 1
		      If HasResultAttribute(i, "logprobs") Then
		        mTokens.Append(New TokenEngineCreator(Me, i))
		      End If
		    Next
		  End If
		  If UBound(mTokens) > -1 Then Return mTokens(ResultIndex)
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' Returns an instance of ChatCompletionData containing the conversation so far. 
			  '
			  ' See:
			  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.ChatCompletion.ChatLog
			  
			  return mChatLog
			End Get
		#tag EndGetter
		ChatLog As OpenAI.ChatCompletionData
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Note
			When enabled, requests will automatically set the Request.LogProbabilities property on all Requests to True
			and set the Request.TopLogProbabilities property to the number specified by NumberOfAlternates.
		#tag EndNote
		#tag Getter
			Get
			  Return LogProbs
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  LogProbs = value
			End Set
		#tag EndSetter
		Shared LogProbabilities As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private Shared LogProbs As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mChatLog As OpenAI.ChatCompletionData
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTokens() As OpenAI.TokenEngine
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Shared NumAlternates As Integer = 5
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Note
			When the LogProbabilities property is enabled, the Request.LogProbabilities property on all Requests will be set to True
			and the Request.TopLogProbabilities property is set to the number specified by this property.
		#tag EndNote
		#tag Getter
			Get
			  Return NumAlternates
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  NumAlternates = value
			End Set
		#tag EndSetter
		Shared NumberOfAlternates As Integer
	#tag EndComputedProperty

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

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mResponse.HasName("usage") Then
			    Dim usage As JSONItem = mResponse.Value("usage")
			    Return usage.Lookup("prompt_tokens", 0)
			  End If
			  
			  Exception err As KeyNotFoundException
			    Return 0
			End Get
		#tag EndGetter
		PromptTokenCount As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mResponse.HasName("usage") Then
			    Dim usage As JSONItem = mResponse.Value("usage")
			    Return usage.Lookup("completion_tokens", 0)
			  End If
			  
			  Exception err As KeyNotFoundException
			    Return 0
			End Get
		#tag EndGetter
		ReplyTokenCount As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mResponse.HasName("usage") Then
			    Dim usage As JSONItem = mResponse.Value("usage")
			    Return usage.Lookup("total_tokens", 0)
			  End If
			  
			  Exception err As KeyNotFoundException
			    Return 0
			End Get
		#tag EndGetter
		TotalTokenCount As Integer
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
