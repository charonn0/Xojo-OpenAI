#tag Class
Protected Class Moderation
Inherits OpenAI.Response
	#tag Method, Flags = &h0
		Sub Constructor(ResponseData As JSONItem)
		  ' Loads a previously created Response that was stored as JSON using Response.ToString()
		  ' The OriginalRequest property will be Nil in re-loaded Responses.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Response.Constructor
		  
		  // Calling the overridden superclass constructor.
		  // Constructor(ResponseData As JSONItem, Client As OpenAIClient, OriginalRequest As OpenAI.Request) -- From Response
		  Super.Constructor(ResponseData, New OpenAIClient, Nil)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1001
		Protected Sub Constructor(ResponseData As JSONItem, Client As OpenAIClient, OriginalRequest As OpenAI.Request)
		  // Calling the overridden superclass constructor.
		  // Constructor(ResponseData As JSONItem, Client As OpenAIClient, OriginalRequest As OpenAI.Request) -- From Response
		  Super.Constructor(ResponseData, Client, OriginalRequest)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Create(Request As OpenAI.Request) As OpenAI.Moderation
		  ' Sends the Prompt text to the AI for an analysis of offensive content.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Moderation.Create
		  ' https://platform.openai.com/docs/api-reference/moderations/create
		  
		  If Moderation.Prevalidate Then
		    Dim err As ValidationError = Moderation.IsValid(Request)
		    If err <> ValidationError.None Then Raise New OpenAIException(err)
		  End If
		  Dim client As New OpenAIClient
		  Dim result As JSONItem = Response.CreateRaw(client, "/v1/moderations", Request)
		  If result = Nil Or result.HasName("error") Then Raise New OpenAIException(result)
		  If Not result.HasName("model") And Request.Model <> Nil Then result.Value("model") = Request.Model.ID
		  Return New OpenAI.Moderation(result, client, Request)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Create(Prompt As String, Model As OpenAI.Model = Nil) As OpenAI.Moderation
		  ' Sends the Prompt text to the AI for an analysis of offensive content.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Moderation.Create
		  ' https://platform.openai.com/docs/api-reference/moderations/create
		  
		  Dim request As New OpenAI.Request
		  If Model = Nil Then Model = OpenAI.Model.Lookup("text-moderation-stable")
		  request.Model = Model
		  request.Input = Prompt
		  Return Moderation.Create(request)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetResponseFormat() As String
		  Return "json"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetResult(Index As Integer = 0) As Variant
		  Return Super.GetResult(Index)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetResultType() As OpenAI.ResultType
		  Return OpenAI.ResultType.JSONObject
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
		  If Request.FrequencyPenalty > 0.00001 Then Return ValidationError.FrequencyPenalty
		  If Request.IsSet("quality") Then Return ValidationError.HighQuality
		  If Request.Input = "" Then Return ValidationError.Input ' required
		  If Request.Instruction <> "" Then Return ValidationError.Instruction
		  If Request.Language <> "" Then Return ValidationError.Language
		  If Request.LearningRateMultiplier > 0.00001 Then Return ValidationError.LearningRateMultiplier
		  If Request.LogItBias <> Nil Then Return ValidationError.LogItBias
		  If Request.IsSet("logprobs") Then Return ValidationError.LogProbabilities
		  If Request.MaskImage <> Nil Then Return ValidationError.MaskImage
		  If Request.MaxTokens > 0 Then Return ValidationError.MaxTokens
		  ' If Request.Model = Nil Then Return ValidationError.Model ' required
		  If Request.NumberOfEpochs > 1 Then Return ValidationError.NumberOfEpochs
		  If Request.NumberOfResults > 1 Then Return ValidationError.NumberOfResults
		  If Request.PresencePenalty > 0.00001 Then Return ValidationError.PresencePenalty
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
		  If Request.ResultsAsMP3 = True Then Return ValidationError.ResultsAsType
		  If Request.ResultsAsOpus = True Then Return ValidationError.ResultsAsType
		  If Request.ResultsAsAAC = True Then Return ValidationError.ResultsAsType
		  If Request.ResultsAsFLAC = True Then Return ValidationError.ResultsAsType
		  If Request.Size <> "" Then Return ValidationError.Size
		  If Request.IsSet("speed") Then Return ValidationError.Speed
		  If Request.SourceImage <> Nil Then Return ValidationError.SourceImage
		  If Request.Stop <> "" Then Return ValidationError.Stop
		  If Request.IsSet("style") Then Return ValidationError.Style
		  If Request.Suffix <> "" Then Return ValidationError.Suffix
		  If Request.Temperature > 0.00001 Then Return ValidationError.Temperature
		  If Request.Top_P > 0.00001 Then Return ValidationError.Top_P
		  If Request.TrainingFile <> "" Then Return ValidationError.TrainingFile
		  If Request.ValidationFile <> "" Then Return ValidationError.ValidationFile
		  If Request.Voice <> "" Then Return ValidationError.Voice
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
