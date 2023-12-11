#tag Class
Protected Class ChatCompletion
Inherits OpenAI.Response
	#tag Method, Flags = &h1001
		Protected Sub Constructor(ResponseData As JSONItem, Client As OpenAIClient, ChatLog As OpenAI.ChatCompletionData)
		  // Calling the overridden superclass constructor.
		  // Constructor(ResponseData As JSONItem, Client As OpenAIClient) -- From Response
		  Super.Constructor(ResponseData, Client)
		  mChatLog = ChatLog
		  ChatLog.AddMessage(GetResultRole, GetResult)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Create(Optional ChatLog As OpenAI.ChatCompletionData, Role As String, Content As String, Model As OpenAI.Model = Nil) As OpenAI.ChatCompletion
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
		  Dim client As New OpenAIClient
		  Dim response As JSONItem = Response.CreateRaw(client, "/v1/chat/completions", request)
		  If response = Nil Or response.HasName("error") Then Raise New OpenAIException(response)
		  Dim msgs As JSONItem = Request.Messages
		  Return New OpenAI.ChatCompletion(response, client, New ChatCompletionData(msgs))
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function CreateNext(Request As OpenAI.Request, Client As OpenAIClient) As OpenAI.ChatCompletion
		  If ChatCompletion.Prevalidate Then
		    Dim err As ValidationError = ChatCompletion.IsValid(Request)
		    If err <> ValidationError.None Then Raise New OpenAIException(err)
		  End If
		  Dim response As JSONItem = Response.CreateRaw(Client, "/v1/chat/completions", request)
		  If response = Nil Or response.HasName("error") Then Raise New OpenAIException(response)
		  Dim msgs As JSONItem = Request.Messages
		  Return New OpenAI.ChatCompletion(response, Client, New ChatCompletionData(msgs))
		  
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
		  Return results.Value("content")
		  
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
		  If Request.FileName <> "" Then Return ValidationError.FileName
		  If Request.FineTuneID <> "" Then Return ValidationError.FineTuneID
		  ' If Request.FrequencyPenalty > 0.00001 Then Return ValidationError.FrequencyPenalty
		  If Request.IsSet("quality") Then Return ValidationError.HighQuality
		  If Request.Input <> "" Then Return ValidationError.Input
		  If Request.Instruction <> "" Then Return ValidationError.Instruction
		  If Request.Language <> "" Then Return ValidationError.Language
		  If Request.LearningRateMultiplier > 0.00001 Then Return ValidationError.LearningRateMultiplier
		  ' If Request.LogItBias <> Nil Then Return ValidationError.LogItBias
		  If Request.LogProbabilities > 0 Then Return ValidationError.LogProbabilities
		  ' If Request.LogProbabilities > 0 Then
		  If Request.Messages = Nil Then Return ValidationError.Messages ' required
		  ' If Request.Model <> Nil And Not Request.Model.AllowLogProbs Then Return ValidationError.LogProbabilities
		  ' End If
		  If Request.MaskImage <> Nil Then Return ValidationError.MaskImage
		  If Request.MaxTokens > 4096 Then Return ValidationError.MaxTokens
		  If Request.Model = Nil Then Return ValidationError.Model ' required
		  If Request.Model.Endpoint <> "/v1/chat/completions" Then Return ValidationError.Model
		  If Request.NumberOfEpochs <> 1 Then Return ValidationError.NumberOfEpochs
		  If Request.NumberOfResults < 1 Then Return ValidationError.NumberOfResults
		  ' If Request.PresencePenalty > 0.00001 Then Return ValidationError.PresencePenalty
		  If Request.Prompt <> "" Then Return ValidationError.Prompt
		  If Request.PromptLossWeight > 0.00001 Then Return ValidationError.PromptLossWeight
		  If Request.Purpose <> "" Then Return ValidationError.Purpose
		  If Request.ResultsAsBase64 = True Then Return ValidationError.ResultsAsType
		  If Request.ResultsAsJSON = True Then Return ValidationError.ResultsAsType
		  If Request.ResultsAsJSON_Verbose = True Then Return ValidationError.ResultsAsType
		  If Request.ResultsAsSRT = True Then Return ValidationError.ResultsAsType
		  If Request.ResultsAsText = True Then Return ValidationError.ResultsAsType
		  If Request.ResultsAsURL = True Then Return ValidationError.ResultsAsURL
		  If Request.ResultsAsVTT = True Then Return ValidationError.ResultsAsType
		  If Request.Size <> "" Then Return ValidationError.Size
		  If Request.SourceImage <> Nil Then Return ValidationError.SourceImage
		  ' If Request.Stop <> "" Then Return ValidationError.Stop
		  If Request.IsSet("style") Then Return ValidationError.Style
		  If Request.Suffix <> "" Then Return ValidationError.Suffix
		  ' If Request.Temperature > 0.00001 Then Return ValidationError.Temperature
		  ' If Request.Top_P > 0.00001 Then Return ValidationError.Top_P
		  If Request.TrainingFile <> "" Then Return ValidationError.TrainingFile
		  If Request.ValidationFile <> "" Then Return ValidationError.ValidationFile
		  Return ValidationError.None
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

	#tag Property, Flags = &h21
		Private mChatLog As OpenAI.ChatCompletionData
	#tag EndProperty

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
