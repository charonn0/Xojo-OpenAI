#tag Class
Protected Class File
Inherits OpenAI.Response
	#tag Method, Flags = &h1001
		Protected Sub Constructor(ResponseData As JSONItem)
		  // Calling the overridden superclass constructor.
		  // Constructor(ResponseData As JSONItem) -- From Response
		  Super.Constructor(ResponseData)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Create(FileContent As MemoryBlock, Purpose As String) As OpenAI.File
		  ' Upload a file that contains document(s) to be used across various endpoints/features.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.File.Create
		  ' https://beta.openai.com/docs/api-reference/files/upload
		  
		  Dim request As New OpenAI.Request
		  request.File = FileContent
		  request.Purpose = Purpose
		  Dim result As JSONItem = SendRequest("/v1/files", request)
		  If result = Nil Or result.HasName("error") Then Raise New OpenAIException(result)
		  Return New OpenAI.File(result)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Delete()
		  ' Deletes the specified file
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.File.Delete
		  
		  #pragma Warning "FixMe"
		  ' Dim result As JSONItem = SendRequest("/v1/files")
		  ' Return New OpenAI.File(result)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetResult(Index As Integer) As Variant
		  ' Returns the result as a OpenAI.File. The Index parameter is ignored.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.File.GetResult
		  
		  #pragma Unused Index
		  If mResponse.HasName("filename") Then
		    Dim result As JSONItem = SendRequest("/v1/files/" + ID + "/content")
		    Return New OpenAI.File(result)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function List() As OpenAI.File
		  ' Returns a list of files that belong to the user's organization.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.File.List
		  ' https://beta.openai.com/docs/api-reference/files/list
		  
		  Dim result As JSONItem = SendRequest("/v1/files")
		  If result = Nil Or result.HasName("error") Then Raise New OpenAIException(result)
		  Return New OpenAI.File(result)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Open(FileID As String) As OpenAI.File
		  ' Returns the contents of the specified file
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.File.Open
		  ' https://beta.openai.com/docs/api-reference/files/retrieve-content
		  
		  Dim result As JSONItem = SendRequest("/v1/files/" + FileID + "/content")
		  If result = Nil Or result.HasName("error") Then Raise New OpenAIException(result)
		  Return New OpenAI.File(result)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ResultType(Index As Integer) As OpenAI.ResultType
		  #pragma Unused Index
		  Return OpenAI.ResultType.FileObject
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' Returns the size in bytes of the specified file
			  '
			  ' See:
			  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.File.Bytes
			  
			  Return mResponse.Value("bytes")
			  
			  Exception err As KeyNotFoundException
			    Return 0
			End Get
		#tag EndGetter
		Bytes As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' Returns the creation date of the specified file
			  '
			  ' See:
			  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.File.CreatedAt
			  
			  Return time_t(mResponse.Value("created_at"))
			  
			  Exception err As KeyNotFoundException
			    Return Nil
			End Get
		#tag EndGetter
		CreatedAt As Date
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' Returns the name of the specified file
			  '
			  ' See:
			  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.File.Name
			  
			  Return mResponse.Value("filename")
			  
			  Exception err As KeyNotFoundException
			    Return ""
			End Get
		#tag EndGetter
		Name As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' Returns the purpose string of the specified file
			  '
			  ' See:
			  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.File.Purpose
			  
			  Return mResponse.Value("purpose")
			  
			  Exception err As KeyNotFoundException
			    Return ""
			End Get
		#tag EndGetter
		Purpose As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' Returns the object type of the specified file
			  '
			  ' See:
			  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.File.Type
			  
			  Return mResponse.Value("object")
			  
			  Exception err As KeyNotFoundException
			    Return ""
			End Get
		#tag EndGetter
		Type As String
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
