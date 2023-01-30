#tag Class
Protected Class Completion
Inherits OpenAI.Response
	#tag Method, Flags = &h0
		 Shared Function Create(Model As OpenAI.Model, Prompt As String, Suffix As String, MaxTokens As Integer, Temperature As Single, Top_P As Integer, ResultCount As Integer, LogProbs As Integer, Echo As Boolean, Stop As String, PresencePenalty As Integer, FrequencyPenalty As Integer, BestOf As Integer, LogItBias As JSONItem, User As String) As OpenAI.Completion
		  Dim request As New OpenAI.Request()
		  If Model = Nil Then Model = OpenAI.Model.GetByName("text-davinci-003")
		  request.Model = Model
		  request.Prompt = Prompt
		  If BestOf <> 0 Then request.BestOf = BestOf
		  If Echo Then request.Echo = Echo
		  If FrequencyPenalty > 0.01 Then request.FrequencyPenalty = FrequencyPenalty
		  If LogItBias <> Nil Then request.LogItBias = LogItBias
		  If LogProbs <> 0 Then request.LogProbabilities = LogProbs
		  If MaxTokens <> 16 Then request.MaxTokens = MaxTokens
		  If ResultCount > 1 Then request.NumberOfResults = ResultCount
		  If PresencePenalty > 0.01 Then request.PresencePenalty = PresencePenalty
		  If Stop <> "" Then request.Stop = Stop
		  If Suffix <> "" Then request.Suffix = Suffix
		  If Temperature > 0.01 Then request.Temperature = Temperature
		  If Top_P > 0.01 Then request.Top_P = Top_P
		  If User <> "" Then request.User = User
		  Dim response As JSONItem = SendRequest("/v1/completions", request)
		  Return New CompletionCreator(response)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Create(Prompt As String, ResultCount As Integer = 1, Model As OpenAI.Model = Nil) As OpenAI.Completion
		  Return Completion.Create(Model, Prompt, "", 16, 0.0, 0, ResultCount, 0, False, "", 0, 0, 0, Nil, "")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Edit(Model As OpenAI.Model, TextToEdit As String, EditInstruction As String, Temperature As Single, Top_P As Integer, ResultCount As Integer, User As String) As OpenAI.Completion
		  Dim request As New OpenAI.Request
		  If Model = Nil Then Model = OpenAI.Model.GetByName("text-davinci-edit-001")
		  request.Model = Model
		  request.Input = TextToEdit
		  request.Instruction = EditInstruction
		  If ResultCount > 1 Then request.NumberOfResults = ResultCount
		  If Temperature > 0.01 Then request.Temperature = Temperature
		  If Top_P > 0.01 Then request.Top_P = Top_P
		  If User <> "" Then request.User = User
		  
		  Dim response As JSONItem = SendRequest("/v1/edits", request)
		  Return New CompletionCreator(response)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Edit(TextToEdit As String, EditInstruction As String, ResultCount As Integer = 1, Model As OpenAI.Model = Nil) As OpenAI.Completion
		  Return Completion.Edit(Model, TextToEdit, EditInstruction, 0.0, 0, ResultCount, "")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetResult(Index As Integer) As Variant
		  Dim results As JSONItem = Super.GetResult(Index)
		  If results.HasName("text") Then
		    Return DefineEncoding(results.Value("text"), Encodings.UTF8)
		  End If
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
