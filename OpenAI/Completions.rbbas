#tag Module
Protected Module Completions
	#tag Method, Flags = &h1
		Protected Function Correct(Text As String, Language As String = "English", ResultCount As Integer = 1) As OpenAI.Completion
		  Return Edit(Text, "Correct this to standard " + Language, ResultCount)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Create(Prompt As String, Model As OpenAI.Model = Nil, ResultCount As Integer = 1) As OpenAI.Completion
		  Dim request As New OpenAI.Request()
		  If Model = Nil Then Model = OpenAI.Models.GetByName("text-davinci-003")
		  request.Model = Model
		  request.Prompt = Prompt
		  If ResultCount > 1 Then request.NumberOfResults = ResultCount
		  Dim response As JSONItem = SendRequest("/v1/completions", request)
		  Return New CompletionCreator(response)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Edit(TextToEdit As String, EditInstruction As String, ResultCount As Integer = 1) As OpenAI.Completion
		  Dim request As New OpenAI.Request
		  request.Model = OpenAI.Models.GetByName("text-davinci-edit-001")
		  request.Input = TextToEdit
		  request.Instruction = EditInstruction
		  If ResultCount > 1 Then request.NumberOfResults = ResultCount
		  Dim response As JSONItem = SendRequest("/v1/edits", request)
		  Return New CompletionCreator(response)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ExplainSourceCode(Code As String) As OpenAI.Completion
		  Return Create(Code, OpenAI.Models.GetByName("code-davinci-002"))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function TranslateEnglishText(Prompt As String, OutputLanguage As String) As OpenAI.Completion
		  Return Create("Translate this into " + OutputLanguage + ": " + EndOfLine.UNIX + EndOfLine.UNIX + Prompt)
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
