#tag Class
Protected Class File
Inherits OpenAI.Response
	#tag Method, Flags = &h1001
		Protected Sub Constructor(ResponseData As JSONItem, Client As OpenAIClient)
		  // Calling the overridden superclass constructor.
		  // Constructor(ResponseData As JSONItem, Client As OpenAIClient) -- From Response
		  Super.Constructor(ResponseData, Client)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Count() As Integer
		  ' Returns the number of files that belong to the user's organization.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.File.Count
		  
		  Dim list As OpenAI.File = OpenAI.File.ListAllFiles(New OpenAIClient)
		  Return list.ResultCount
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Create(FileContent As MemoryBlock, Purpose As String) As OpenAI.File
		  ' Upload a file that contains document(s) to be used across various endpoints/features.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.File.Create
		  ' https://beta.openai.com/docs/api-reference/files/upload
		  
		  Dim request As New OpenAI.Request
		  Dim client As New OpenAIClient
		  request.File = FileContent
		  request.Purpose = Purpose
		  Dim result As New JSONItem(client.SendRequest("/v1/files", request))
		  If result = Nil Or result.HasName("error") Then Raise New OpenAIException(result)
		  Return New OpenAI.File(result, client)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Delete()
		  ' Deletes the specified file
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.File.Delete
		  
		  Dim result As New JSONItem(mClient.SendRequest("/v1/files", "DELETE"))
		  If result.HasName("error") Then Raise New OpenAIException(result)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetResult(Index As Integer = 0) As Variant
		  ' Returns the contents of the OpenAI.File. The Index parameter is ignored.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.File.GetResult
		  
		  #pragma Unused Index
		  If mResponse.HasName("filename") Then
		    Return mClient.SendRequest("/v1/files/" + ID + "/content")
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Shared Function ListAllFiles(Client As OpenAIClient) As OpenAI.File
		  Dim result As New JSONItem(Client.SendRequest("/v1/files"))
		  If result = Nil Or result.HasName("error") Then Raise New OpenAIException(result)
		  Return New OpenAI.File(result, Client)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Lookup(Index As Integer) As OpenAI.File
		  ' Returns a File object for the file at Index
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.File.Lookup
		  
		  Dim client As New OpenAIClient
		  Dim list As OpenAI.File = OpenAI.File.ListAllFiles(client)
		  Dim js As JSONItem = list.GetResult(Index)
		  If js.HasName("object") And js.Value("object") = "file" Then Return New File(js, client)
		  Raise New OpenAIException(js)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Lookup(FileID As String) As OpenAI.File
		  ' Returns a File object for the specified file
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.File.Lookup
		  
		  Dim client As New OpenAIClient
		  Dim list As OpenAI.File = OpenAI.File.ListAllFiles(client)
		  For i As Integer = 0 To list.ResultCount - 1
		    Dim js As JSONItem = list.GetResult(i)
		    If js.Value("id") = FileID Then Return New File(js, client)
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ResultType(Index As Integer = 0) As OpenAI.ResultType
		  #pragma Unused Index
		  Return OpenAI.ResultType.String
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
