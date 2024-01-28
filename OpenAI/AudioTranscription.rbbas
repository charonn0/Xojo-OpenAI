#tag Class
Protected Class AudioTranscription
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
		 Shared Function Create(AudioFile As FolderItem, Language As String = "", Prompt As String = "", FileMIMEType As String = "") As OpenAI.AudioTranscription
		  ' Creates a new transcript of the AudioFile. AudioFile must be <=25MB and be of a supported media file
		  ' type. Language indicates the language being spoken. Prompt is a natual language hint to the AI as to
		  ' what it's hearing. FileMIMEType specifies the MIMEType if the AudioFile isn't using a standard file
		  ' name extension (.mp3, etc.)
		  '
		  ' Returns an instance of AudioTranscription containing the result. The operation may take several minutes.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.AudioTranscription.Create
		  ' https://platform.openai.com/docs/api-reference/audio/createTranscription
		  
		  Dim request As New OpenAI.Request
		  Dim bs As BinaryStream = BinaryStream.Open(AudioFile)
		  Dim mb As MemoryBlock = bs.Read(bs.Length)
		  bs.Close
		  If FileMIMEType = "" Then FileMIMEType = MIMEType(AudioFile)
		  If AudioTranscription.Prevalidate And FileMIMEType = "" Then Raise New OpenAIException("Unrecognized media file format.")
		  request.File = mb
		  request.Model = "whisper-1"
		  request.FileName = AudioFile.Name
		  request.FileMIMEType = FileMIMEType
		  request.ResultsAsJSON = True
		  If Prompt <> "" Then request.Prompt = Prompt
		  If Language <> "" Then request.Language = Language
		  Return OpenAI.AudioTranscription.Create(request)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Create(Request As OpenAI.Request) As OpenAI.AudioTranscription
		  ' Sends the specified transcript Request and returns an instance of AudioTranscription containing
		  ' the result on success. The operation may take several minutes.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.AudioTranscription.Create
		  ' https://platform.openai.com/docs/api-reference/audio/createTranscription
		  
		  If AudioTranscription.Prevalidate Then
		    Dim err As ValidationError = AudioTranscription.IsValid(Request)
		    If err <> ValidationError.None Then Raise New OpenAIException(err)
		    Select Case True
		    Case Request.ResultsAsText, Request.ResultsAsSRT, Request.ResultsAsVTT
		      Raise New OpenAIException("This method can only operate on JSON results.")
		    Case Request.ResultsAsJSON, Request.ResultsAsJSON_Verbose
		    Else
		      Request.ResultsAsJSON = True
		    End Select
		  End If
		  Dim client As New OpenAIClient
		  client.ForceHTTP1_1 = True
		  Dim result As JSONItem = Response.CreateRaw(client, "/v1/audio/transcriptions", Request)
		  If result = Nil Or result.HasName("error") Then Raise New OpenAIException(result)
		  If Not result.HasName("model") And Request.Model <> Nil Then result.Value("model") = Request.Model.ID
		  Select Case True
		  Case request.ResultsAsJSON,  request.ResultsAsText, request.ResultsAsJSON_Verbose
		    result.Value("response_format") = "txt"
		  Case request.ResultsAsSRT
		    result.Value("response_format") = "srt"
		  Case request.ResultsAsVTT
		    result.Value("response_format") = "vtt"
		  End Select
		  Return New OpenAI.AudioTranscription(result, client, Request)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function CreateRaw(AudioFile As FolderItem, ResponseFormat As String, Language As String = "", Prompt As String = "", FileMIMEType As String = "") As String
		  ' Creates a new transcript of the AudioFile. AudioFile must be <=25MB and be of a supported media file
		  ' type. ResponseFormat indicates which of the supported response formats you want returned; refer to
		  ' the OpenAI documentation for a description of supported formats. Language indicates the language being
		  ' spoken. Prompt is a natual language hint to the AI as to what it's hearing. FileMIMEType specifies the
		  ' MIMEType if the AudioFile isn't using a standard file name extension (.mp3, etc.)
		  '
		  ' Returns plain string containing the result. The operation may take several minutes.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.AudioTranscription.CreateRaw
		  ' https://platform.openai.com/docs/api-reference/audio/createTranscription
		  
		  Dim request As New OpenAI.Request
		  Dim bs As BinaryStream = BinaryStream.Open(AudioFile)
		  Dim mb As MemoryBlock = bs.Read(bs.Length)
		  bs.Close
		  If FileMIMEType = "" Then FileMIMEType = MIMEType(AudioFile)
		  If AudioTranscription.Prevalidate And FileMIMEType = "" Then Raise New OpenAIException("Unrecognized media file format.")
		  request.File = mb
		  request.Model = "whisper-1"
		  request.FileName = AudioFile.Name
		  request.FileMIMEType = FileMIMEType
		  Select Case ResponseFormat
		  Case "json"
		    request.ResultsAsJSON = True
		  Case "text", ""
		    request.ResultsAsText = True
		  Case "srt"
		    request.ResultsAsSRT = True
		  Case "verbose_json"
		    request.ResultsAsJSON_Verbose = True
		  Case "vtt"
		    request.ResultsAsVTT = True
		  Else
		    Raise New OpenAIException("Unsupported ResponseFormat: '" + ResponseFormat + "'.")
		  End Select
		  If Prompt <> "" Then request.Prompt = Prompt
		  If Language <> "" Then request.Language = Language
		  Return OpenAI.AudioTranscription.CreateRaw(request)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function CreateRaw(Request As OpenAI.Request) As String
		  ' Sends the specified transcript Request and returns a plain string containing the result
		  ' on success. The operation may take several minutes.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.AudioTranscription.CreateRaw
		  ' https://platform.openai.com/docs/api-reference/audio/createTranscription
		  
		  If AudioTranscription.Prevalidate Then
		    Dim err As ValidationError = AudioTranscription.IsValid(Request)
		    If err <> ValidationError.None Then Raise New OpenAIException(err)
		  End If
		  Dim client As New OpenAIClient
		  client.ForceHTTP1_1 = True
		  Dim data As String = client.SendRequest("/v1/audio/transcriptions", Request)
		  If client.LastErrorCode <> 0 Then Raise New OpenAIException(client)
		  Return DefineEncoding(data, Encodings.UTF8)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetResponseFormat() As String
		  Return mResponse.Lookup("response_format", "")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetResult(Index As Integer = 0) As Variant
		  ' Returns the result at Index, as a String.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Response.GetResult
		  
		  #pragma Unused Index
		  Dim txt As String = mResponse.Lookup("text", "")
		  txt = DefineEncoding(txt, Encodings.UTF8)
		  Return txt
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetResultCount() As Integer
		  Return 1
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
		  If Request.File = Nil Then Return ValidationError.File ' required
		  If Request.File.Size > 1024 * 1024 * 25 Then Return ValidationError.File ' 25MB file size limit.
		  If Request.FileName = "" Then Return ValidationError.FileName ' required
		  If Request.FileMIMEType = "" Then Return ValidationError.FileMIMEType ' required
		  If Request.FineTuneID <> "" Then Return ValidationError.FineTuneID
		  If Request.FrequencyPenalty > 0.00001 Then Return ValidationError.FrequencyPenalty
		  If Request.IsSet("quality") Then Return ValidationError.HighQuality
		  If Request.Input <> "" Then Return ValidationError.Input
		  If Request.Instruction <> "" Then Return ValidationError.Instruction
		  ' If Request.Language <> "" Then Return ValidationError.Language
		  If Request.LearningRateMultiplier > 0.00001 Then Return ValidationError.LearningRateMultiplier
		  If Request.LogItBias <> Nil Then Return ValidationError.LogItBias
		  If Request.IsSet("logprobs") Then Return ValidationError.LogProbabilities
		  If Request.MaskImage <> Nil Then Return ValidationError.MaskImage
		  If Request.MaxTokens > 0 Then Return ValidationError.MaxTokens
		  If Request.Model = Nil Then Return ValidationError.Model ' required
		  If Request.NumberOfEpochs <> 1 Then Return ValidationError.NumberOfEpochs
		  If Request.NumberOfResults <> 1 Then Return ValidationError.NumberOfResults
		  If Request.PresencePenalty > 0.00001 Then Return ValidationError.PresencePenalty
		  ' If Request.Prompt <> "" Then Return ValidationError.Prompt
		  If Request.PromptLossWeight > 0.00001 Then Return ValidationError.PromptLossWeight
		  If Request.Purpose <> "" Then Return ValidationError.Purpose
		  If Request.ResultsAsBase64 = True Then Return ValidationError.ResultsAsType
		  ' If Request.ResultsAsJSON = True Then Return ValidationError.ResultsAsType
		  ' If Request.ResultsAsJSON_Verbose = True Then Return ValidationError.ResultsAsType
		  ' If Request.ResultsAsSRT = True Then Return ValidationError.ResultsAsType
		  ' If Request.ResultsAsText = True Then Return ValidationError.ResultsAsType
		  If Request.ResultsAsURL = True Then Return ValidationError.ResultsAsURL
		  ' If Request.ResultsAsVTT = True Then Return ValidationError.ResultsAsType
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
		  ' If Request.Temperature > 0.00001 Then Return ValidationError.Temperature
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
