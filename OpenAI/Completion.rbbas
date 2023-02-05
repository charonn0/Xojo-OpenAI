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
		  
		  Dim client As New OpenAIClient
		  Dim response As New JSONItem(client.SendRequest("/v1/completions", request))
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
		  
		  
		  Dim client As New OpenAIClient
		  Dim response As New JSONItem(client.SendRequest("/v1/edits", request))
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

	#tag Method, Flags = &h0
		 Shared Function IsValid(Request As OpenAI.Request) As Boolean
		  If Request.BatchSize <> 1 Then Return False
		  ' If Request.BestOf <> 1 Then Return False
		  If Request.ClassificationBetas <> Nil Then Return False
		  If Request.ClassificationNClasses <> 1 Then Return False
		  If Request.ClassificationPositiveClass <> "" Then Return False
		  If Request.ComputeClassificationMetrics <> False Then Return False
		  ' If Request.Echo <> False Then Return False
		  If Request.File <> Nil Then Return False
		  If Request.FileName <> "" Then Return False
		  ' If Request.FineTuneID <> "" Then Return False
		  ' If Request.FrequencyPenalty > 0.00001 Then Return False
		  ' If Request.Input = "" Then Return False ' required
		  ' If Request.Instruction <> "" Then Return False
		  If Request.LearningRateMultiplier > 0.00001 Then Return False
		  ' If Request.LogItBias <> Nil Then Return False
		  ' If Request.LogProbabilities <> 0 Then Return False
		  If Request.MaskImage <> Nil Then Return False
		  If Request.MaxTokens >= 2048 Then Return False ' newer Models can do 4096
		  If Request.Model = Nil Then Return False ' required
		  If Request.NumberOfEpochs <> 1 Then Return False
		  If Request.NumberOfResults > 0 Then Return False
		  ' If Request.PresencePenalty > 0.00001 Then Return False
		  ' If Request.Prompt <> "" Then Return False
		  If Request.PromptLossWeight > 0.00001 Then Return False
		  If Request.Purpose <> "" Then Return False
		  If Request.ResultsAsURL = True Then Return False
		  If Request.Size <> "" Then Return False
		  If Request.SourceImage <> Nil Then Return False
		  ' If Request.Stop <> "" Then Return False
		  If Request.Suffix <> "" Then Return False
		  ' If Request.Temperature > 0.00001 Then Return False
		  ' If Request.Top_P > 0.00001 Then Return False
		  If Request.TrainingFile <> "" Then Return False
		  If Request.ValidationFile <> "" Then Return False
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ResultType(Index As Integer = 0) As OpenAI.ResultType
		  #pragma Unused Index
		  Return OpenAI.ResultType.String
		End Function
	#tag EndMethod


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
