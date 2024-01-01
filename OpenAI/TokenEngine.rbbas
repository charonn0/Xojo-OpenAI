#tag Class
Protected Class TokenEngine
	#tag Method, Flags = &h0
		Function AlternateProbabilities(TokenIndex As Integer) As Double()
		  Dim probs() As Double
		  If mLogProbs = Nil Then Return probs
		  Dim logprobs As JSONItem = mLogProbs.Value("content")
		  logprobs = logprobs.Value(TokenIndex)
		  If logprobs = Nil Then Return probs
		  logprobs = logprobs.Value("top_logprobs")
		  If logprobs = Nil Then Return probs
		  For i As Integer = 0 To logprobs.Count - 1
		    Dim tkn As JSONItem = logprobs.Child(i)
		    Dim prob As Double = tkn.Value("logprob")
		    probs.Append(prob)
		  Next
		  Return probs
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Alternates(TokenIndex As Integer) As Dictionary
		  Dim alts() As String = Me.AlternateTokens(TokenIndex)
		  Dim probs() As Double = Me.AlternateProbabilities(TokenIndex)
		  Dim token As New Dictionary
		  For k As Integer = 0 To UBound(alts)
		    token.Value(alts(k)) = probs(k)
		  Next
		  Return token
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AlternateTokens(TokenIndex As Integer) As String()
		  Dim alts() As String
		  If mLogProbs = Nil Then Return alts
		  Dim logprobs As JSONItem = mLogProbs.Value("content")
		  logprobs = logprobs.Value(TokenIndex)
		  If logprobs = Nil Then Return alts
		  logprobs = logprobs.Value("top_logprobs")
		  If logprobs = Nil Then Return alts
		  For i As Integer = 0 To logprobs.Count - 1
		    Dim tkn As JSONItem = logprobs.Child(i)
		    Dim name As String = tkn.Value("token")
		    alts.Append(name.Trim)
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
		  Dim tokens As JSONItem = mLogProbs.Value("content")
		  If tokens = Nil Then Return 0.0
		  tokens = tokens.Child(TokenIndex)
		  Dim prob As Double = tokens.Value("logprob")
		  Return prob
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Token(TokenIndex As Integer) As String
		  If mLogProbs = Nil Then Return ""
		  Dim tokens As JSONItem = mLogProbs.Value("content")
		  If tokens = Nil Then Return ""
		  tokens = tokens.Child(TokenIndex)
		  Dim token As String = tokens.Value("token")
		  Return token
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mLogProbs = Nil Then Return 0
			  Dim t As JSONItem = mLogProbs.Value("content")
			  Return t.Count
			End Get
		#tag EndGetter
		Count As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mLogProbs As JSONItem
	#tag EndProperty


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
