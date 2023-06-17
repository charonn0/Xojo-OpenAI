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
		Sub Save(ChatLogFile As FolderItem)
		  ' Saves the internal JSONItem to the specified file.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.ChatCompletionData.Save
		  
		  Dim out As BinaryStream = BinaryStream.Create(ChatLogFile)
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
