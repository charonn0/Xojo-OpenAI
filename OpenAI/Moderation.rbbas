#tag Class
Protected Class Moderation
Inherits OpenAI.Response
	#tag Method, Flags = &h1001
		Protected Sub Constructor(ResponseData As JSONItem, Client As OpenAIClient)
		  // Calling the overridden superclass constructor.
		  // Constructor(ResponseData As JSONItem, Client As OpenAIClient) -- From Response
		  Super.Constructor(ResponseData, Client)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Create(Request As OpenAI.Request) As OpenAI.Moderation
		  Dim client As New OpenAIClient
		  Dim result As New JSONItem(client.SendRequest("/v1/moderations", Request))
		  If result = Nil Or result.HasName("error") Then Raise New OpenAIException(result)
		  Return New OpenAI.Moderation(result, client)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Create(Prompt As String, Model As OpenAI.Model = Nil) As OpenAI.Moderation
		  Dim request As New OpenAI.Request
		  If Model = Nil Then Model = OpenAI.Model.Lookup("text-moderation-stable")
		  request.Model = Model
		  request.Input = Prompt
		  Return Moderation.Create(request)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetResult(Index As Integer = 0) As Variant
		  Return Super.GetResult(Index)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function IsValid(Request As OpenAI.Request) As Boolean
		  If Request.BatchSize <> 1 Then Return False
		  If Request.BestOf <> 1 Then Return False
		  If Request.ClassificationBetas <> Nil Then Return False
		  If Request.ClassificationNClasses <> 1 Then Return False
		  If Request.ClassificationPositiveClass <> "" Then Return False
		  If Request.ComputeClassificationMetrics <> False Then Return False
		  ' If Request.Echo <> False Then Return False
		  If Request.File <> Nil Then Return False
		  If Request.FileName <> "" Then Return False
		  ' If Request.FineTuneID <> "" Then Return False
		  If Request.FrequencyPenalty > 0.00001 Then Return False
		  If Request.Input = "" Then Return False ' required
		  If Request.Instruction <> "" Then Return False
		  If Request.LearningRateMultiplier > 0.00001 Then Return False
		  If Request.LogItBias <> Nil Then Return False
		  If Request.LogProbabilities <> 0 Then Return False
		  If Request.MaskImage <> Nil Then Return False
		  If Request.MaxTokens >= 0 Then Return False
		  ' If Request.MaxTokens >= 2048 Then Return False
		  If Request.Model = Nil Then Return False ' required
		  If Request.NumberOfEpochs <> 1 Then Return False
		  If Request.NumberOfResults <> 1 Then Return False
		  If Request.PresencePenalty > 0.00001 Then Return False
		  If Request.Prompt <> "" Then Return False
		  If Request.PromptLossWeight > 0.00001 Then Return False
		  If Request.Purpose <> "" Then Return False
		  If Request.ResultsAsURL = True Then Return False
		  If Request.Size <> "" Then Return False
		  If Request.SourceImage <> Nil Then Return False
		  If Request.Stop <> "" Then Return False
		  If Request.Suffix <> "" Then Return False
		  If Request.Temperature > 0.00001 Then Return False
		  If Request.Top_P > 0.00001 Then Return False
		  If Request.TrainingFile <> "" Then Return False
		  If Request.ValidationFile <> "" Then Return False
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ResultType(Index As Integer = 0) As OpenAI.ResultType
		  #pragma Unused Index
		  Return OpenAI.ResultType.JSONObject
		End Function
	#tag EndMethod


	#tag ViewBehavior
		#tag ViewProperty
			Name="Bytes"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ID"
			Group="Behavior"
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
			Name="Purpose"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
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
		#tag ViewProperty
			Name="Type"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
