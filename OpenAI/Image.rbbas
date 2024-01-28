#tag Class
Protected Class Image
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
		 Shared Function Create(Request As OpenAI.Request) As OpenAI.Image
		  ' Generate one or more images according to a natural language prompt.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Image.Create
		  ' https://platform.openai.com/docs/api-reference/images/create
		  
		  If Image.Prevalidate Then
		    Dim err As ValidationError = Image.IsValid(Request)
		    If err <> ValidationError.None Then Raise New OpenAIException(err)
		  End If
		  Dim client As New OpenAIClient
		  Dim result As JSONItem = Response.CreateRaw(client, "/v1/images/generations", Request)
		  If result = Nil Or result.HasName("error") Then Raise New OpenAIException(result)
		  If Not result.HasName("model") And Request.Model <> Nil Then result.Value("model") = Request.Model.ID
		  Return New OpenAI.Image(result, client, Request)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Create(Prompt As String, Size As String = "1024x1024", AsURL As Boolean = False, Model As OpenAI.Model = Nil) As OpenAI.Image
		  ' Generate one or more images according to a natural language prompt.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Image.Create
		  ' https://platform.openai.com/docs/api-reference/images/create
		  
		  Dim request As New OpenAI.Request()
		  If Model = Nil Then Model = "dall-e-2"
		  request.Model = Model
		  request.Prompt = Prompt
		  request.Size = Size
		  request.ResultsAsURL = AsURL
		  Return Image.Create(request)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function CreateVariation(Request As OpenAI.Request) As OpenAI.Image
		  ' Given an existing image, the model will create one or more variations of it.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Image.CreateVariation
		  ' https://platform.openai.com/docs/api-reference/images/createVariation
		  
		  If Image.Prevalidate Then
		    Dim err As ValidationError = Image.IsValid(Request)
		    If err <> ValidationError.None Then Raise New OpenAIException(err)
		  End If
		  Dim client As New OpenAIClient
		  Dim result As JSONItem = Response.CreateRaw(client, "/v1/images/variations", Request)
		  If result = Nil Or result.HasName("error") Then Raise New OpenAIException(result)
		  If Not result.HasName("model") And Request.Model <> Nil Then result.Value("model") = Request.Model.ID
		  Return New OpenAI.Image(result, client, Request)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function CreateVariation(Prompt As Picture, Size As String = "1024x1024", AsURL As Boolean = False) As OpenAI.Image
		  ' Given an existing image, the model will create one or more variations of it.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Image.CreateVariation
		  ' https://platform.openai.com/docs/api-reference/images/createVariation
		  
		  Dim request As New OpenAI.Request()
		  request.SourceImage = Prompt
		  request.Size = Size
		  request.ResultsAsURL = AsURL
		  Return Image.CreateVariation(request)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Edit(Request As OpenAI.Request) As OpenAI.Image
		  ' Given an existing image, the model will create one or more edited versions of it according
		  ' to the prompt.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Image.Edit
		  ' https://platform.openai.com/docs/api-reference/images/createEdit
		  
		  If Image.Prevalidate Then
		    Dim err As ValidationError = Image.IsValid(Request)
		    If err <> ValidationError.None Then Raise New OpenAIException(err)
		  End If
		  If Request.SourceImage <> Nil Then
		    If Request.SourceImage.Width <> Request.SourceImage.Height Then Raise New OpenAIException("Pictures submitted to the API must be square.")
		    If Request.MaskImage <> Nil And _
		      (Request.MaskImage.Width <> Request.SourceImage.Width Or Request.MaskImage.Height <> Request.SourceImage.Height) Then
		      Raise New OpenAIException("The mask picture must have the same dimensions as the source picture.")
		    End If
		  End If
		  
		  Dim client As New OpenAIClient
		  Dim result As JSONItem = Response.CreateRaw(client, "/v1/images/edits", Request)
		  If result = Nil Or result.HasName("error") Then Raise New OpenAIException(result)
		  If Not result.HasName("model") And Request.Model <> Nil Then result.Value("model") = Request.Model.ID
		  Return New OpenAI.Image(result, client, Request)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Edit(Original As Picture, Prompt As String, Mask As Picture, Size As String = "1024x1024", AsURL As Boolean = False) As OpenAI.Image
		  ' Given an existing image, the model will create one or more edited versions of it according
		  ' to the prompt.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Image.Edit
		  ' https://platform.openai.com/docs/api-reference/images/createEdit
		  
		  Dim request As New OpenAI.Request()
		  request.Prompt = Prompt
		  request.SourceImage = Original
		  request.MaskImage = Mask
		  request.Size = Size
		  request.ResultsAsURL = AsURL
		  Return Image.Edit(request)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Attributes( deprecated = "OpenAI.Image.Create" )  Shared Function Generate(Request As OpenAI.Request) As OpenAI.Image
		  ' Generate one or more images according to a natural language prompt.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Image.Generate
		  ' https://platform.openai.com/docs/api-reference/images/create
		  
		  If Image.Prevalidate Then
		    Dim err As ValidationError = Image.IsValid(Request)
		    If err <> ValidationError.None Then Raise New OpenAIException(err)
		  End If
		  Dim client As New OpenAIClient
		  Dim result As JSONItem = Response.CreateRaw(client, "/v1/images/generations", Request)
		  If result = Nil Or result.HasName("error") Then Raise New OpenAIException(result)
		  If Not result.HasName("model") And Request.Model <> Nil Then result.Value("model") = Request.Model.ID
		  Return New OpenAI.Image(result, client, Request)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Attributes( deprecated = "OpenAI.Image.Create" )  Shared Function Generate(Prompt As String, Size As String = "1024x1024", AsURL As Boolean = False, Model As OpenAI.Model = Nil) As OpenAI.Image
		  ' Generate one or more images according to a natural language prompt.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Image.Generate
		  ' https://platform.openai.com/docs/api-reference/images/create
		  
		  Dim request As New OpenAI.Request()
		  If Model = Nil Then Model = "dall-e-2"
		  request.Model = Model
		  request.Prompt = Prompt
		  request.Size = Size
		  request.ResultsAsURL = AsURL
		  Return Image.Create(request)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetResponseFormat() As String
		  Dim results As JSONItem = Super.GetResult()
		  If results.HasName("b64_json") Then
		    Return "png"
		  ElseIf results.HasName("url") Then
		    Return "url"
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetResult(Index As Integer = 0) As Variant
		  ' Returns the result at Index, as a Picture object or a String URL.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Response.GetResult
		  
		  Dim results As JSONItem = Super.GetResult(Index)
		  If results.HasName("b64_json") Then
		    Return Picture.FromData(DecodeBase64(results.Value("b64_json")))
		  ElseIf results.HasName("url") Then
		    Return DefineEncoding(results.Value("url"), Encodings.UTF8)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetResultType() As OpenAI.ResultType
		  Dim results As JSONItem = Super.GetResult()
		  If results.HasName("b64_json") Then
		    Return OpenAI.ResultType.Picture
		  ElseIf results.HasName("url") Then
		    Return OpenAI.ResultType.PictureURL
		  End If
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
		  ' If Request.IsSet("quality") Then Return ValidationError.HighQuality
		  If Request.Input <> "" Then Return ValidationError.Input
		  If Request.Instruction <> "" Then Return ValidationError.Instruction
		  If Request.Language <> "" Then Return ValidationError.Language
		  If Request.LearningRateMultiplier > 0.00001 Then Return ValidationError.LearningRateMultiplier
		  If Request.LogItBias <> Nil Then Return ValidationError.LogItBias
		  If Request.IsSet("logprobs") Then Return ValidationError.LogProbabilities
		  ' If Request.MaskImage <> Nil Then Return ValidationError.MaskImage
		  If Request.MaxTokens > 0 Then Return ValidationError.MaxTokens
		  ' If Request.Model = Nil Then Return ValidationError.Model ' required
		  If Request.NumberOfEpochs > 1 Then Return ValidationError.NumberOfEpochs
		  ' If Request.NumberOfResults > 1 Then Return ValidationError.NumberOfResults
		  If Request.PresencePenalty > 0.00001 Then Return ValidationError.PresencePenalty
		  If Request.Prompt = "" And Request.SourceImage = Nil Then Return ValidationError.Prompt ' required
		  If Request.PromptLossWeight > 0.00001 Then Return ValidationError.PromptLossWeight
		  If Request.Purpose <> "" Then Return ValidationError.Purpose
		  ' If Request.ResultsAsBase64 = True Then Return ValidationError.ResultsAsType
		  If Request.ResultsAsJSON = True Then Return ValidationError.ResultsAsType
		  If Request.ResultsAsJSON_Verbose = True Then Return ValidationError.ResultsAsType
		  If Request.ResultsAsSRT = True Then Return ValidationError.ResultsAsType
		  If Request.ResultsAsText = True Then Return ValidationError.ResultsAsType
		  ' If Request.ResultsAsURL = True Then Return ValidationError.ResultsAsURL
		  If Request.ResultsAsVTT = True Then Return ValidationError.ResultsAsType
		  If Request.ResultsAsMP3 = True Then Return ValidationError.ResultsAsType
		  If Request.ResultsAsOpus = True Then Return ValidationError.ResultsAsType
		  If Request.ResultsAsAAC = True Then Return ValidationError.ResultsAsType
		  If Request.ResultsAsFLAC = True Then Return ValidationError.ResultsAsType
		  If Request.Size <> "" Then
		    Select Case Request.Size
		    Case "256x256", "512x512", "1024x1024", "1024x1024", "1792x1024", "1024x1792"
		    Else
		      Return ValidationError.Size
		    End Select
		  End If
		  If Request.IsSet("speed") Then Return ValidationError.Speed
		  If Request.SourceImage <> Nil Then
		    If Request.SourceImage.Width <> Request.SourceImage.Height Then Return ValidationError.SourceImage
		  End If
		  If Request.Stop <> "" Then Return ValidationError.Stop
		  ' If Request.IsSet("style") Then Return ValidationError.Style
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
			Name="SystemFingerprint"
			Group="Behavior"
			Type="String"
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
