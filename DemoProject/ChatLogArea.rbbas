#tag Class
Protected Class ChatLogArea
Inherits LinkTextArea
	#tag Event
		Sub ClickLink(LinkText As String, LinkValue As Variant)
		  #pragma Unused LinkText
		  If LinkValue = Nil Then Return
		  If LinkValue IsA FolderItem Then
		    Dim f As FolderItem = LinkValue
		    RaiseEvent ClickFileLink(f)
		  ElseIf LinkValue.Type = Variant.TypeString Then
		    RaiseEvent ClickLink(LinkValue.StringValue)
		  End If
		  
		End Sub
	#tag EndEvent

	#tag Event
		Function ConstructContextualMenu(base as MenuItem, x as Integer, y as Integer) As Boolean
		  Call RaiseEvent ConstructContextualMenu(base, x, y)
		  
		  Dim msg As OpenAI.ChatCompletion = FindMessage(x, y)
		  If msg <> Nil Then
		    Dim serialize As New MenuItem("Dump to file...")
		    serialize.Tag = msg
		    base.Append(serialize)
		  End If
		  
		  Return True
		End Function
	#tag EndEvent

	#tag Event
		Function ContextualMenuAction(hitItem as MenuItem) As Boolean
		  If RaiseEvent ContextualMenuAction(hitItem) Then Return True
		  Select Case hitItem.Text
		  Case "Dump to file..."
		    Dim chatmsg As OpenAI.ChatCompletion = hitItem.Tag
		    Dim f As FolderItem = GetSaveFolderItem(".json", "chatmessage.json")
		    If f <> Nil Then
		      Dim s As String = chatmsg.ToString()
		      Dim bs As BinaryStream = BinaryStream.Create(f)
		      bs.Write(s)
		      bs.Close()
		    End If
		  End Select
		  
		  Return True
		  
		End Function
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub AppendMessage(Role As String, Content As String, Original As OpenAI.ChatCompletion)
		  Content = Content.Trim
		  Dim c As Color
		  Select Case Role
		  Case "user"
		    c = &c0000FF00 ' blue
		  Case "assistant"
		    c = &c80000000 ' maroon
		  Case "system"
		    c = &c00000000 ' black
		  Else
		    c = &c53535300 ' dark grey
		  End Select
		  
		  Dim roletxt As New StyleRun
		  roletxt.TextColor = c
		  roletxt.Text = Role.Trim + ": "
		  Me.AppendStyleRun(roletxt, Original)
		  Me.AppendStyleRun(Delimiter)
		  
		  Dim contenttxt As New StyleRun
		  contenttxt.Text = Content + EndOfLine
		  contenttxt.TextColor = c
		  Me.AppendStyleRun(contenttxt, Original)
		  Me.AppendStyleRun(Delimiter)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AppendMessage(Role As String, Content As String, Original As OpenAI.ChatCompletion, Images() As FolderItem)
		  Content = Content.Trim
		  Dim c As Color
		  Select Case Role
		  Case "user"
		    c = &c0000FF00 ' blue
		  Case "assistant"
		    c = &c80000000 ' maroon
		  Case "system"
		    c = &c00000000 ' black
		  Else
		    c = &c53535300 ' dark grey
		  End Select
		  
		  Dim roletxt As New StyleRun
		  roletxt.TextColor = c
		  roletxt.Text = Role.Trim + ": "
		  Me.AppendStyleRun(roletxt, Original)
		  Me.AppendStyleRun(Delimiter)
		  
		  Dim contenttxt As New StyleRun
		  contenttxt.Text = Content + EndOfLine
		  contenttxt.TextColor = c
		  Me.AppendStyleRun(contenttxt, Original)
		  Me.AppendStyleRun(Delimiter)
		  
		  If UBound(Images) > -1 Then
		    Dim attachment As New StyleRun
		    attachment.TextColor = &c53535300 ' dark grey
		    attachment.Text = "Attachments: "
		    Me.AppendStyleRun(attachment)
		    Me.AppendStyleRun(Delimiter)
		    
		    For i As Integer = 0 To UBound(Images)
		      attachment = New StyleRun
		      attachment.TextColor = &c0000FF00 ' blue
		      attachment.Underline = True
		      If i < UBound(Images) Then
		        attachment.Text = Images(i).Name + ", "
		      Else
		        attachment.Text = Images(i).Name + EndOfLine
		      End If
		      Me.AppendStyleRun(attachment, Images(i))
		      Me.AppendStyleRun(Delimiter)
		    Next
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AppendMessage(Role As String, Content As String, Original As OpenAI.ChatCompletion, Images() As String)
		  Content = Content.Trim
		  Dim c As Color
		  Select Case Role
		  Case "user"
		    c = &c0000FF00 ' blue
		  Case "assistant"
		    c = &c80000000 ' maroon
		  Case "system"
		    c = &c00000000 ' black
		  Else
		    c = &c53535300 ' dark grey
		  End Select
		  
		  Dim roletxt As New StyleRun
		  roletxt.TextColor = c
		  roletxt.Text = Role.Trim + ": "
		  Me.AppendStyleRun(roletxt, Original)
		  Me.AppendStyleRun(Delimiter)
		  
		  Dim contenttxt As New StyleRun
		  contenttxt.Text = Content + EndOfLine
		  contenttxt.TextColor = c
		  Me.AppendStyleRun(contenttxt, Original)
		  Me.AppendStyleRun(Delimiter)
		  
		  If UBound(Images) > -1 Then
		    Dim attachment As New StyleRun
		    attachment.TextColor = &c53535300 ' dark grey
		    attachment.Text = "Attachments: "
		    Me.AppendStyleRun(attachment)
		    Me.AppendStyleRun(Delimiter)
		    
		    For i As Integer = 0 To UBound(Images)
		      attachment = New StyleRun
		      attachment.TextColor = &c0000FF00 ' blue
		      attachment.Underline = True
		      If i < UBound(Images) Then
		        attachment.Text = Images(i) + ", "
		      Else
		        attachment.Text = Images(i) + EndOfLine
		      End If
		      Me.AppendStyleRun(attachment, Images(i))
		      Me.AppendStyleRun(Delimiter)
		    Next
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function FindMessage(X As Integer, Y As Integer) As OpenAI.ChatCompletion
		  Dim msg As Variant = FindMetaText(X, Y)
		  If msg IsA OpenAI.ChatCompletion Then Return msg
		  Return Nil
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event ClickFileLink(File As FolderItem)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ClickLink(URL As String)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ConstructContextualMenu(Base As MenuItem, X As Integer, Y As Integer) As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ContextualMenuAction(HitItem As MenuItem) As Boolean
	#tag EndHook


	#tag ViewBehavior
		#tag ViewProperty
			Name="AcceptTabs"
			Visible=true
			Group="Behavior"
			Type="Boolean"
			InheritedFrom="TextArea"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Alignment"
			Visible=true
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType="Enum"
			InheritedFrom="TextArea"
			#tag EnumValues
				"0 - Default"
				"1 - Left"
				"2 - Center"
				"3 - Right"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="AutoDeactivate"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			InheritedFrom="TextArea"
		#tag EndViewProperty
		#tag ViewProperty
			Name="AutomaticallyCheckSpelling"
			Visible=true
			Group="Behavior"
			InitialValue="True"
			Type="boolean"
			InheritedFrom="TextArea"
		#tag EndViewProperty
		#tag ViewProperty
			Name="BackColor"
			Visible=true
			Group="Appearance"
			InitialValue="&hFFFFFF"
			Type="Color"
			InheritedFrom="TextArea"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Bold"
			Visible=true
			Group="Font"
			Type="Boolean"
			InheritedFrom="TextArea"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Border"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			InheritedFrom="TextArea"
		#tag EndViewProperty
		#tag ViewProperty
			Name="DataField"
			Visible=true
			Group="Database Binding"
			Type="String"
			EditorType="DataField"
			InheritedFrom="TextArea"
		#tag EndViewProperty
		#tag ViewProperty
			Name="DataSource"
			Visible=true
			Group="Database Binding"
			Type="String"
			EditorType="DataSource"
			InheritedFrom="TextArea"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Enabled"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			InheritedFrom="TextArea"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Format"
			Visible=true
			Group="Appearance"
			Type="String"
			InheritedFrom="TextArea"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Height"
			Visible=true
			Group="Position"
			InitialValue="100"
			Type="Integer"
			InheritedFrom="TextArea"
		#tag EndViewProperty
		#tag ViewProperty
			Name="HelpTag"
			Visible=true
			Group="Appearance"
			Type="String"
			EditorType="MultiLineEditor"
			InheritedFrom="TextArea"
		#tag EndViewProperty
		#tag ViewProperty
			Name="HideSelection"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			InheritedFrom="TextArea"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			Type="Integer"
			InheritedFrom="TextArea"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Italic"
			Visible=true
			Group="Font"
			Type="Boolean"
			InheritedFrom="TextArea"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			Type="Integer"
			InheritedFrom="TextArea"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LimitText"
			Visible=true
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			InheritedFrom="TextArea"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockBottom"
			Visible=true
			Group="Position"
			Type="Boolean"
			InheritedFrom="TextArea"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockLeft"
			Visible=true
			Group="Position"
			Type="Boolean"
			InheritedFrom="TextArea"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockRight"
			Visible=true
			Group="Position"
			Type="Boolean"
			InheritedFrom="TextArea"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockTop"
			Visible=true
			Group="Position"
			Type="Boolean"
			InheritedFrom="TextArea"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Mask"
			Visible=true
			Group="Behavior"
			Type="String"
			InheritedFrom="TextArea"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Multiline"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			InheritedFrom="TextArea"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
			InheritedFrom="TextArea"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ReadOnly"
			Visible=true
			Group="Behavior"
			Type="Boolean"
			InheritedFrom="TextArea"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ScrollbarHorizontal"
			Visible=true
			Group="Appearance"
			Type="Boolean"
			InheritedFrom="TextArea"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ScrollbarVertical"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			InheritedFrom="TextArea"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Styled"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			InheritedFrom="TextArea"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InheritedFrom="TextArea"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabIndex"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			InheritedFrom="TextArea"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabPanelIndex"
			Group="Position"
			InitialValue="0"
			Type="Integer"
			InheritedFrom="TextArea"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabStop"
			Visible=true
			Group="Position"
			InitialValue="True"
			Type="Boolean"
			InheritedFrom="TextArea"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Text"
			Visible=true
			Group="Initial State"
			Type="String"
			EditorType="MultiLineEditor"
			InheritedFrom="TextArea"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TextColor"
			Visible=true
			Group="Appearance"
			InitialValue="&h000000"
			Type="Color"
			InheritedFrom="TextArea"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TextFont"
			Visible=true
			Group="Font"
			InitialValue="System"
			Type="String"
			InheritedFrom="TextArea"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TextSize"
			Visible=true
			Group="Font"
			InitialValue="0"
			Type="Single"
			InheritedFrom="TextArea"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TextUnit"
			Visible=true
			Group="Font"
			InitialValue="0"
			Type="FontUnits"
			EditorType="Enum"
			InheritedFrom="TextArea"
			#tag EnumValues
				"0 - Default"
				"1 - Pixel"
				"2 - Point"
				"3 - Inch"
				"4 - Millimeter"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			Type="Integer"
			InheritedFrom="TextArea"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Underline"
			Visible=true
			Group="Font"
			Type="Boolean"
			InheritedFrom="TextArea"
		#tag EndViewProperty
		#tag ViewProperty
			Name="UseFocusRing"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			InheritedFrom="TextArea"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Visible"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			InheritedFrom="TextArea"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Width"
			Visible=true
			Group="Position"
			InitialValue="100"
			Type="Integer"
			InheritedFrom="TextArea"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
