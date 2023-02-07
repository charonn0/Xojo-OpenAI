#tag Class
Protected Class FineTuneData
	#tag Method, Flags = &h0
		Sub AddLine(Prompt As String, Completion As String)
		  Dim js As New JSONItem
		  js.Value("prompt") = Prompt
		  js.Value("completion") = Completion
		  js.Compact = True
		  mLines.Append(js)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1000
		Sub Constructor(Optional TrainingData As Dictionary)
		  ' Create a new training set, optionally converting a Dictionary that contains training data to JSONL format.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.FineTuneData.Constructor
		  
		  If TrainingData <> Nil Then
		    For Each key As String In TrainingData.Keys
		      Dim js As New JSONItem()
		      js.Value("prompt") = key
		      js.Value("completion") = TrainingData.Value(key)
		      mLines.Append(js)
		    Next
		  End If
		  
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
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FindLine(Prompt As String, Completion As String, StartWith As Integer = 0) As Integer
		  For i As Integer = StartWith To UBound(mLines)
		    Dim js As JSONItem = mLines(i)
		    If Prompt <> "" And Instr(js.Value("prompt"), Prompt) > 0 Then Return i
		    If Completion <> "" And Instr(js.Value("completion"), Completion) > 0 Then Return i
		  Next
		  Return -1
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
		Sub Save(TrainingFile As FolderItem)
		  Dim out As BinaryStream = BinaryStream.Create(TrainingFile)
		  WriteToStream(out)
		  out.Close
		  
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
			  Return UBound(mLines) + 1
			End Get
		#tag EndGetter
		LineCount As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mLines() As JSONItem
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="AllowCreate"
			Group="Behavior"
			Type="Boolean"
			InheritedFrom="OpenAI.Model"
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowFineTuning"
			Group="Behavior"
			Type="Boolean"
			InheritedFrom="OpenAI.Model"
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowLogProbs"
			Group="Behavior"
			Type="Boolean"
			InheritedFrom="OpenAI.Model"
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowSampling"
			Group="Behavior"
			Type="Boolean"
			InheritedFrom="OpenAI.Model"
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowSearchIndices"
			Group="Behavior"
			Type="Boolean"
			InheritedFrom="OpenAI.Model"
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowView"
			Group="Behavior"
			Type="Boolean"
			InheritedFrom="OpenAI.Model"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Group"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
			InheritedFrom="OpenAI.Model"
		#tag EndViewProperty
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
			Name="IsBlocking"
			Group="Behavior"
			Type="Boolean"
			InheritedFrom="OpenAI.Model"
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
			Name="Organization"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
			InheritedFrom="OpenAI.Model"
		#tag EndViewProperty
		#tag ViewProperty
			Name="OwnedBy"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
			InheritedFrom="OpenAI.Model"
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
