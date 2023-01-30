#tag Module
Protected Module Examples
	#tag Method, Flags = &h1
		Protected Function CorrectNaturalLanguage(Text As String, Language As String = "English", ResultCount As Integer = 1) As OpenAI.Completion
		  Return OpenAI.Completion.Edit(Text, "Correct this to standard " + Language, ResultCount)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ExplainSourceCode(SourceCode As String) As OpenAI.Completion
		  Return OpenAI.Completion.Create(SourceCode, 1, OpenAI.Model.GetByName("code-davinci-002"))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GeneratePicture(Prompt As String) As Picture
		  Dim result As OpenAI.Response = OpenAI.Image.Generate(Prompt)
		  If result.ResultCount > 0 Then Return result.GetResult(0)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function TranslateNaturalLanguage(Prompt As String, SourceLanguage As String, OutputLanguage As String) As OpenAI.Completion
		  Prompt = "Translate this from " + SourceLanguage + " into " + OutputLanguage + ": " + EndOfLine.UNIX + EndOfLine.UNIX + Prompt
		  Return OpenAI.Completion.Create(Prompt)
		End Function
	#tag EndMethod


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
