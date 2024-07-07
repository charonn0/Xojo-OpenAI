#tag Module
Protected Module OpenAI
	#tag Method, Flags = &h1
		Protected Function CosineDistance(VectorA() As Double, VectorB() As Double) As Double
		  ' Given two vectors, this method will calculate the cosine distance between them. The result
		  ' is a Double between -1.0 and +1.0, where +1.0 means completely identical and -1.0 means completely
		  ' different.
		  
		  Return 1.0 - Abs(CosineSimilarity(VectorA, VectorB))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CosineSimilarity(VectorA() As Double, VectorB() As Double) As Double
		  ' Given two vectors, this method will calculate the cosine similarity between them. The result
		  ' is a Double between 0.0 and 1.0, where 1.0 means completely identical and 0.0 means completely
		  ' different.
		  
		  Dim dotProduct, magnitudeA, magnitudeB As Double
		  Dim c As Integer = UBound(VectorA)
		  If c <> UBound(VectorB) Then Raise New OpenAIException("Vector lists must be of the same length to be compared.")
		  
		  For i As Integer = 0 To c
		    dotProduct = dotProduct + (vectorA(i) * vectorB(i))
		    magnitudeA = magnitudeA + (vectorA(i) * vectorA(i))
		    magnitudeB = magnitudeB + (vectorB(i) * vectorB(i))
		  Next
		  
		  magnitudeA = Sqrt(magnitudeA)
		  magnitudeB = Sqrt(magnitudeB)
		  
		  Return dotProduct / (magnitudeA * magnitudeB)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function EstimateTokenCount(Text As String, Method As OpenAI.TokenEstimationMethod = OpenAI.TokenEstimationMethod.Max) As Double
		  ' Method can be Average, Words, Charaters, Max, or Min. Defaults To Max
		  ' Words is the word count divided by 0.75
		  ' Characters is the char count divided by 4
		  ' Average is the average of Words and Characters
		  ' Max is the larger of Words and Characters
		  ' Min is the smaller of Words and Characters
		  
		  Dim wordcount As Integer = CountFields(text, " ")
		  Dim charcount As Integer = text.Len
		  Dim wordestimate As Double = wordcount / 0.75
		  Dim charestimate As Double = charcount / 4.0
		  
		  Static punc() As String = Split("!@#$%^&*()_+=-][\|}{';"":/.,?><`~", "")
		  Dim extratokens As Integer
		  Dim bs As New BinaryStream(Text)
		  Do Until bs.EOF
		    Dim s As String = bs.Read(1)
		    If punc.IndexOf(s) > -1 Then extratokens = extratokens + 1
		  Loop
		  
		  wordestimate = wordestimate + extratokens
		  charestimate = charestimate + extratokens
		  
		  Select Case Method
		  Case TokenEstimationMethod.Average
		    Return (wordestimate + charestimate) / 2
		    
		  Case TokenEstimationMethod.Words
		    Return wordestimate
		    
		  Case TokenEstimationMethod.Characters
		    Return charestimate
		    
		  Case TokenEstimationMethod.Max
		    Return Max(wordestimate, charestimate)
		    
		  Case TokenEstimationMethod.Min
		    Return Min(wordestimate, charestimate)
		    
		  End Select
		End Function
	#tag EndMethod

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

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  Return sProxyAddress
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  sProxyAddress = value
			End Set
		#tag EndSetter
		Protected ProxyAddress As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  Return sProxyPassword
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  sProxyPassword = value
			End Set
		#tag EndSetter
		Protected ProxyPassword As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  Return sProxyPort
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  sProxyPort = value
			End Set
		#tag EndSetter
		Protected ProxyPort As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  Return sProxyType
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  sProxyType = value
			End Set
		#tag EndSetter
		Protected ProxyType As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  Return sProxyUsername
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  sProxyUsername = value
			End Set
		#tag EndSetter
		Protected ProxyUsername As String
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private sProxyAddress As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private sProxyPassword As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private sProxyPort As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private sProxyType As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private sProxyUsername As String
	#tag EndProperty


	#tag Constant, Name = OPENAI_URL, Type = String, Dynamic = False, Default = \"https://api.openai.com", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PROXYTYPE_HTTP, Type = Double, Dynamic = False, Default = \"0", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = PROXYTYPE_HTTP1_0, Type = Double, Dynamic = False, Default = \"1", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = PROXYTYPE_HTTPS, Type = Double, Dynamic = False, Default = \"2", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = PROXYTYPE_HTTPS2, Type = Double, Dynamic = False, Default = \"3", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = PROXYTYPE_SOCKS4, Type = Double, Dynamic = False, Default = \"4", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = PROXYTYPE_SOCKS4A, Type = Double, Dynamic = False, Default = \"6", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = PROXYTYPE_SOCKS5, Type = Double, Dynamic = False, Default = \"5", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = PROXYTYPE_SOCKS5_HOSTNAME, Type = Double, Dynamic = False, Default = \"6", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = USER_AGENT_STRING, Type = String, Dynamic = False, Default = \"Xojo-OpenAI/1.0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = USE_MBS, Type = Boolean, Dynamic = False, Default = \"False", Scope = Private
	#tag EndConstant

	#tag Constant, Name = USE_RBLIBCURL, Type = Boolean, Dynamic = False, Default = \"False", Scope = Private
	#tag EndConstant


	#tag Enum, Name = JobStatus, Type = Integer, Flags = &h1
		Queued
		  ValidatingFiles
		  Running
		  Succeeded
		  Failed
		  Canceled
		Pending
	#tag EndEnum

	#tag Enum, Name = ResultType, Type = Integer, Flags = &h1
		String
		  Picture
		  PictureURL
		  FileObject
		  JSONObject
		  Audio
		VectorList
	#tag EndEnum

	#tag Enum, Name = TokenEstimationMethod, Type = Integer, Flags = &h1
		Average
		  Words
		  Characters
		  Max
		Min
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
		  HighQuality
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
		  Speed
		  SourceImage
		  Stop
		  Style
		  Suffix
		  Temperature
		  Top_P
		  TrainingFile
		  ValidationFile
		  Voice
		  None
		ResultsAsURL=ValidationError.ResultsAsType
	#tag EndEnum


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
