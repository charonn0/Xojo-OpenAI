#tag Class
Protected Class FineTune
Inherits OpenAI.Response
	#tag Method, Flags = &h0
		Sub Cancel()
		  Dim result As JSONItem = mClient.SendRequest("/v1/fine-tunes/" + Me.ID + "/cancel", "POST")
		  If result.HasName("error") Then Raise New OpenAIException(result)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1001
		Protected Sub Constructor(ResponseData As JSONItem, Client As OpenAIClient)
		  // Calling the overridden superclass constructor.
		  // Constructor(ResponseData As JSONItem) -- From Response
		  Super.Constructor(ResponseData)
		  mClient = Client
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Create(Request As OpenAI.Request) As OpenAI.FineTune
		  Dim client As New OpenAIClient
		  Dim result As JSONItem = client.SendRequest("/v1/fine-tunes", Request)
		  If result = Nil Or result.HasName("error") Then Raise New OpenAIException(result)
		  Return New OpenAI.FineTune(result, client)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Create(TrainingFileID As String) As OpenAI.FineTune
		  Dim request As New OpenAI.Request
		  request.TrainingFile = TrainingFileID
		  Return FineTune.Create(request)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Delete()
		  Dim result As JSONItem = mclient.SendRequest("/v1/models/" + Me.ID, "DELETE")
		  If result.HasName("error") Then Raise New OpenAIException(result)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetResult(Index As Integer = 0) As Variant
		  ' Returns the result at Index, as a JSONItem.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Response.GetResult
		  
		  Dim results As JSONItem = Super.GetResult(Index)
		  Return results
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function List() As OpenAI.FineTune
		  Dim client As New OpenAIClient
		  Dim result As JSONItem = client.SendRequest("/v1/fine-tunes")
		  If result = Nil Or result.HasName("error") Then Raise New OpenAIException(result)
		  Return New OpenAI.FineTune(result, client)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ListEvents() As JSONItem
		  Dim result As JSONItem = mClient.SendRequest("/v1/fine-tunes/" + Me.ID + "/events")
		  If result.HasName("error") Then Raise New OpenAIException(result)
		  Return result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Open(FineTuneID As String) As OpenAI.FineTune
		  Dim client As New OpenAIClient
		  Dim result As JSONItem = client.SendRequest("/v1/fine-tunes/" + FineTuneID)
		  If result = Nil Or result.HasName("error") Then Raise New OpenAIException(result)
		  Return New OpenAI.FineTune(result, client)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ResultType(Index As Integer = 0) As OpenAI.ResultType
		  #pragma Unused Index
		  Return OpenAI.ResultType.JSONObject
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mClient As OpenAIClient
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
