#tag Class
Protected Class FineTune
Inherits OpenAI.Response
	#tag Method, Flags = &h0
		Sub Cancel()
		  Dim result As JSONItem = SendRequest("/v1/fine-tunes/" + Me.ID + "/cancel") ' should be POST
		  If result.HasName("error") Then Raise New OpenAIException(result)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1001
		Protected Sub Constructor(ResponseData As JSONItem)
		  // Calling the overridden superclass constructor.
		  // Constructor(ResponseData As JSONItem) -- From Response
		  Super.Constructor(ResponseData)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Create(Request As OpenAI.Request) As OpenAI.FineTune
		  Dim result As JSONItem = SendRequest("/v1/fine-tunes", Request)
		  If result = Nil Or result.HasName("error") Then Raise New OpenAIException(result)
		  Return New OpenAI.FineTune(result)
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
		  Dim result As JSONItem = SendRequest("/v1/models/" + Me.ID) ' should be DELETE
		  If result.HasName("error") Then Raise New OpenAIException(result)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetResult(Index As Integer) As Variant
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
		  Dim result As JSONItem = SendRequest("/v1/fine-tunes")
		  If result = Nil Or result.HasName("error") Then Raise New OpenAIException(result)
		  Return New OpenAI.FineTune(result)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ListEvents() As JSONItem
		  Dim result As JSONItem = SendRequest("/v1/fine-tunes/" + Me.ID + "/events")
		  If result.HasName("error") Then Raise New OpenAIException(result)
		  Return result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Open(FineTuneID As String) As OpenAI.FineTune
		  Dim result As JSONItem = SendRequest("/v1/fine-tunes/" + FineTuneID)
		  If result = Nil Or result.HasName("error") Then Raise New OpenAIException(result)
		  Return New OpenAI.FineTune(result)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ResultType(Index As Integer) As OpenAI.ResultType
		  #pragma Unused Index
		  Return OpenAI.ResultType.JSONObject
		End Function
	#tag EndMethod


	#tag ViewBehavior
		#tag ViewProperty
			Name="Bytes"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ID"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
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
			Name="Purpose"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
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
		#tag ViewProperty
			Name="Type"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
