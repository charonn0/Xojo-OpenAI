#tag Class
Protected Class ChatCompletionData
	#tag Method, Flags = &h0
		Sub AddMessage(Role As String, Content As String)
		  ' Adds a new message to the end of the chat log.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.ChatCompletionData.AddMessage
		  
		  Dim msg As New JSONItem()
		  msg.Value("role") = Lowercase(Role)
		  msg.Value("content") = Content
		  mMessages.Append(msg)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddMessage(Role As String, Content As String, Images() As Picture)
		  Dim urls() As String
		  For i As Integer = 0 To UBound(Images)
		    urls.Append("data:image/png;base64," + EncodeBase64(Images(i).GetData(Picture.FormatPNG)))
		  Next
		  Me.AddMessage(Role, Content, urls)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddMessage(Role As String, Content As String, Image As Picture)
		  Dim url As String = "data:image/png;base64," + EncodeBase64(Image.GetData(Picture.FormatPNG))
		  Me.AddMessage(Role, Content, url)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddMessage(Role As String, Content As String, ImageURLs() As String)
		  Dim msg As New JSONItem()
		  msg.Value("role") = Lowercase(Role)
		  
		  Dim contents As New JSONItem
		  Dim msg1 As New JSONItem
		  msg1.Value("type") = "text"
		  msg1.Value("text") = Content
		  contents.Append(msg1)
		  
		  For i As Integer = 0 To UBound(ImageURLs)
		    Dim msg2 As New JSONItem
		    msg2.Value("type") = "image_url"
		    Dim url As New JSONItem
		    url.Value("url") = ImageURLs(i)
		    msg2.Value("image_url") = url
		    contents.Append(msg2)
		  Next
		  
		  msg.Value("content") = contents
		  mMessages.Append(msg)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddMessage(Role As String, Content As String, ImageURL As String)
		  Dim msg As New JSONItem()
		  msg.Value("role") = Lowercase(Role)
		  
		  Dim msg1 As New JSONItem
		  msg1.Value("type") = "text"
		  msg1.Value("text") = Content
		  
		  Dim msg2 As New JSONItem
		  msg2.Value("type") = "image_url"
		  Dim url As New JSONItem
		  url.Value("url") = ImageURL
		  msg2.Value("image_url") = url
		  
		  Dim contents As New JSONItem
		  contents.Append(msg1)
		  contents.Append(msg2)
		  
		  msg.Value("content") = contents
		  mMessages.Append(msg)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1000
		Sub Constructor(Optional Messages As JSONItem)
		  ' Creates a new ChatCompletionData instance, optionally initializing the conversation
		  ' with the Messages parameter.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.ChatCompletionData.Constructor
		  
		  If Messages <> Nil Then
		    mMessages = Messages
		  Else
		    mMessages = New JSONItem()
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1000
		Sub Constructor(CopyFrom As OpenAI.ChatCompletionData)
		  ' Creates a new ChatCompletionData instance and initializes it by copying the messages in
		  ' the CopyFrom parameter.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.ChatCompletionData.Constructor
		  
		  Dim data As String = CopyFrom.ToString()
		  Me.Constructor(New JSONItem(data))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetMessage(Index As Integer) As JSONItem
		  ' Returns the message at Index as a JSONItem.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.ChatCompletionData.GetMessage
		  
		  Return mMessages.Child(Index)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetMessageAttachments(Index As Integer) As Variant()
		  ' Returns the attachment(s) to the message at Index as an array of Variants.
		  ' Attachments may be either URLs to an image file or a Xojo Picture object.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.ChatCompletionData.GetMessageAttachments
		  
		  Dim attachs() As Variant
		  Dim msg As JSONItem = Me.GetMessage(Index)
		  Dim content As Variant = msg.Value("content")
		  If VarType(content) <> Variant.TypeString Then
		    msg = msg.Value("content")
		    For i As Integer = 0 To msg.Count - 1
		      Dim item As JSONItem = msg.Child(i)
		      If item.Lookup("type", "") = "image_url" Then
		        item = item.Value("image_url")
		        Dim url As String = item.Value("url")
		        If NthField(url, ",", 1) = "data:image/png;base64" Then
		          url = Replace(url, "data:image/png;base64,", "")
		          url = DecodeBase64(url)
		          Dim p As Picture = Picture.FromData(url)
		          If p <> Nil Then
		            attachs.Append(p)
		          Else
		            url = item.Value("url")
		            attachs.Append(url)
		          End If
		        Else
		          attachs.Append(url)
		        End If
		      End If
		    Next
		  End If
		  
		  Return attachs
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetMessageRole(Index As Integer) As String
		  ' Returns the speaker of the message at Index.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.ChatCompletionData.GetMessageRole
		  
		  Dim msg As JSONItem = Me.GetMessage(Index)
		  Return msg.Value("role")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetMessageText(Index As Integer) As String
		  ' Returns the message text at Index as a string.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.ChatCompletionData.GetMessageText
		  
		  Dim msg As JSONItem = Me.GetMessage(Index)
		  Dim content As Variant = msg.Value("content")
		  If VarType(content) = Variant.TypeString Then Return msg.Value("content")
		  
		  msg = msg.Value("content")
		  For i As Integer = 0 To msg.Count - 1
		    Dim item As JSONItem = msg.Child(i)
		    If item.Lookup("type", "") = "text" Then Return item.Value("text")
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub InsertMessage(Index As Integer, Role As String, Content As String)
		  ' Inserts a new message into the chat log, pushing existing messages downward.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.ChatCompletionData.InsertMessage
		  
		  Dim msg As New JSONItem()
		  msg.Value("role") = Lowercase(Role)
		  msg.Value("content") = Content
		  mMessages.Insert(Index, msg)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub InsertMessage(Index As Integer, Role As String, Content As String, Images() As Picture)
		  Dim urls() As String
		  For i As Integer = 0 To UBound(Images)
		    urls.Append("data:image/png;base64," + EncodeBase64(Images(i).GetData(Picture.FormatPNG)))
		  Next
		  Me.InsertMessage(Index, Role, Content, urls)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub InsertMessage(Index As Integer, Role As String, Content As String, Image As Picture)
		  Dim url As String = "data:image/png;base64," + EncodeBase64(Image.GetData(Picture.FormatPNG))
		  Me.InsertMessage(Index, Role, Content, url)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub InsertMessage(Index As Integer, Role As String, Content As String, ImageURLs() As String)
		  Dim msg As New JSONItem()
		  msg.Value("role") = Lowercase(Role)
		  
		  Dim contents As New JSONItem
		  Dim msg1 As New JSONItem
		  msg1.Value("type") = "text"
		  msg1.Value("text") = Content
		  contents.Append(msg1)
		  
		  For i As Integer = 0 To UBound(ImageURLs)
		    Dim msg2 As New JSONItem
		    msg2.Value("type") = "image_url"
		    Dim url As New JSONItem
		    url.Value("url") = ImageURLs(i)
		    msg2.Value("image_url") = url
		    contents.Append(msg2)
		  Next
		  
		  msg.Value("content") = contents
		  mMessages.Insert(Index, msg)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub InsertMessage(Index As Integer, Role As String, Content As String, ImageURL As String)
		  Dim msg As New JSONItem()
		  msg.Value("role") = Lowercase(Role)
		  
		  Dim msg1 As New JSONItem
		  msg1.Value("type") = "text"
		  msg1.Value("text") = Content
		  
		  Dim msg2 As New JSONItem
		  msg2.Value("type") = "image_url"
		  Dim url As New JSONItem
		  url.Value("url") = ImageURL
		  msg2.Value("image_url") = url
		  
		  Dim contents As New JSONItem
		  contents.Append(msg1)
		  contents.Append(msg2)
		  
		  msg.Value("content") = contents
		  mMessages.Insert(Index, msg)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Load(ChatLogFile As FolderItem) As OpenAI.ChatCompletionData
		  ' Loads a chat log from a previously saved file.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.ChatCompletionData.Load
		  
		  Dim bs As BinaryStream = BinaryStream.Open(ChatLogFile)
		  Dim cht As String = bs.Read(bs.Length)
		  bs.Close
		  Dim js As New JSONItem(cht)
		  Return New ChatCompletionData(js)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(OtherConversation As OpenAI.ChatCompletionData) As Integer
		  If OtherConversation Is Nil Then Return 1
		  If OtherConversation.mMessages Is mMessages Then Return 0
		  Dim a, b As String
		  a = mMessages.ToString
		  b = OtherConversation.mMessages.ToString
		  If StrComp(a, b, 0) = 0 Then Return 1
		  Return -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Convert() As JSONItem
		  ' Returns a reference to the internal JSONItem.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.ChatCompletionData.Operator_Convert
		  
		  Return mMessages
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveMessage(Index As Integer)
		  ' Removes the specified message from the chat log.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.ChatCompletionData.RemoveMessage
		  
		  mMessages.Remove(Index)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Save(ChatLogFile As FolderItem, Overwrite As Boolean = False)
		  ' Saves the internal JSONItem to the specified file. Saved chat logs can be
		  ' reconstitued using the .Load() shared method.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.ChatCompletionData.Save
		  
		  Dim out As BinaryStream = BinaryStream.Create(ChatLogFile, Overwrite)
		  WriteToStream(out)
		  out.Close
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToString() As String
		  ' Serializes the internal JSONItem.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.ChatCompletionData.ToString
		  
		  Dim dataset As New MemoryBlock(0)
		  Dim out As New BinaryStream(dataset)
		  WriteToStream(out)
		  out.Close
		  
		  Return DefineEncoding(dataset, Encodings.UTF8)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub WriteToStream(Stream As BinaryStream)
		  For i As Integer = 0 To mMessages.Count - 1
		    Dim js As JSONItem = mMessages.Child(i)
		    js.Compact = True
		    Stream.Write(js.ToString + EndOfLine.UNIX)
		  Next
		  
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' Returns the number of messages in the chat log.
			  '
			  ' See:
			  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.ChatCompletionData.MessageCount
			  
			  If mMessages <> Nil Then Return mMessages.Count
			End Get
		#tag EndGetter
		MessageCount As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mMessages As JSONItem
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
			Name="MessageCount"
			Group="Behavior"
			Type="Integer"
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
