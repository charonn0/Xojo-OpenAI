#tag Class
Protected Class AudioGeneration
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
		Protected Sub Constructor(ResponseData As JSONItem, Client As OpenAIClient, AudioData As MemoryBlock, OriginalRequest As OpenAI.Request)
		  // Calling the overridden superclass constructor.
		  // Constructor(ResponseData As JSONItem, Client As OpenAIClient, OriginalRequest As OpenAI.Request) -- From Response
		  Super.Constructor(ResponseData, Client, OriginalRequest)
		  mAudioData = AudioData
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Create(Request As OpenAI.Request) As OpenAI.AudioGeneration
		  ' Sends the specified text-to-speech Request and returns an instance of AudioGeneration containing
		  ' the result on success. The operation may take several minutes.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.AudioGeneration.Create
		  ' https://platform.openai.com/docs/api-reference/audio/createSpeech
		  
		  If AudioGeneration.Prevalidate Then
		    Dim err As ValidationError = AudioGeneration.IsValid(Request)
		    If err <> ValidationError.None Then Raise New OpenAIException(err)
		  End If
		  Dim client As New OpenAIClient
		  Dim audiodata As MemoryBlock = client.SendRequest("/v1/audio/speech", Request)
		  If client.LastStatusCode <> 200 Then
		    Dim result As New JSONItem(audiodata)
		    Raise New OpenAIException(result)
		  Else
		    Dim fake As New JSONItem
		    fake.Value("id") = "FAKE-123"
		    fake.Value("created") = DateToEpoch(New Date)
		    fake.Value("response_format") = Request.ResponseFormat
		    If Request.Model <> Nil Then fake.Value("model") = Request.Model.ID
		    Return New AudioGeneration(fake, client, audiodata, Request)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Create(Input As String, Model As OpenAI.Model, Voice As String, Speed As Single = 1.0, ResponseFormat As String = "mp3") As OpenAI.AudioGeneration
		  ' Creates a text-to-speech audio file from the Input. Input may be <=4096 characters.
		  ' Voice is one of OpenAI's TTS voices. Speed may be between 0.25 and 4.0. ResponseFormat
		  ' is one of the supported audio output formats (mp3, opus, aac, or flac).
		  '
		  ' Returns an instance of AudioGeneration containing the result. The operation may take several minutes.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.AudioGeneration.Create
		  ' https://platform.openai.com/docs/api-reference/audio/createSpeech
		  
		  Dim request As New OpenAI.Request
		  request.Model = Model
		  request.Input = Input
		  request.Voice = Voice
		  If Speed <> 1.0 Then request.Speed = Speed
		  Select Case ResponseFormat
		  Case "mp3", ""
		    request.ResultsAsMP3 = True
		  Case "opus"
		    request.ResultsAsOpus = True
		  Case "aac"
		    request.ResultsAsAAC = True
		  Case "flac"
		    request.ResultsAsFLAC = True
		  Else
		    Raise New OpenAIException("Unsupported ResponseFormat: '" + ResponseFormat + "'.")
		  End Select
		  Return OpenAI.AudioGeneration.Create(request)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function CreateRaw(Request As OpenAI.Request) As MemoryBlock
		  ' Sends the specified text-to-speech Request and returns the raw audio data on success.
		  ' The operation may take several minutes.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.AudioGeneration.Create
		  ' https://platform.openai.com/docs/api-reference/audio/createSpeech
		  
		  If AudioGeneration.Prevalidate Then
		    Dim err As ValidationError = AudioGeneration.IsValid(Request)
		    If err <> ValidationError.None Then Raise New OpenAIException(err)
		  End If
		  Dim client As New OpenAIClient
		  Dim data As String = client.SendRequest("/v1/audio/speech", Request)
		  If client.LastStatusCode <> 200 Then Raise New OpenAIException(client)
		  Return data
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function CreateRaw(Input As String, Model As OpenAI.Model, Voice As String, Speed As Double = 1.0, ResponseFormat As String = "mp3") As MemoryBlock
		  ' Creates a text-to-speech audio file from the Input. Input may be <=4096 characters.
		  ' Voice is one of OpenAI's TTS voices. Speed may be between 0.25 and 4.0. ResponseFormat
		  ' is one of the supported audio output formats (mp3, opus, aac, or flac).
		  '
		  ' Returns the raw audio data on success. The operation may take several minutes.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.AudioGeneration.Create
		  ' https://platform.openai.com/docs/api-reference/audio/createSpeech
		  
		  Dim request As New OpenAI.Request
		  request.Model = Model
		  request.Input = Input
		  request.Voice = Voice
		  If Speed <> 1.0 Then request.Speed = Speed
		  Select Case ResponseFormat
		  Case "mp3", ""
		    request.ResultsAsMP3 = True
		  Case "opus"
		    request.ResultsAsOpus = True
		  Case "aac"
		    request.ResultsAsAAC = True
		  Case "flac"
		    request.ResultsAsFLAC = True
		  Else
		    Raise New OpenAIException("Unsupported ResponseFormat: '" + ResponseFormat + "'.")
		  End Select
		  Return OpenAI.AudioGeneration.CreateRaw(request)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function DateToEpoch(d As Date) As Integer
		  Static epoch As Double = time_t(0).TotalSeconds
		  Return d.TotalSeconds - epoch
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetResponseFormat() As String
		  Return mResponse.Lookup("response_format", "")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetResult(Index As Integer = 0) As Variant
		  ' Returns the result at Index, as raw audio data.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Response.GetResult
		  
		  #pragma Unused Index
		  Return mAudioData
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetResultAttribute(Index As Integer, AttributeName As String, DefaultValue As Variant = Nil) As Variant
		  #pragma Unused Index
		  #pragma Unused AttributeName
		  #pragma Unused DefaultValue
		  Return Nil
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetResultCount() As Integer
		  Return 1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetResultType() As OpenAI.ResultType
		  Return OpenAI.ResultType.Audio
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
		  If Request.MaxTokens > 4096 Then Return ValidationError.MaxTokens
		  If Request.Model = Nil Then Return ValidationError.Model ' required
		  If Request.NumberOfEpochs <> 1 Then Return ValidationError.NumberOfEpochs
		  If Request.NumberOfResults <> 1 Then Return ValidationError.NumberOfResults
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
		  ' If Request.ResultsAsMP3 = True Then Return ValidationError.ResultsAsType
		  ' If Request.ResultsAsOpus = True Then Return ValidationError.ResultsAsType
		  ' If Request.ResultsAsAAC = True Then Return ValidationError.ResultsAsType
		  ' If Request.ResultsAsFLAC = True Then Return ValidationError.ResultsAsType
		  If Request.Size <> "" Then Return ValidationError.Size
		  ' If Request.IsSet("speed") Then Return ValidationError.Speed
		  If Request.SourceImage <> Nil Then Return ValidationError.SourceImage
		  If Request.Stop <> "" Then Return ValidationError.Stop
		  If Request.IsSet("style") Then Return ValidationError.Style
		  If Request.Suffix <> "" Then Return ValidationError.Suffix
		  If Request.Temperature > 0.00001 Then Return ValidationError.Temperature
		  If Request.Top_P > 0.00001 Then Return ValidationError.Top_P
		  If Request.TrainingFile <> "" Then Return ValidationError.TrainingFile
		  If Request.ValidationFile <> "" Then Return ValidationError.ValidationFile
		  If Request.Voice = "" Then Return ValidationError.Voice ' required
		  Return ValidationError.None
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mAudioData As MemoryBlock
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
