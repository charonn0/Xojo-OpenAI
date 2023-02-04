#tag Class
Protected Class FineTune
Inherits OpenAI.Model
	#tag Method, Flags = &h0
		Sub Cancel()
		  Dim result As New JSONItem(mClient.SendRequest("/v1/fine-tunes/" + Me.ID + "/cancel", "POST"))
		  If result.HasName("error") Then Raise New OpenAIException(result)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1001
		Protected Sub Constructor(ResponseData As JSONItem, Client As OpenAIClient)
		  // Calling the overridden superclass constructor.
		  // Constructor(ResponseData As JSONItem) -- From Model
		  Super.Constructor(ResponseData)
		  mClient = Client
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Count() As Integer
		  ' Counts the number of fine tuned models owned by the your organization.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.FineTune.Count
		  
		  If UBound(FineTuneList) = -1 Then ListMyFineTunes()
		  Return UBound(FineTuneList) + 1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Create(TrainingFileID As String) As OpenAI.FineTune
		  Dim client As New OpenAIClient
		  Dim request As New OpenAI.Request
		  request.TrainingFile = TrainingFileID
		  Dim result As New JSONItem(client.SendRequest("/v1/fine-tunes", request))
		  If result = Nil Or result.HasName("error") Then Raise New OpenAIException(result)
		  Return New OpenAI.FineTune(result, client)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Delete()
		  Dim result As New JSONItem(mclient.SendRequest("/v1/models/" + Me.ID, "DELETE"))
		  If result.HasName("error") Then Raise New OpenAIException(result)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ListEvents() As JSONItem
		  Dim result As New JSONItem(mClient.SendRequest("/v1/fine-tunes/" + Me.ID + "/events"))
		  If result.HasName("error") Then Raise New OpenAIException(result)
		  Return result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Sub ListMyFineTunes()
		  ReDim FineTuneList(-1)
		  Dim client As New OpenAIClient
		  Dim lst As New JSONItem(client.SendRequest("/v1/fine-tunes"))
		  If lst = Nil Or Not lst.HasName("data") Then Raise New OpenAIException(lst)
		  lst = lst.Value("data")
		  
		  For i As Integer = 0 To lst.Count - 1
		    FineTuneList.Append(New OpenAI.FineTune(lst.Child(i)))
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Lookup(Index As Integer) As OpenAI.FineTune
		  If UBound(FineTuneList) = -1 Then ListMyFineTunes()
		  Return FineTuneList(Index)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Lookup(FineTuneID As String) As OpenAI.FineTune
		  If UBound(FineTuneList) = -1 Then ListMyFineTunes()
		  For i As Integer = 0 To UBound(FineTuneList)
		    If FineTuneList(i).ID = FineTuneID Then
		      Return FineTuneList(i)
		    End If
		  Next
		  
		  Dim err As New OpenAIException(Nil)
		  err.Message = "Invalid FineTune ID."
		  Raise err
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private Shared FineTuneList() As FineTune
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="ID"
			Group="Behavior"
			Type="String"
			InheritedFrom="OpenAI.Response"
		#tag EndViewProperty
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
