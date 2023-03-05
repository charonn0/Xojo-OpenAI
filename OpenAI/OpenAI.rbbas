#tag Module
Protected Module OpenAI
	#tag Method, Flags = &h21
		Private Function MIMEType(File As FolderItem) As String
		  Select Case NthField(File.Name, ".", CountFields(File.Name, "."))
		  Case "mp3"
		    Return "audio/mp3"
		  Case "mp4"
		    Return "video/mp4"
		  Case "mpeg"
		    Return "video/mpeg"
		  Case "mpga"
		    Return "audio/mpeg"
		  Case "m4a"
		    Return "audio/mp4"
		  Case "wav"
		    Return "audio/wav"
		  Case "webm"
		    Return "video/webm"
		  Case "png"
		    Return "image/png"
		  Case "json"
		    Return "application/json"
		  Case "jsonl"
		    Return "application/x-jsonlines"
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function time_t(Count As Integer) As Date
		  Dim d As New Date(1970, 1, 1, 0, 0, 0, 0.0) 'UNIX epoch
		  d.TotalSeconds = d.TotalSeconds + Count
		  Return d
		End Function
	#tag EndMethod


	#tag Property, Flags = &h1
		#tag Note
			You will need an OpenAI API key in order to interact with the OpenAI API
			
			https://platform.openai.com/account/api-keys
		#tag EndNote
		Protected APIKey As String = "YOUR API KEY HERE"
	#tag EndProperty

	#tag Property, Flags = &h1
		#tag Note
			For users who belong to multiple organizations, you can specify which organization is
			used for API requests. Usage from these API requests will count against the specified
			organization's subscription quota.
		#tag EndNote
		Protected OrganizationID As String
	#tag EndProperty


	#tag Constant, Name = OPENAI_URL, Type = String, Dynamic = False, Default = \"https://api.openai.com", Scope = Private
	#tag EndConstant

	#tag Constant, Name = USER_AGENT_STRING, Type = String, Dynamic = False, Default = \"Xojo-OpenAI/0.1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = USE_MBS, Type = Boolean, Dynamic = False, Default = \"False", Scope = Private
	#tag EndConstant

	#tag Constant, Name = USE_RBLIBCURL, Type = Boolean, Dynamic = False, Default = \"False", Scope = Private
	#tag EndConstant


	#tag Enum, Name = ResultType, Type = Integer, Flags = &h1
		String
		  Picture
		  PictureURL
		  FileObject
		JSONObject
	#tag EndEnum

	#tag Enum, Name = ValidationError, Type = Integer, Flags = &h1
		BatchSize
		  BestOf
		  ClassificationBetas
		  ClassificationNClasses
		  ClassificationPositiveClass
		  ComputeClassificationMetrics
		  Echo
		  File
		  FileMIMEType
		  FileName
		  FineTuneID
		  FrequencyPenalty
		  Input
		  Instruction
		  Language
		  LearningRateMultiplier
		  LogItBias
		  LogProbabilities
		  MaskImage
		  MaxTokens
		  Messages
		  Model
		  NumberOfEpochs
		  NumberOfResults
		  PresencePenalty
		  Prompt
		  PromptLossWeight
		  Purpose
		  ResultsAsType
		  Size
		  SourceImage
		  Stop
		  Suffix
		  Temperature
		  Top_P
		  TrainingFile
		  ValidationFile
		  None
		ResultsAsURL=ValidationError.ResultsAsType
	#tag EndEnum


	#tag ViewBehavior
		#tag ViewProperty
			Name="APIKey"
			Group="Behavior"
			InitialValue="YOUR API KEY HERE"
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
End Module
#tag EndModule
