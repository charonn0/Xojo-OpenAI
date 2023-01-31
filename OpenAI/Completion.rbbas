#tag Class
Protected Class Completion
Inherits OpenAI.Response
	#tag Method, Flags = &h1001
		Protected Sub Constructor(ResponseData As JSONItem)
		  // Calling the overridden superclass constructor.
		  // Constructor(ResponseData As JSONItem) -- From Response
		  Super.Constructor(ResponseData)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Create(Request As OpenAI.Request) As OpenAI.Completion
		  Dim response As JSONItem = SendRequest("/v1/completions", request)
		  Return New OpenAI.Completion(response)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Create(Prompt As String, ResultCount As Integer = 1, Model As OpenAI.Model = Nil) As OpenAI.Completion
		  Dim request As New OpenAI.Request()
		  If Model = Nil Then Model = OpenAI.Model.Lookup("text-davinci-003")
		  request.Model = Model
		  request.Prompt = Prompt
		  If ResultCount > 1 Then request.NumberOfResults = ResultCount
		  Return Completion.Create(request)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Edit(Request As OpenAI.Request) As OpenAI.Completion
		  Dim response As JSONItem = SendRequest("/v1/edits", request)
		  Return New OpenAI.Completion(response)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Edit(TextToEdit As String, EditInstruction As String, ResultCount As Integer = 1, Model As OpenAI.Model = Nil) As OpenAI.Completion
		  Dim request As New OpenAI.Request
		  If Model = Nil Then Model = OpenAI.Model.Lookup("text-davinci-edit-001")
		  request.Model = Model
		  request.Input = TextToEdit
		  request.Instruction = EditInstruction
		  If ResultCount > 1 Then request.NumberOfResults = ResultCount
		  Return Completion.Edit(request)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetResult(Index As Integer) As Variant
		  Dim results As JSONItem = Super.GetResult(Index)
		  If results.HasName("text") Then
		    Return DefineEncoding(results.Value("text"), Encodings.UTF8)
		  End If
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
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			InheritedFrom="Object"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
