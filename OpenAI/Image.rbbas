#tag Class
Protected Class Image
Inherits OpenAI.Response
	#tag Method, Flags = &h1001
		Protected Sub Constructor(ResponseData As JSONItem, Client As OpenAIClient)
		  // Calling the overridden superclass constructor.
		  // Constructor(ResponseData As JSONItem, Client As OpenAIClient) -- From Response
		  Super.Constructor(ResponseData, Client)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function CreateVariation(Request As OpenAI.Request) As OpenAI.Image
		  ' Given an existing image, the model will create one or more variations of it.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Image.CreateVariation
		  ' https://beta.openai.com/docs/api-reference/images/create-variation
		  
		  Dim client As New OpenAIClient
		  Dim result As New JSONItem(client.SendRequest("/v1/images/variations", Request))
		  If result = Nil Or result.HasName("error") Then Raise New OpenAIException(result)
		  Return New OpenAI.Image(result, client)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function CreateVariation(Prompt As Picture, Size As String = "1024x1024", AsURL As Boolean = False) As OpenAI.Image
		  ' Given an existing image, the model will create one or more variations of it.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Image.CreateVariation
		  ' https://beta.openai.com/docs/api-reference/images/create-variation
		  
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
		  ' https://beta.openai.com/docs/api-reference/images/create-edit
		  
		  If Request.SourceImage <> Nil Then
		    If Request.SourceImage.Width <> Request.SourceImage.Height Then Raise New OpenAIException("Pictures submitted to the API must be square.")
		    If Request.MaskImage <> Nil And _
		      (Request.MaskImage.Width <> Request.MaskImage.Width Or Request.MaskImage.Height <> Request.MaskImage.Height) Then
		      Raise New OpenAIException("The mask picture must have the same dimensions as the source picture.")
		    End If
		  End If
		  
		  Dim client As New OpenAIClient
		  Dim result As New JSONItem(client.SendRequest("/v1/images/edits", Request))
		  If result = Nil Or result.HasName("error") Then Raise New OpenAIException(result)
		  Return New OpenAI.Image(result, client)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Edit(Original As Picture, Prompt As String, Mask As Picture, Size As String = "1024x1024", AsURL As Boolean = False) As OpenAI.Image
		  ' Given an existing image, the model will create one or more edited versions of it according
		  ' to the prompt.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Image.Edit
		  ' https://beta.openai.com/docs/api-reference/images/create-edit
		  
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
		 Shared Function Generate(Request As OpenAI.Request) As OpenAI.Image
		  ' Generate one or more images according to a natural language prompt.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Image.Generate
		  ' https://beta.openai.com/docs/api-reference/images/create
		  
		  Dim client As New OpenAIClient
		  Dim result As New JSONItem(client.SendRequest("/v1/images/generations", Request))
		  If result = Nil Or result.HasName("error") Then Raise New OpenAIException(result)
		  Return New OpenAI.Image(result, client)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Generate(Prompt As String, Size As String = "1024x1024", AsURL As Boolean = False) As OpenAI.Image
		  ' Generate one or more images according to a natural language prompt.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Image.Generate
		  ' https://beta.openai.com/docs/api-reference/images/create
		  
		  Dim request As New OpenAI.Request()
		  request.Prompt = Prompt
		  request.Size = Size
		  request.ResultsAsURL = AsURL
		  Return Image.Generate(request)
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
		  If Request.Input <> "" Then Return False
		  If Request.Instruction <> "" Then Return False
		  If Request.LearningRateMultiplier > 0.00001 Then Return False
		  If Request.LogItBias <> Nil Then Return False
		  If Request.LogProbabilities <> 0 Then Return False
		  If Request.MaskImage <> Nil Then Return False
		  If Request.MaxTokens >= 0 Then Return False
		  ' If Request.MaxTokens >= 2048 Then Return False
		  If Request.Model <> Nil Then Return False
		  If Request.NumberOfEpochs <> 1 Then Return False
		  If Request.NumberOfResults < 1 Then Return False ' optional
		  If Request.PresencePenalty > 0.00001 Then Return False
		  If Request.Prompt = "" Then Return False ' required
		  If Request.Prompt.Len > 1000 Then Return False ' max length exceeded
		  If Request.PromptLossWeight > 0.00001 Then Return False
		  If Request.Purpose <> "" Then Return False
		  ' If Request.ResultsAsURL = True Then Return False
		  If Request.Size <> "" Then
		    Select Case Request.Size
		    Case "256x256", "512x512", "1024x1024"
		    Else
		      Return False
		    End Select
		  End If
		  ' If Request.SourceImage <> Nil Then Return False
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
		  Dim results As JSONItem = Super.GetResult(Index)
		  If results.HasName("b64_json") Then
		    Return OpenAI.ResultType.Picture
		  ElseIf results.HasName("url") Then
		    Return OpenAI.ResultType.PictureURL
		  End If
		End Function
	#tag EndMethod


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
