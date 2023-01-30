#tag Class
Protected Class Request
	#tag Method, Flags = &h0
		Sub Constructor()
		  mRequest = New JSONItem
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToJSON() As MemoryBlock
		  mRequest.Compact = True
		  Return mRequest.ToString()
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mRequest.HasName("best_of") Then Return mRequest.Value("best_of") Else Return 1
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mRequest.Value("best_of") = Max(value, 1)
			End Set
		#tag EndSetter
		BestOf As Integer
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
		Echo As Boolean
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
		Private mMaskImage As Picture
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return OpenAI.Models.GetByName(mRequest.Value("model"))
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mRequest.Value("model") = value.ID
			End Set
		#tag EndSetter
		Model As OpenAI.Model
	#tag EndComputedProperty

	#tag Property, Flags = &h1
		Protected mRequest As JSONItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSourceImage As Picture
	#tag EndProperty

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
			  Return mRequest.Value("prompt")
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
			  If mRequest.HasName("size") Then Return mRequest.Value("size") Else Return "1024x1024"
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


	#tag ViewBehavior
		#tag ViewProperty
			Name="BestOf"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Echo"
			Group="Behavior"
			Type="Boolean"
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
			Name="User"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
