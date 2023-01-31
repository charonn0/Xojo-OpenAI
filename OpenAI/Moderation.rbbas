#tag Class
Protected Class Moderation
Inherits OpenAI.Response
	#tag Method, Flags = &h1001
		Protected Sub Constructor(ResponseData As JSONItem)
		  // Calling the overridden superclass constructor.
		  // Constructor(ResponseData As JSONItem) -- From Response
		  Super.Constructor(ResponseData)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Create(Request As OpenAI.Request) As OpenAI.Moderation
		  Dim result As JSONItem = SendRequest("/v1/moderations", Request)
		  If result = Nil Or result.HasName("error") Then Raise New OpenAIException(result)
		  Return New OpenAI.Moderation(result)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Create(Prompt As String, Model As OpenAI.Model = Nil) As OpenAI.Moderation
		  Dim request As New OpenAI.Request
		  request.Prompt = Prompt
		  request.Model = Model
		  Return Moderation.Create(request)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Delete()
		  ' Dim result As JSONItem = SendRequest("/v1/files")
		  ' Return New OpenAI.File(result)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetResult(Index As Integer) As Variant
		  Dim results As JSONItem = Super.GetResult(Index)
		  Return results
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
