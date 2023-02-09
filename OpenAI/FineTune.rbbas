#tag Class
Protected Class FineTune
Inherits OpenAI.Model
	#tag Method, Flags = &h0
		Sub Cancel()
		  Dim result As New JSONItem(mClient.SendRequest("/v1/fine-tunes/" + Me.ID + "/cancel", "POST"))
		  If result.HasName("error") Then Raise New OpenAIException(result)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1001
		Protected Sub Constructor(ResponseData As JSONItem, Client As OpenAIClient)
		  // Calling the overridden superclass constructor.
		  // Constructor(ResponseData As JSONItem) -- From Model
		  Super.Constructor(ResponseData)
		  mClient = Client
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Count(Refresh As Boolean = False) As Integer
		  ' Counts the number of fine tuned models owned by the your organization.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.FineTune.Count
		  
		  If Refresh Or UBound(FineTuneList) = -1 Then ListMyFineTunes()
		  Return UBound(FineTuneList) + 1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Create(TrainingFile As OpenAI.File, BaseModel As OpenAI.Model, Name As String = "") As OpenAI.FineTune
		  If Not BaseModel.AllowFineTuning Then
		    Raise New OpenAIException("The specified AI model ('" + BaseModel.ID + "') cannot be fine-tuned.")
		  End If
		  
		  Dim client As New OpenAIClient
		  Dim request As New OpenAI.Request
		  request.TrainingFile = TrainingFile.ID
		  request.Model = BaseModel
		  If Name <> "" Then request.Suffix = Name
		  If PrevalidateRequests And Not FineTune.IsValid(Request) Then Raise New OpenAIException("The request appears to be invalid.")
		  Dim data As String = client.SendRequest("/v1/fine-tunes", request)
		  Dim result As JSONItem
		  Try
		    result = New JSONItem(data)
		  Catch err As JSONException
		    Raise New OpenAIException(client.LastErrorMessage)
		  End Try
		  If result = Nil Or result.HasName("error") Then Raise New OpenAIException(result)
		  ReDim FineTuneList(-1) ' force refresh
		  Return New OpenAI.FineTune(result, client)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Create(TrainingFileID As String, BaseModel As OpenAI.Model, Name As String = "") As OpenAI.FineTune
		  Dim file As OpenAI.File = OpenAI.File.Lookup(TrainingFileID)
		  If file = Nil Then
		    Raise New OpenAIException("The specified training file ('" + TrainingFileID + "') was not found on the server.")
		  End If
		  Return FineTune.Create(file, BaseModel, Name)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Delete()
		  Dim result As New JSONItem(mclient.SendRequest("/v1/models/" + Me.ID, "DELETE"))
		  If result.HasName("error") Then Raise New OpenAIException(result) Else ReDim FineTuneList(-1)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function IsValid(Request As OpenAI.Request) As Boolean
		  ' If Request.BatchSize <> 1 Then Return False
		  If Request.BestOf <> 1 Then Return False
		  ' If Request.ClassificationBetas <> Nil Then Return False
		  ' If Request.ClassificationNClasses <> 1 Then Return False
		  ' If Request.ClassificationPositiveClass <> "" Then Return False
		  ' If Request.ComputeClassificationMetrics <> False Then Return False
		  If Request.Echo <> False Then Return False
		  If Request.File <> Nil Then Return False
		  If Request.FileName <> "" Then Return False
		  If Request.FineTuneID <> "" Then Return False
		  If Request.FrequencyPenalty > 0.00001 Then Return False
		  If Request.Input <> "" Then Return False
		  If Request.Instruction <> "" Then Return False
		  ' If Request.LearningRateMultiplier > 0.00001 Then Return False
		  If Request.LogItBias <> Nil Then Return False
		  If Request.LogProbabilities <> 0 Then Return False
		  If Request.MaskImage <> Nil Then Return False
		  If Request.MaxTokens >= 0 Then Return False
		  ' If Request.Model = Nil Then Return False
		  ' If Request.NumberOfEpochs <> 1 Then Return False
		  If Request.NumberOfResults > 0 Then Return False
		  If Request.PresencePenalty > 0.00001 Then Return False
		  If Request.Prompt <> "" Then Return False
		  ' If Request.PromptLossWeight > 0.00001 Then Return False
		  If Request.Purpose <> "" Then Return False
		  If Request.ResultsAsURL = True Then Return False
		  If Request.Size <> "" Then Return False
		  If Request.SourceImage <> Nil Then Return False
		  If Request.Stop <> "" Then Return False
		  ' If Request.Suffix <> "" Then Return False
		  If Request.Temperature > 0.00001 Then Return False
		  If Request.Top_P > 0.00001 Then Return False
		  If Request.TrainingFile = "" Then Return False ' required
		  ' If Request.ValidationFile <> "" Then Return False
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ListEvents() As JSONItem
		  Dim result As New JSONItem(mClient.SendRequest("/v1/fine-tunes/" + Me.ID + "/events"))
		  If result.HasName("error") Then Raise New OpenAIException(result)
		  Return result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Sub ListMyFineTunes()
		  ReDim FineTuneList(-1)
		  Dim client As New OpenAIClient
		  Dim lst As JSONItem
		  Dim data As String = client.SendRequest("/v1/fine-tunes")
		  Try
		    lst = New JSONItem(data)
		  Catch err As JSONException
		    Raise New OpenAIException(client.LastErrorMessage)
		  End Try
		  If lst = Nil Or Not lst.HasName("data") Then Raise New OpenAIException(lst)
		  lst = lst.Value("data")
		  
		  For i As Integer = 0 To lst.Count - 1
		    FineTuneList.Append(New OpenAI.FineTune(lst.Child(i)))
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Lookup(Index As Integer, Refresh As Boolean = False) As OpenAI.FineTune
		  If Refresh Or UBound(FineTuneList) = -1 Then ListMyFineTunes()
		  Return FineTuneList(Index)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Lookup(FineTuneID As String, Refresh As Boolean = False) As OpenAI.FineTune
		  If Refresh Or UBound(FineTuneList) = -1 Then ListMyFineTunes()
		  For i As Integer = 0 To UBound(FineTuneList)
		    If FineTuneList(i).ID = FineTuneID Then
		      Return FineTuneList(i)
		    End If
		  Next
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private Shared FineTuneList() As FineTune
	#tag EndProperty


	#tag ViewBehavior
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
