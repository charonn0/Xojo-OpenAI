#tag Class
Protected Class File
Inherits OpenAI.Response
	#tag Method, Flags = &h1001
		Protected Sub Constructor(ResponseData As JSONItem, Client As OpenAIClient)
		  // Calling the overridden superclass constructor.
		  // Constructor(ResponseData As JSONItem, Client As OpenAIClient) -- From Response
		  Super.Constructor(ResponseData, Client)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Count(Refresh As Boolean = False) As Integer
		  ' Returns the number of files that belong to the user's organization.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.File.Count
		  
		  If Refresh Or UBound(FileList) = -1 Then ListAllFiles()
		  Return UBound(FileList) + 1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Create(FileContent As FolderItem, Purpose As String, FileName As String = "") As OpenAI.File
		  ' Upload a file that contains document(s) to be used across various endpoints/features.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.File.Create
		  ' https://beta.openai.com/docs/api-reference/files/upload
		  
		  If FileName = "" Then FileName = FileContent.Name
		  Dim bs As BinaryStream = BinaryStream.Open(FileContent)
		  Dim data As String = bs.Read(bs.Length)
		  bs.Close()
		  Return File.Create(data, Purpose, FileName)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Create(FileContent As MemoryBlock, Purpose As String, FileName As String) As OpenAI.File
		  ' Upload a file that contains document(s) to be used across various endpoints/features.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.File.Create
		  ' https://beta.openai.com/docs/api-reference/files/upload
		  
		  Dim request As New OpenAI.Request
		  Dim client As New OpenAIClient
		  request.File = FileContent
		  request.FileName = FileName
		  request.Purpose = Purpose
		  Dim result As New JSONItem(client.SendRequest("/v1/files", request))
		  If result = Nil Or result.HasName("error") Then Raise New OpenAIException(result)
		  ReDim FileList(-1) ' force refresh
		  Return New OpenAI.File(result, client)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Create(FileContent As OpenAI.FineTuneData, FileName As String) As OpenAI.File
		  ' Upload a file that contains JSONL data to be used for fine-tuning.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.File.Create
		  ' https://beta.openai.com/docs/api-reference/files/upload
		  
		  Return File.Create(FileContent.ToString, "fine-tune", FileName)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Delete()
		  ' Deletes the specified file
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.File.Delete
		  
		  Dim result As New JSONItem(mClient.SendRequest("/v1/files/" + Me.ID, "DELETE"))
		  If result.HasName("error") Then Raise New OpenAIException(result)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetCreationDate() As Date
		  Return time_t(mResponse.Value("created_at"))
		  
		Exception err As KeyNotFoundException
		  Return Nil
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetResult(Index As Integer = 0) As Variant
		  ' Returns the contents of the OpenAI.File. The Index parameter is ignored.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.File.GetResult
		  
		  #pragma Unused Index
		  If mResponse.HasName("filename") Then
		    Return mClient.SendRequest("/v1/files/" + ID + "/content")
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function IsValid(Request As OpenAI.Request) As Boolean
		  If Request.BatchSize <> 1 Then Return False
		  If Request.BestOf <> 1 Then Return False
		  If Request.ClassificationBetas <> Nil Then Return False
		  If Request.ClassificationNClasses <> 1 Then Return False
		  If Request.ClassificationPositiveClass <> "" Then Return False
		  If Request.ComputeClassificationMetrics <> False Then Return False
		  If Request.Echo <> False Then Return False
		  If Request.File = Nil Then Return False ' required
		  If Request.FileName = "" Then Return False ' required
		  If Request.FineTuneID <> "" Then Return False
		  If Request.FrequencyPenalty > 0.00001 Then Return False
		  If Request.Input <> "" Then Return False
		  If Request.Instruction <> "" Then Return False
		  If Request.LearningRateMultiplier > 0.00001 Then Return False
		  If Request.LogItBias <> Nil Then Return False
		  If Request.LogProbabilities <> 0 Then Return False
		  If Request.MaskImage <> Nil Then Return False
		  If Request.MaxTokens >= 0 Then Return False
		  If Request.MaxTokens >= 2048 Then Return False
		  If Request.Model <> Nil Then Return False
		  If Request.NumberOfEpochs <> 1 Then Return False
		  If Request.NumberOfResults <> 1 Then Return False
		  If Request.PresencePenalty > 0.00001 Then Return False
		  If Request.Prompt <> "" Then Return False
		  If Request.PromptLossWeight > 0.00001 Then Return False
		  If Request.Purpose = "" Then Return False  ' required
		  If Request.ResultsAsURL = True Then Return False
		  If Request.Size <> "" Then Return False
		  If Request.SourceImage <> Nil Then Return False
		  If Request.Stop <> "" Then Return False
		  If Request.Suffix <> "" Then Return False
		  If Request.Temperature > 0.00001 Then Return False
		  If Request.Top_P > 0.00001 Then Return False
		  If Request.TrainingFile <> "" Then Return False
		  If Request.ValidationFile <> "" Then Return False
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Shared Sub ListAllFiles()
		  ReDim FileList(-1)
		  Dim client As New OpenAIClient
		  Dim result As New JSONItem(client.SendRequest("/v1/files"))
		  If result = Nil Or result.HasName("error") Then Raise New OpenAIException(result)
		  result = result.Value("data")
		  For i As Integer = 0 To result.Count - 1
		    FileList.Append(New OpenAI.File(result.Child(i), client))
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Lookup(Index As Integer, Refresh As Boolean = False) As OpenAI.File
		  ' Returns a File object for the file at Index
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.File.Lookup
		  
		  If Refresh Or UBound(FileList) = -1 Then ListAllFiles()
		  Return FileList(Index)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Lookup(FileID As String, Refresh As Boolean = False) As OpenAI.File
		  ' Returns a File object for the specified file
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.File.Lookup
		  
		  If Refresh Or UBound(FileList) = -1 Then ListAllFiles()
		  For i As Integer = 0 To UBound(FileList)
		    Dim f As File = FileList(i)
		    If f.ID = FileID Then Return f
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ResultType(Index As Integer = 0) As OpenAI.ResultType
		  #pragma Unused Index
		  Return OpenAI.ResultType.String
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' Returns the size in bytes of the specified file
			  '
			  ' See:
			  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.File.Bytes
			  
			  Return mResponse.Value("bytes")
			  
			  Exception err As KeyNotFoundException
			    Return 0
			End Get
		#tag EndGetter
		Bytes As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private Shared FileList() As OpenAI.File
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' Returns the name of the specified file
			  '
			  ' See:
			  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.File.Name
			  
			  Return mResponse.Value("filename")
			  
			  Exception err As KeyNotFoundException
			    Return ""
			End Get
		#tag EndGetter
		Name As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' Returns the purpose string of the specified file
			  '
			  ' See:
			  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.File.Purpose
			  
			  Return mResponse.Value("purpose")
			  
			  Exception err As KeyNotFoundException
			    Return ""
			End Get
		#tag EndGetter
		Purpose As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' Returns the object type of the specified file
			  '
			  ' See:
			  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.File.Type
			  
			  Return mResponse.Value("object")
			  
			  Exception err As KeyNotFoundException
			    Return ""
			End Get
		#tag EndGetter
		Type As String
	#tag EndComputedProperty


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
