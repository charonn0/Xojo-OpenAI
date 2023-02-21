#tag Class
Protected Class TokenEngine
	#tag Method, Flags = &h0
		Function AlternateProbabilities(TokenIndex As Integer) As Double()
		  Dim probs() As Double
		  If mLogProbs = Nil Then Return probs
		  Dim logprobs As JSONItem = mLogProbs.Value("top_logprobs")
		  logprobs = logprobs.Value(TokenIndex)
		  If logprobs = Nil Then Return probs
		  For i As Integer = 0 To logprobs.Count - 1
		    Dim tkn As String = logprobs.Name(i)
		    Dim prob As Double = logprobs.Value(tkn)
		    probs.Append(prob)
		  Next
		  Return probs
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Alternates(TokenIndex As Integer) As String()
		  Dim alts() As String
		  If mLogProbs = Nil Then Return alts
		  Dim logprobs As JSONItem = mLogProbs.Value("top_logprobs")
		  logprobs = logprobs.Value(TokenIndex)
		  If logprobs = Nil Then Return alts
		  For i As Integer = 0 To logprobs.Count - 1
		    Dim tkn As String = logprobs.Name(i)
		    alts.Append(tkn)
		  Next
		  Return alts
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Constructor(Result As OpenAI.Response, ResultIndex As Integer)
		  mLogProbs = Result.GetResultAttribute(ResultIndex, "logprobs")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Probability(TokenIndex As Integer) As Double
		  If mLogProbs = Nil Then Return 0.0
		  Dim logprobs As JSONItem = mLogProbs.Value("token_logprobs")
		  If logprobs.Value(TokenIndex) = Nil Then Return 0.0
		  Dim prob As Double = logprobs.Value(TokenIndex)
		  Return prob
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Token(TokenIndex As Integer) As String
		  If mLogProbs = Nil Then Return ""
		  Dim tokens As JSONItem = mLogProbs.Value("tokens")
		  If tokens = Nil Then Return ""
		  Dim token As String = tokens.Value(TokenIndex)
		  Return token
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToString() As String
		  If mLogProbs = Nil Then Return ""
		  Return mLogProbs.ToString()
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mLogProbs As JSONItem
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mLogProbs = Nil Then Return 0
			  Dim t As JSONItem = mLogProbs.Value("tokens")
			  Return t.Count
			End Get
		#tag EndGetter
		TokenCount As Integer
	#tag EndComputedProperty


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
			Name="TokenCount"
			Group="Behavior"
			Type="Integer"
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
