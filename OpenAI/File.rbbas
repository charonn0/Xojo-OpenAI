#tag Class
Protected Class File
Inherits OpenAI.Response
	#tag Method, Flags = &h0
		Sub Constructor(ResponseData As JSONItem)
		  // Calling the overridden superclass constructor.
		  // Constructor(ResponseData As JSONItem, Client As OpenAIClient, OriginalRequest As OpenAI.Request) -- From Response
		  Super.Constructor(ResponseData, New OpenAIClient, Nil)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1001
		Protected Sub Constructor(ResponseData As JSONItem, Client As OpenAIClient, OriginalRequest As OpenAI.Request)
		  // Calling the overridden superclass constructor.
		  // Constructor(ResponseData As JSONItem, Client As OpenAIClient, OriginalRequest As OpenAI.Request) -- From Response
		  Super.Constructor(ResponseData, Client, OriginalRequest)
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
		  ' https://platform.openai.com/docs/api-reference/files/create
		  
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
		  ' https://platform.openai.com/docs/api-reference/files/create
		  
		  Dim request As New OpenAI.Request
		  Dim client As New OpenAIClient
		  request.File = FileContent
		  request.FileName = FileName
		  request.FileMIMEType = "application/x-jsonlines"
		  request.Purpose = Purpose
		  If File.Prevalidate Then
		    Dim err As ValidationError = File.IsValid(Request)
		    If err <> ValidationError.None Then Raise New OpenAIException(err)
		  End If
		  Dim result As JSONItem = Response.CreateRaw(client, "/v1/files", request)
		  If result = Nil Or result.HasName("error") Then Raise New OpenAIException(result)
		  ReDim FileList(-1) ' force refresh
		  Return New OpenAI.File(result, client, request)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Delete()
		  ' Deletes the specified file
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.File.Delete
		  
		  Dim data As String = mClient.SendRequest("/v1/files/" + Me.ID, "DELETE")
		  Dim response As JSONItem
		  Try
		    response = New JSONItem(data)
		  Catch err As JSONException
		    Raise New OpenAIException(mClient)
		  End Try
		  If response = Nil Or response.HasName("error") Then Raise New OpenAIException(response) Else ReDim FileList(-1)
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
		    Dim data As String = mClient.SendRequest("/v1/files/" + ID + "/content")
		    If mClient.LastStatusCode <> 200 Then
		      Dim err As JSONItem
		      Try
		        err = New JSONItem(data)
		      Catch error As JSONException
		      End Try
		      If err <> Nil Then
		        Raise New OpenAIException(err)
		      Else
		        Raise New OpenAIException(mClient)
		      End If
		    End If
		    Return DefineEncoding(data, Encodings.UTF8)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetResultType() As OpenAI.ResultType
		  Return OpenAI.ResultType.String
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function IsValid(Request As OpenAI.Request) As OpenAI.ValidationError
		  If Request.BatchSize <> 1 Then Return ValidationError.BatchSize
		  If Request.BestOf <> 1 Then Return ValidationError.BestOf
		  If Request.ClassificationBetas <> Nil Then Return ValidationError.ClassificationBetas
		  If Request.ClassificationNClasses <> 1 Then Return ValidationError.ClassificationNClasses
		  If Request.ClassificationPositiveClass <> "" Then Return ValidationError.ClassificationPositiveClass
		  If Request.ComputeClassificationMetrics <> False Then Return ValidationError.ComputeClassificationMetrics
		  If Request.Echo <> False Then Return ValidationError.Echo
		  If Request.File = Nil Then Return ValidationError.File ' required
		  If Request.File.Size > 1024 * 1024 * 25 Then Return ValidationError.File ' 25MB file size limit.
		  If Request.FileName = "" Then Return ValidationError.FileName ' required
		  If Request.FileMIMEType = "" Then Return ValidationError.FileMIMEType ' required
		  If Request.FineTuneID <> "" Then Return ValidationError.FineTuneID
		  If Request.FrequencyPenalty > 0.00001 Then Return ValidationError.FrequencyPenalty
		  If Request.IsSet("quality") Then Return ValidationError.HighQuality
		  If Request.Input <> "" Then Return ValidationError.Input
		  If Request.Instruction <> "" Then Return ValidationError.Instruction
		  If Request.Language <> "" Then Return ValidationError.Language
		  If Request.LearningRateMultiplier > 0.00001 Then Return ValidationError.LearningRateMultiplier
		  If Request.LogItBias <> Nil Then Return ValidationError.LogItBias
		  If Request.IsSet("logprobs") Then Return ValidationError.LogProbabilities
		  If Request.MaskImage <> Nil Then Return ValidationError.MaskImage
		  If Request.MaxTokens > 4096 Then Return ValidationError.MaxTokens
		  If Request.Model <> Nil Then Return ValidationError.Model
		  If Request.NumberOfEpochs > 1 Then Return ValidationError.NumberOfEpochs
		  If Request.NumberOfResults > 1 Then Return ValidationError.NumberOfResults
		  If Request.PresencePenalty > 0.00001 Then Return ValidationError.PresencePenalty
		  If Request.Prompt <> "" Then Return ValidationError.Prompt
		  If Request.PromptLossWeight > 0.00001 Then Return ValidationError.PromptLossWeight
		  If Request.Purpose = "" Then Return ValidationError.Purpose ' required
		  If Request.ResultsAsBase64 = True Then Return ValidationError.ResultsAsType
		  If Request.ResultsAsJSON = True Then Return ValidationError.ResultsAsType
		  If Request.ResultsAsJSON_Verbose = True Then Return ValidationError.ResultsAsType
		  If Request.ResultsAsSRT = True Then Return ValidationError.ResultsAsType
		  If Request.ResultsAsText = True Then Return ValidationError.ResultsAsType
		  If Request.ResultsAsURL = True Then Return ValidationError.ResultsAsURL
		  If Request.ResultsAsVTT = True Then Return ValidationError.ResultsAsType
		  If Request.ResultsAsMP3 = True Then Return ValidationError.ResultsAsType
		  If Request.ResultsAsOpus = True Then Return ValidationError.ResultsAsType
		  If Request.ResultsAsAAC = True Then Return ValidationError.ResultsAsType
		  If Request.ResultsAsFLAC = True Then Return ValidationError.ResultsAsType
		  If Request.Size <> "" Then Return ValidationError.Size
		  If Request.IsSet("speed") Then Return ValidationError.Speed
		  If Request.SourceImage <> Nil Then Return ValidationError.SourceImage
		  If Request.Stop <> "" Then Return ValidationError.Stop
		  If Request.IsSet("style") Then Return ValidationError.Style
		  If Request.Suffix <> "" Then Return ValidationError.Suffix
		  If Request.Temperature > 0.00001 Then Return ValidationError.Temperature
		  If Request.Top_P > 0.00001 Then Return ValidationError.Top_P
		  If Request.TrainingFile <> "" Then Return ValidationError.TrainingFile
		  If Request.ValidationFile <> "" Then Return ValidationError.ValidationFile
		  If Request.Voice <> "" Then Return ValidationError.Voice
		  Return ValidationError.None
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Shared Sub ListAllFiles()
		  ReDim FileList(-1)
		  Dim client As New OpenAIClient
		  Dim result As JSONItem = Response.CreateRaw(client, "/v1/files")
		  If result = Nil Or result.HasName("error") Then Raise New OpenAIException(result)
		  result = result.Value("data")
		  For i As Integer = 0 To result.Count - 1
		    FileList.Append(New OpenAI.File(result.Child(i), client, Nil))
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
		#tag Note
			When enabled, requests will be checked for basic sanity (using the IsValid() shared method) before
			being sent over the wire. This check is not fool-proof. Please report any requests that give false
			positives/negatives
		#tag EndNote
		#tag Getter
			Get
			  Return ValidationOpt And Response.Prevalidate
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ValidationOpt = value
			End Set
		#tag EndSetter
		Shared Prevalidate As Boolean
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

	#tag Property, Flags = &h21
		Private Shared ValidationOpt As Boolean = True
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
