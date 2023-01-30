#tag Module
Protected Module Models
	#tag Method, Flags = &h1
		Protected Function Count() As Integer
		  If UBound(ModelList) = -1 Then ListAvailableModels()
		  Return UBound(ModelList) + 1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetByIndex(Index As Integer) As OpenAI.Model
		  If UBound(ModelList) = -1 Then ListAvailableModels()
		  Return ModelList(Index)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetByName(ModelName As String) As OpenAI.Model
		  If UBound(ModelList) = -1 Then ListAvailableModels()
		  For i As Integer = 0 To UBound(ModelList)
		    If ModelList(i).ID = ModelName Then Return ModelList(i)
		  Next
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ListAvailableModels()
		  ReDim ModelList(-1)
		  Dim lst As JSONItem = SendRequest("/v1/models")
		  lst = lst.Value("data")
		  
		  For i As Integer = 0 To lst.Count - 1
		    ModelList.Append(New ModelCreator(lst.Child(i)))
		  Next
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private ModelList() As Model
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
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			InheritedFrom="Object"
		#tag EndViewProperty
	#tag EndViewBehavior
End Module
#tag EndModule
