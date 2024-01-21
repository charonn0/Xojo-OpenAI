#tag Class
Protected Class Request
	#tag Method, Flags = &h0
		Sub Constructor(Optional LoadFrom As JSONItem)
		  ' Creates a new, Request object. If LoadFrom is specified then it will be used 
		  ' to populate the request.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Request.Constructor
		  
		  If LoadFrom <> Nil Then
		    mRequest = LoadFrom
		  Else
		    mRequest = New JSONItem
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsSet(KeyName As String) As Boolean
		  ' Checks for the existence of the specified request parameter. The KeyName must exactly
		  ' match the parameter name used by the API, which might not match the name of property
		  ' exposed by this class. For example, the NumberOfResults property corresponds to the "n"
		  ' API parameter.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Request.IsSet
		  
		  Return mRequest.HasName(KeyName)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Convert() As JSONItem
		  ' Returns the raw JSON for the request in preparation for transmission.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Request.Operator_Convert
		  
		  Return mRequest
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Set(KeyName As String, KeyValue As Variant)
		  ' Sets the specified request parameter. The KeyName must exactly match the parameter
		  ' name used by the API, which might not match the name of property exposed by this class.
		  ' For example, the NumberOfResults property corresponds to the "n" API parameter.
		  ' The KeyValue must be the correct type and format for the parameter.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Request.Set
		  
		  Const ARRAY_TYPE = 4096
		  If BitAnd(VarType(KeyValue), ARRAY_TYPE) = ARRAY_TYPE Then
		    Dim js As New JSONItem
		    
		    Select Case BitXor(VarType(KeyValue), ARRAY_TYPE)
		    Case Variant.TypeString
		      Dim v() As String = KeyValue
		      For i As Integer = 0 To UBound(v)
		        js.Append(v(i))
		      Next
		    Case Variant.TypeInteger
		      Dim v() As Integer = KeyValue
		      For i As Integer = 0 To UBound(v)
		        js.Append(v(i))
		      Next
		    Else
		      Raise New OpenAIException("Invalid data type for this request.")
		    End Select
		    mRequest.Value(KeyName) = js
		    
		  Else
		    mRequest.Value(KeyName) = KeyValue
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UnSet(KeyName As String)
		  ' Deletes the specified request parameter. The KeyName must exactly match the parameter
		  ' name used by the API, which might not match the name of property exposed by this class.
		  ' For example, the NumberOfResults property corresponds to the "n" API parameter.
		  ' The KeyValue must be the correct type and format for the parameter.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Request.UnSet
		  
		  If mRequest.HasName(KeyName) Then mRequest.Remove(KeyName)
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mRequest.HasName("batch_size") Then Return mRequest.Value("batch_size") Else Return 1
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mRequest.Value("batch_size") = CType(Max(value, 1), Integer)
			End Set
		#tag EndSetter
		BatchSize As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mRequest.HasName("best_of") Then Return mRequest.Value("best_of") Else Return 1
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mRequest.Value("best_of") = CType(Max(value, 1), Integer)
			End Set
		#tag EndSetter
		BestOf As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mRequest.HasName("classification_betas") Then Return mRequest.Value("classification_betas")
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mRequest.Value("classification_betas") = value
			End Set
		#tag EndSetter
		ClassificationBetas As JSONItem
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mRequest.HasName("classification_n_classes") Then Return mRequest.Value("classification_n_classes") Else Return 1
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mRequest.Value("classification_n_classes") = CType(Max(value, 1), Integer)
			End Set
		#tag EndSetter
		ClassificationNClasses As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mRequest.HasName("classification_positive_class") Then Return mRequest.Value("classification_positive_class")
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mRequest.Value("classification_positive_class") = value
			End Set
		#tag EndSetter
		ClassificationPositiveClass As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mRequest.HasName("compute_classification_metrics") Then Return mRequest.Value("compute_classification_metrics")
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mRequest.Value("compute_classification_metrics") = value
			End Set
		#tag EndSetter
		ComputeClassificationMetrics As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mRequest.HasName("echo") Then Return mRequest.Value("echo")
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mRequest.Value("echo") = value
			End Set
		#tag EndSetter
		Echo As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mFileContent
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mFileContent = Value
			End Set
		#tag EndSetter
		File As MemoryBlock
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mFileMIMEType
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mFileMIMEType = value
			End Set
		#tag EndSetter
		FileMIMEType As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mFileName
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mFileName = value
			  If mFileMIMEType = "" Then FileMIMEType = MIMEType(SpecialFolder.Temporary.Child(mFileName))
			End Set
		#tag EndSetter
		FileName As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mRequest.HasName("fine_tune_id") Then Return mRequest.Value("fine_tune_id")
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mRequest.Value("fine_tune_id") = value
			End Set
		#tag EndSetter
		FineTuneID As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mRequest.HasName("frequency_penalty") Then Return mRequest.Value("frequency_penalty")
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mRequest.Value("frequency_penalty") = value
			End Set
		#tag EndSetter
		FrequencyPenalty As Single
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mRequest.HasName("quality") Then Return (mRequest.Value("quality") = "hd")
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If value Then
			    Set("quality", "hd")
			  Else
			    UnSet("quality")
			  End If
			End Set
		#tag EndSetter
		HighQuality As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mRequest.HasName("input") Then Return mRequest.Value("input")
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mRequest.Value("input") = value
			End Set
		#tag EndSetter
		Input As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mRequest.HasName("instruction") Then Return mRequest.Value("instruction")
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mRequest.Value("instruction") = value
			End Set
		#tag EndSetter
		Instruction As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mRequest.HasName("language") Then Return mRequest.Value("language")
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mRequest.Value("language") = value
			End Set
		#tag EndSetter
		Language As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mRequest.HasName("learning_rate_multiplier") Then Return mRequest.Value("learning_rate_multiplier")
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mRequest.Value("learning_rate_multiplier") = value
			End Set
		#tag EndSetter
		LearningRateMultiplier As Single
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mRequest.HasName("logit_bias") Then Return mRequest.Value("logit_bias")
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mRequest.Value("logit_bias") = value
			End Set
		#tag EndSetter
		LogItBias As JSONItem
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mRequest.HasName("logprobs") Then Return mRequest.Value("logprobs")
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mRequest.Value("logprobs") = value
			End Set
		#tag EndSetter
		LogProbabilities As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mMaskImage
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If value <> Nil And value.Width <> value.Height Then Raise New UnsupportedFormatException
			  mMaskImage = value
			End Set
		#tag EndSetter
		MaskImage As Picture
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mRequest.HasName("max_tokens") Then Return mRequest.Value("max_tokens")
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mRequest.Value("max_tokens") = value
			End Set
		#tag EndSetter
		MaxTokens As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mRequest.HasName("messages") Then Return mRequest.Value("messages")
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mRequest.Value("messages") = value
			End Set
		#tag EndSetter
		Messages As JSONItem
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mFileContent As MemoryBlock
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFileMIMEType As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFileName As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMaskImage As Picture
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mRequest.HasName("model") Then
			    Dim mdl As String = mRequest.Value("model")
			    Return OpenAI.Model.Lookup(mdl)
			  End If
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mRequest.Value("model") = value.ID
			End Set
		#tag EndSetter
		Model As OpenAI.Model
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mRequest As JSONItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSourceImage As Picture
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mRequest.HasName("n_epochs") Then Return mRequest.Value("n_epochs") Else Return 1
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mRequest.Value("n_epochs") = CType(Max(value, 1), Integer)
			End Set
		#tag EndSetter
		NumberOfEpochs As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mRequest.HasName("n") Then Return mRequest.Value("n") Else Return 1
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mRequest.Value("n") = CType(Max(value, 1), Integer)
			End Set
		#tag EndSetter
		NumberOfResults As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mRequest.HasName("presence_penalty") Then Return mRequest.Value("presence_penalty")
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mRequest.Value("presence_penalty") = value
			End Set
		#tag EndSetter
		PresencePenalty As Single
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mRequest.HasName("prompt") Then Return mRequest.Value("prompt")
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mRequest.Value("prompt") = value
			End Set
		#tag EndSetter
		Prompt As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mRequest.HasName("prompt_loss_weight") Then Return mRequest.Value("prompt_loss_weight")
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mRequest.Value("prompt_loss_weight") = value
			End Set
		#tag EndSetter
		PromptLossWeight As Single
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mRequest.HasName("purpose") Then Return mRequest.Value("purpose")
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mRequest.Value("purpose") = value
			End Set
		#tag EndSetter
		Purpose As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mRequest.Lookup("response_format", "")
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mRequest.Value("response_format") = value
			End Set
		#tag EndSetter
		ResponseFormat As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return ResponseFormat = "aac"
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If value Then
			    ResponseFormat = "aac"
			  Else
			    UnSet("response_format")
			  End If
			End Set
		#tag EndSetter
		ResultsAsAAC As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return ResponseFormat = "b64_json"
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If value Then
			    ResponseFormat = "b64_json"
			  Else
			    UnSet("response_format")
			  End If
			End Set
		#tag EndSetter
		ResultsAsBase64 As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return ResponseFormat = "flac"
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If value Then
			    ResponseFormat = "flac"
			  Else
			    UnSet("response_format")
			  End If
			End Set
		#tag EndSetter
		ResultsAsFLAC As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return ResponseFormat = "json"
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If value Then
			    ResponseFormat = "json"
			  Else
			    UnSet("response_format")
			  End If
			End Set
		#tag EndSetter
		ResultsAsJSON As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return ResponseFormat = "verbose_json"
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If value Then
			    ResponseFormat = "verbose_json"
			  Else
			    UnSet("response_format")
			  End If
			End Set
		#tag EndSetter
		ResultsAsJSON_Verbose As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return ResponseFormat = "mp3"
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If value Then
			    ResponseFormat = "mp3"
			  Else
			    UnSet("response_format")
			  End If
			End Set
		#tag EndSetter
		ResultsAsMP3 As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return ResponseFormat = "opus"
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If value Then
			    ResponseFormat = "opus"
			  Else
			    UnSet("response_format")
			  End If
			End Set
		#tag EndSetter
		ResultsAsOpus As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return ResponseFormat = "srt"
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If value Then
			    ResponseFormat = "srt"
			  Else
			    UnSet("response_format")
			  End If
			End Set
		#tag EndSetter
		ResultsAsSRT As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return ResponseFormat = "text"
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If value Then
			    ResponseFormat = "text"
			  Else
			    UnSet("response_format")
			  End If
			End Set
		#tag EndSetter
		ResultsAsText As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return ResponseFormat = "url"
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If value Then
			    ResponseFormat = "url"
			  Else
			    ResponseFormat = "b64_json"
			  End If
			End Set
		#tag EndSetter
		ResultsAsURL As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return ResponseFormat = "vtt"
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If value Then
			    ResponseFormat = "vtt"
			  Else
			    UnSet("response_format")
			  End If
			End Set
		#tag EndSetter
		ResultsAsVTT As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mRequest.HasName("size") Then
			    Return mRequest.Value("size")
			  ElseIf SourceImage <> Nil Then
			    Return "1024x1024"
			  End If
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mRequest.Value("size") = value
			End Set
		#tag EndSetter
		Size As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mSourceImage
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If value <> Nil And value.Width <> value.Height Then Raise New UnsupportedFormatException
			  mSourceImage = value
			End Set
		#tag EndSetter
		SourceImage As Picture
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mRequest.HasName("speed") Then Return mRequest.Value("speed")
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mRequest.Value("speed") = value
			End Set
		#tag EndSetter
		Speed As Single
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mRequest.HasName("stop") Then Return mRequest.Value("stop")
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mRequest.Value("stop") = value
			End Set
		#tag EndSetter
		Stop As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mRequest.Lookup("style", "")
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mRequest.Value("style") = value
			End Set
		#tag EndSetter
		Style As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mRequest.HasName("suffix") Then Return mRequest.Value("suffix")
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mRequest.Value("suffix") = value
			End Set
		#tag EndSetter
		Suffix As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mRequest.HasName("temperature") Then Return mRequest.Value("temperature")
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mRequest.Value("temperature") = value
			End Set
		#tag EndSetter
		Temperature As Single
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mRequest.HasName("top_logprobs") Then Return mRequest.Value("top_logprobs") Else Return 0
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mRequest.Value("top_logprobs") = value
			End Set
		#tag EndSetter
		TopLogProbabilities As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mRequest.HasName("top_p") Then Return mRequest.Value("top_p")
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mRequest.Value("top_p") = value
			End Set
		#tag EndSetter
		Top_P As Single
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mRequest.HasName("training_file") Then Return mRequest.Value("training_file")
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mRequest.Value("training_file") = value
			End Set
		#tag EndSetter
		TrainingFile As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mRequest.HasName("user") Then Return mRequest.Value("user")
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mRequest.Value("user") = value
			End Set
		#tag EndSetter
		User As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mRequest.HasName("validation_file") Then Return mRequest.Value("validation_file")
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mRequest.Value("training_file") = value
			End Set
		#tag EndSetter
		ValidationFile As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mRequest.Lookup("voice", "")
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mRequest.Value("voice") = value
			End Set
		#tag EndSetter
		Voice As String
	#tag EndComputedProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="BatchSize"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="BestOf"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ClassificationNClasses"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ClassificationPositiveClass"
			Group="Behavior"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ComputeClassificationMetrics"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Echo"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="FineTuneID"
			Group="Behavior"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="FrequencyPenalty"
			Group="Behavior"
			Type="Single"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Input"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Instruction"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LearningRateMultiplier"
			Group="Behavior"
			Type="Single"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LogProbabilities"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="MaskImage"
			Group="Behavior"
			Type="Picture"
		#tag EndViewProperty
		#tag ViewProperty
			Name="MaxTokens"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="NumberOfEpochs"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="NumberOfResults"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="PresencePenalty"
			Group="Behavior"
			Type="Single"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Prompt"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="PromptLossWeight"
			Group="Behavior"
			Type="Single"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ResultsAsURL"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Size"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="SourceImage"
			Group="Behavior"
			Type="Picture"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Stop"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Suffix"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Temperature"
			Group="Behavior"
			Type="Single"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top_P"
			Group="Behavior"
			Type="Single"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TrainingFile"
			Group="Behavior"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="User"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ValidationFile"
			Group="Behavior"
			Type="String"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
