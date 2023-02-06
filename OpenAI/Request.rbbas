#tag Class
Protected Class Request
	#tag Method, Flags = &h0
		Sub Constructor()
		  mRequest = New JSONItem
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToObject() As Variant
		  If SourceImage = Nil And MaskImage = Nil And File = Nil Then
		    mRequest.Compact = True
		    Return mRequest.ToString()
		    
		  ElseIf SourceImage <> Nil Then
		    Dim d As New Dictionary
		    If Size <> "1024x1024" Then d.Value("size") = Size
		    If NumberOfResults > 1 Then d.Value("n") = Str(NumberOfResults, "#0")
		    If ResultsAsURL Then
		      d.Value("response_format") = "url"
		    Else
		      d.Value("response_format") = "b64_json"
		    End If
		    If User <> "" Then d.Value("user") = User
		    If SourceImage <> Nil Then d.Value("image") = SourceImage
		    If MaskImage <> Nil Then d.Value("mask") = MaskImage
		    If Prompt <> "" Then d.Value("prompt") = Prompt
		    Return d
		    
		  ElseIf File <> Nil Then
		    Dim d As New Dictionary
		    d.Value("file") = File
		    d.Value("purpose") = Purpose
		    If User <> "" Then d.Value("user") = User
		    Return d
		  End If
		End Function
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
			  return mFileName
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mFileName = value
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
		LogProbabilities As Integer
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

	#tag Property, Flags = &h21
		Private mFileContent As MemoryBlock
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
			  If mRequest.HasName("response_format") Then
			    Return mRequest.Value("response_format") = "url"
			  End If
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If value Then
			    mRequest.Value("response_format") = "url"
			  Else
			    mRequest.Value("response_format") = "b64_json"
			  End If
			End Set
		#tag EndSetter
		ResultsAsURL As Boolean
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
