#tag Class
Protected Class FineTuneData
	#tag Method, Flags = &h0
		Sub AddLine(SystemPrompt As String, UserPrompt As String, IdealCompletion As String)
		  Dim messages As New JSONItem
		  Dim sys, user, ideal As JSONItem
		  sys = New JSONItem
		  sys.Value("role") = "system"
		  sys.Value("content") = SystemPrompt
		  messages.Append(sys)
		  
		  user = New JSONItem
		  user.Value("role") = "user"
		  user.Value("content") = UserPrompt
		  messages.Append(user)
		  
		  ideal = New JSONItem
		  ideal.Value("role") = "assistant"
		  ideal.Value("content") = IdealCompletion
		  messages.Append(ideal)
		  
		  Dim line As New JSONItem
		  line.Value("messages") = messages
		  mLines.Append(line)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1001
		Protected Sub Constructor(ExistingFile As FolderItem)
		  Dim tis As TextInputStream = TextInputStream.Open(ExistingFile)
		  Do Until tis.EOF()
		    Dim jsonl As String = tis.ReadLine.Trim
		    If jsonl = "" Then Continue
		    Try
		      mLines.Append(New JSONItem(jsonl))
		    Catch err As JSONException
		      Raise New OpenAIException("Invalid JSON line: '" + jsonl + "'" + EndOfLine + err.Message)
		    End Try
		  Loop
		  tis.Close()
		  mFilename = ExistingFile.Name
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1001
		Protected Sub Constructor(ExistingFile As OpenAI.File)
		  Dim data As String = ExistingFile.GetResult()
		  Dim lines() As String = SplitB(data, EndOfLine.UNIX)
		  For i As Integer = 0 To UBound(lines)
		    Dim jsonl As String = lines(i).Trim
		    If jsonl = "" Then Continue
		    Try
		      mLines.Append(New JSONItem(jsonl))
		    Catch err As JSONException
		      Raise New OpenAIException("Invalid JSON line: '" + jsonl + "'" + EndOfLine + err.Message)
		    End Try
		  Next
		  mFilename = ExistingFile.Name
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Create(TrainingFile As FolderItem, Overwrite As Boolean = False) As OpenAI.FineTuneData
		  Dim bs As BinaryStream = BinaryStream.Create(TrainingFile, Overwrite)
		  bs.Close
		  Return New FineTuneData(TrainingFile)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetLine(Index As Integer) As JSONItem
		  Return mLines(Index)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Load(TrainingFile As FolderItem) As OpenAI.FineTuneData
		  Return New FineTuneData(TrainingFile)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Load(TrainingFile As OpenAI.File) As OpenAI.FineTuneData
		  Return New FineTuneData(TrainingFile)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveLine(Index As Integer)
		  mLines.Remove(Index)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Save(TrainingFile As FolderItem, Overwrite As Boolean = False)
		  Dim out As BinaryStream = BinaryStream.Create(TrainingFile, Overwrite)
		  WriteToStream(out)
		  out.Close
		  mFilename = TrainingFile.Name
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToString() As String
		  Dim dataset As New MemoryBlock(0)
		  Dim out As New BinaryStream(dataset)
		  WriteToStream(out)
		  out.Close
		  
		  Return DefineEncoding(dataset, Encodings.UTF8)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub WriteToStream(Stream As BinaryStream)
		  For i As Integer = 0 To UBound(mLines)
		    Dim js As JSONItem = mLines(i)
		    js.Compact = True
		    Stream.Write(js.ToString + EndOfLine.UNIX)
		  Next
		  
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mFilename
			End Get
		#tag EndGetter
		Filename As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return UBound(mLines) + 1
			End Get
		#tag EndGetter
		LineCount As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mFilename As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLines() As JSONItem
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
			Name="LineCount"
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
