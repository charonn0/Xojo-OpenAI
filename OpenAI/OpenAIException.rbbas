#tag Class
Protected Class OpenAIException
Inherits RuntimeException
	#tag Method, Flags = &h1000
		Sub Constructor(ErrorObject As JSONItem)
		  If ErrorObject <> Nil Then
		    ErrorObject = ErrorObject.Value("error")
		    If ErrorObject.Value("message") <> Nil Then Me.Message = ErrorObject.Value("message")
		    If ErrorObject.Value("type") <> Nil Then Me.Message = Me.Message + EndOfLine + ErrorObject.Value("type")
		    If ErrorObject.Value("param") <> Nil Then Me.Message = Me.Message + EndOfLine + "Param:" + ErrorObject.Value("param")
		    If ErrorObject.Value("code") <> Nil Then Me.Message = Me.Message + EndOfLine + "Code:" + ErrorObject.Value("code")
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1000
		Sub Constructor(Message As String)
		  Me.Message = Message
		End Sub
	#tag EndMethod


	#tag ViewBehavior
		#tag ViewProperty
			Name="ErrorNumber"
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			InheritedFrom="RuntimeException"
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
			Name="Message"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
			InheritedFrom="RuntimeException"
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
End Class
#tag EndClass
