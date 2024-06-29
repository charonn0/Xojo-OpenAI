#tag Class
Protected Class Embedding
Inherits OpenAI.Response
	#tag Method, Flags = &h1000
		Sub Constructor(ResponseData As FolderItem)
		  ' Loads a previously created Response that was stored as JSON using Response.ToString()
		  ' The OriginalRequest property will be Nil in re-loaded Responses.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Response.Constructor
		  
		  // Calling the overridden superclass constructor.
		  // Constructor(ResponseData As FolderItem) -- From Response
		  Super.Constructor(ResponseData)
		End Sub
	#tag EndMethod

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
		 Shared Function Create(Inputs() As Integer, Model As OpenAI.Model) As OpenAI.Embedding
		  ' Create new embedding vectors for the inputs using the specified model.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Embedding.Create
		  ' https://platform.openai.com/docs/api-reference/embeddings/create
		  
		  Dim request As New OpenAI.Request
		  request.Set("input", Inputs)
		  request.Model = Model
		  Return Embedding.Create(request)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Create(Request As OpenAI.Request) As OpenAI.Embedding
		  ' Create a new embedding vector.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Embedding.Create
		  ' https://platform.openai.com/docs/api-reference/embeddings/create
		  
		  If Embedding.Prevalidate Then
		    Dim err As ValidationError = Embedding.IsValid(Request)
		    If err <> ValidationError.None Then Raise New OpenAIException(err)
		  End If
		  Dim client As New OpenAIClient
		  Dim result As JSONItem = Response.CreateRaw(client, "/v1/embeddings", Request)
		  If result = Nil Or result.HasName("error") Then Raise New OpenAIException(result)
		  Return New OpenAI.Embedding(result, client, Request)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Create(Inputs() As String, Model As OpenAI.Model) As OpenAI.Embedding
		  ' Create new embedding vectors for the inputs using the specified model.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Embedding.Create
		  ' https://platform.openai.com/docs/api-reference/embeddings/create
		  
		  Dim request As New OpenAI.Request
		  request.Set("input", Inputs)
		  request.Model = Model
		  Return Embedding.Create(request)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Create(Input As String, Model As OpenAI.Model) As OpenAI.Embedding
		  ' Create a new embedding vector for the input using the specified model.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Embedding.Create
		  ' https://platform.openai.com/docs/api-reference/embeddings/create
		  
		  Dim request As New OpenAI.Request
		  request.Input = Input
		  request.Model = Model
		  Return Embedding.Create(request)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DistanceFrom(OtherEmbedding As OpenAI.Embedding) As Double
		  ' Compares this embedding to the other embedding. Returns a Double between -1.0 and +1.0
		  ' where +1.0 means completely identical and -1.0 means completely different.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Embedding.DistanceFrom
		  
		  Dim v1() As Double = Me.GetResult()
		  Dim v2() As Double = OtherEmbedding.GetResult()
		  Return OpenAI.CosineDistance(v1, v2)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetCreationDate() As Date
		  Return Nil ' not provided with this endpoint.
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetResult(Index As Integer = 0) As Variant
		  ' Use this method to retrieve the response(s) to the request. The first (and often only)
		  ' response is at index zero. The last response is at Response.ResultCount-1.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Response.GetResult
		  
		  Dim results As JSONItem = mResponse.Value("data")
		  results = results.Child(Index)
		  results = results.Value("embedding")
		  Dim vector() As Double
		  For i As Integer = 0 To results.Count - 1
		    vector.Append(results.Value(i))
		  Next
		  Return vector
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetResultType() As OpenAI.ResultType
		  Return OpenAI.ResultType.VectorList
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
		  If Not Request.IsSet("input") Then Return ValidationError.Input ' required
		  If Request.Instruction <> "" Then Return ValidationError.Instruction
		  If Request.Language <> "" Then Return ValidationError.Language
		  If Request.LearningRateMultiplier > 0.00001 Then Return ValidationError.LearningRateMultiplier
		  If Request.LogItBias <> Nil Then Return ValidationError.LogItBias
		  If Request.IsSet("logprobs") Then Return ValidationError.LogProbabilities
		  If Request.MaskImage <> Nil Then Return ValidationError.MaskImage
		  If Request.MaxTokens > 4096 Then Return ValidationError.MaxTokens
		  If Request.Model = Nil Then Return ValidationError.Model ' required
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

	#tag Method, Flags = &h0
		Function Operator_Subscript(Optional ResponseIndex As Integer, VectorIndex As Integer) As Double
		  ' Returns the vector at VectorIndex from the vector list corresponding to the ResponseIndex.
		  ' Call this method with array-access syntax. The ResponseIndex is almost always zero, and
		  ' may be omitted.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Embedding.Operator_Subscript
		  
		  Dim vector() As Double = Me.GetResult(ResponseIndex)
		  Return vector(VectorIndex)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SimilarityTo(OtherEmbedding As OpenAI.Embedding) As Double
		  ' Compares this embedding to the other embedding. Returns a Double between -1.0 and +1.0
		  ' where +1.0 means completely identical and -1.0 means completely different.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Embedding.DistanceFrom
		  
		  Dim v1() As Double = Me.GetResult()
		  Dim v2() As Double = OtherEmbedding.GetResult()
		  Return OpenAI.CosineSimilarity(v1, v2)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Vector(Optional ResponseIndex As Integer) As Double()
		  Dim vector() As Double = Me.GetResult(ResponseIndex)
		  Return vector
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' Returns the length of the vector list. The last vector is at Length-1.
			  '
			  ' See:
			  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Embedding.Length
			  
			  Dim vector() As Double = Me.GetResult(0)
			  Return UBound(vector) + 1
			End Get
		#tag EndGetter
		Length As Integer
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
			  ' Returns the original input text that was used to generate this embedding, if available.
			  '
			  ' See:
			  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Embedding.Text
			  
			  If Me.OriginalRequest <> Nil Then Return Me.OriginalRequest.Input
			End Get
		#tag EndGetter
		Text As String
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private Shared ValidationOpt As Boolean = True
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="ID"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
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
			Name="ResponseFormat"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
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
			EditorType="MultiLineEditor"
			InheritedFrom="OpenAI.Response"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="SystemFingerprint"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
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
