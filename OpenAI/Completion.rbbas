#tag Class
Protected Class Completion
Inherits OpenAI.Response
	#tag Method, Flags = &h1001
		Protected Sub Constructor(ResponseData As JSONItem, Client As OpenAIClient)
		  // Calling the overridden superclass constructor.
		  // Constructor(ResponseData As JSONItem, Client As OpenAIClient) -- From Response
		  Super.Constructor(ResponseData, Client)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Create(Request As OpenAI.Request) As OpenAI.Completion
		  ' Given a prompt, the model will return one or more predicted completions, and can also
		  ' return the probabilities of alternative tokens at each position.
		  ' 
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Completion.Create
		  ' https://beta.openai.com/docs/api-reference/completions
		  
		  If Completion.Prevalidate Then
		    Dim err As ValidationError = Completion.IsValid(Request)
		    If err <> ValidationError.None Then Raise New OpenAIException(err)
		  End If
		  Dim client As New OpenAIClient
		  Dim response As JSONItem = Response.CreateRaw(client, "/v1/completions", request)
		  If response = Nil Or response.HasName("error") Then Raise New OpenAIException(response)
		  Return New OpenAI.Completion(response, client)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Create(Prompt As String, ResultCount As Integer = 1, Model As OpenAI.Model = Nil) As OpenAI.Completion
		  ' Given a prompt, the model will return one or more predicted completions.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Completion.Create
		  ' https://beta.openai.com/docs/api-reference/completions
		  
		  Dim request As New OpenAI.Request()
		  If Model = Nil Then Model = OpenAI.Model.Lookup("text-davinci-003")
		  request.Model = Model
		  request.Prompt = Prompt
		  If ResultCount > 1 Then request.NumberOfResults = ResultCount
		  Return Completion.Create(request)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Edit(Request As OpenAI.Request) As OpenAI.Completion
		  ' Given a prompt and an instruction, the model will return an edited version of the prompt.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Completion.Edit
		  ' https://beta.openai.com/docs/api-reference/edits
		  
		  
		  If Completion.Prevalidate Then
		    Dim err As ValidationError = Completion.IsValid(Request)
		    If err <> ValidationError.None Then Raise New OpenAIException(err)
		  End If
		  Dim client As New OpenAIClient
		  Dim response As JSONItem = Response.CreateRaw(client, "/v1/edits", request)
		  If response = Nil Or response.HasName("error") Then Raise New OpenAIException(response)
		  Return New OpenAI.Completion(response, client)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Edit(TextToEdit As String, EditInstruction As String, ResultCount As Integer = 1, Model As OpenAI.Model = Nil) As OpenAI.Completion
		  ' Given a prompt and an instruction, the model will return an edited version of the prompt.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Completion.Edit
		  ' https://beta.openai.com/docs/api-reference/edits
		  
		  Dim request As New OpenAI.Request
		  If Model = Nil Then Model = OpenAI.Model.Lookup("text-davinci-edit-001")
		  request.Model = Model
		  request.Input = TextToEdit
		  request.Instruction = EditInstruction
		  If ResultCount > 1 Then request.NumberOfResults = ResultCount
		  Return Completion.Edit(request)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetResult(Index As Integer = 0) As Variant
		  ' Returns the result at Index, as a String.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Response.GetResult
		  
		  Dim results As JSONItem = Super.GetResult(Index)
		  If results.HasName("text") Then
		    Return DefineEncoding(results.Value("text"), Encodings.UTF8)
		  End If
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
		  ' If Request.BestOf <> 1 Then Return ValidationError.BestOf
		  If Request.ClassificationBetas <> Nil Then Return ValidationError.ClassificationBetas
		  If Request.ClassificationNClasses <> 1 Then Return ValidationError.ClassificationNClasses
		  If Request.ClassificationPositiveClass <> "" Then Return ValidationError.ClassificationPositiveClass
		  If Request.ComputeClassificationMetrics <> False Then Return ValidationError.ComputeClassificationMetrics
		  ' If Request.Echo <> False Then Return ValidationError.Echo
		  If Request.File <> Nil Then Return ValidationError.File
		  If Request.FileName <> "" Then Return ValidationError.FileName
		  ' If Request.FineTuneID <> "" Then Return ValidationError.FineTuneID
		  ' If Request.FrequencyPenalty > 0.00001 Then Return ValidationError.FrequencyPenalty
		  ' If Request.Input = "" Then Return ValidationError.Input ' required
		  ' If Request.Instruction <> "" Then Return ValidationError.Instruction
		  If Request.Language <> "" Then Return ValidationError.Language
		  If Request.LearningRateMultiplier > 0.00001 Then Return ValidationError.LearningRateMultiplier
		  ' If Request.LogItBias <> Nil Then Return ValidationError.LogItBias
		  If Request.LogProbabilities > 5 Then Return ValidationError.LogProbabilities
		  If Request.LogProbabilities > 0 Then
		    If Request.Model <> Nil And Not Request.Model.AllowLogProbs Then Return ValidationError.LogProbabilities
		  End If
		  If Request.MaskImage <> Nil Then Return ValidationError.MaskImage
		  If Request.MaxTokens > 4097 Then Return ValidationError.MaxTokens ' newer Models can do 4096
		  If Request.Model = Nil Then Return ValidationError.Model ' required
		  If Request.Model.Endpoint <> "/v1/completions" Then Return ValidationError.Model
		  If Request.NumberOfEpochs <> 1 Then Return ValidationError.NumberOfEpochs
		  If Request.NumberOfResults < 1 Then Return ValidationError.NumberOfResults
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
		  If Request.Size <> "" Then Return ValidationError.Size
		  If Request.SourceImage <> Nil Then Return ValidationError.SourceImage
		  ' If Request.Stop <> "" Then Return ValidationError.Stop
		  If Request.Suffix <> "" Then Return ValidationError.Suffix
		  ' If Request.Temperature > 0.00001 Then Return ValidationError.Temperature
		  ' If Request.Top_P > 0.00001 Then Return ValidationError.Top_P
		  If Request.TrainingFile <> "" Then Return ValidationError.TrainingFile
		  If Request.ValidationFile <> "" Then Return ValidationError.ValidationFile
		  Return ValidationError.None
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
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			InheritedFrom="Object"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
