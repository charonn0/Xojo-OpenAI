#tag Class
Protected Class FineTuneJob
	#tag Method, Flags = &h0
		Sub Cancel()
		  ' Cancels the fine-tune job if it has not yet completed.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.FineTuneJob.Cancel
		  
		  Do Until mLock.TryEnter()
		    #If RBVersion < 2020 Then
		      App.YieldToNextThread()
		    #Else
		      Thread.YieldToNext()
		    #EndIf
		  Loop
		  
		  Select Case Me.Status
		  Case JobStatus.Canceled, JobStatus.Failed, JobStatus.Succeeded
		    Return ' nothing to do
		  End Select
		  
		  Try
		    Dim data As String = mClient.SendRequest("/v1/fine_tuning/jobs/" + Me.ID + "/cancel", "POST")
		    Dim result As JSONItem
		    Try
		      result = New JSONItem(data)
		      mJob = result
		    Catch err As JSONException
		      Raise New OpenAIException(mClient)
		    End Try
		    If result.HasName("error") Then Raise New OpenAIException(result)
		  Finally
		    mLock.Leave()
		  End Try
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1001
		Protected Sub Constructor(ResponseData As JSONItem, Client As OpenAIClient)
		  mLock = New CriticalSection()
		  mJob = ResponseData
		  mClient = Client
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Count(Refresh As Boolean = False) As Integer
		  ' Counts the number of fine tuned models owned by the your organization.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.FineTuneJob.Count
		  
		  If Refresh Or UBound(FineTuneList) = -1 Then ListMyFineTunes()
		  Return UBound(FineTuneList) + 1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Create(TrainingFile As OpenAI.File, BaseModel As OpenAI.Model, Name As String = "") As OpenAI.FineTuneJob
		  ' If Not BaseModel.AllowFineTuning Then
		  ' Raise New OpenAIException("The specified AI model ('" + BaseModel.ID + "') cannot be fine-tuned.")
		  ' End If
		  
		  Dim client As New OpenAIClient
		  Dim request As New OpenAI.Request
		  request.TrainingFile = TrainingFile.ID
		  request.Model = BaseModel
		  If Name <> "" Then request.Suffix = Name
		  If FineTuneJob.Prevalidate Then
		    Dim err As ValidationError = FineTuneJob.IsValid(Request)
		    If err <> ValidationError.None Then Raise New OpenAIException(err)
		  End If
		  Dim data As String = client.SendRequest("/v1/fine_tuning/jobs", request)
		  Dim result As JSONItem
		  Try
		    result = New JSONItem(data)
		  Catch err As JSONException
		    Raise New OpenAIException(client)
		  End Try
		  If result = Nil Then Raise New OpenAIException(data)
		  ReDim FineTuneList(-1) ' force refresh
		  Return New OpenAI.FineTuneJob(result, client)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Create(TrainingFile As OpenAI.FineTuneData, BaseModel As OpenAI.Model, Name As String = "") As OpenAI.FineTuneJob
		  Dim data As String = TrainingFile.ToString()
		  Dim file As OpenAI.File = OpenAI.File.Create(data, "fine-tune", TrainingFile.Filename)
		  Return FineTuneJob.Create(file, BaseModel, Name)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Create(TrainingFileID As String, BaseModel As OpenAI.Model, Name As String = "") As OpenAI.FineTuneJob
		  Dim file As OpenAI.File = OpenAI.File.Lookup(TrainingFileID)
		  If file = Nil Then
		    Raise New OpenAIException("The specified training file ('" + TrainingFileID + "') was not found on the server.")
		  End If
		  Return FineTuneJob.Create(file, BaseModel, Name)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetResultFile(Index As Integer) As OpenAI.File
		  ' Returns an instance of OpenAI.File representing one of the files created during the fine tune job.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.FineTuneJob.GetResultFile
		  
		  Do Until mLock.TryEnter()
		    #If RBVersion < 2020 Then
		      App.YieldToNextThread()
		    #Else
		      Thread.YieldToNext()
		    #EndIf
		  Loop
		  
		  Try
		    If mJob.HasName("result_files") Then
		      Dim results As JSONItem = mJob.Value("result_files")
		      Dim id As String = results.Value(Index)
		      Return OpenAI.File.Lookup(id)
		    End If
		  Finally
		    mLock.Leave()
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function IsValid(Request As OpenAI.Request) As OpenAI.ValidationError
		  ' If Request.BatchSize <> 1 Then Return ValidationError.BatchSize
		  If Request.BestOf <> 1 Then Return ValidationError.BestOf
		  ' If Request.ClassificationBetas <> Nil Then Return ValidationError.ClassificationBetas
		  ' If Request.ClassificationNClasses <> 1 Then Return ValidationError.ClassificationNClasses
		  ' If Request.ClassificationPositiveClass <> "" Then Return ValidationError.ClassificationPositiveClass
		  ' If Request.ComputeClassificationMetrics <> False Then Return ValidationError.ComputeClassificationMetrics
		  If Request.Echo <> False Then Return ValidationError.Echo
		  If Request.File <> Nil Then Return ValidationError.File
		  If Request.FileName <> "" Then Return ValidationError.FileName
		  If Request.FineTuneID <> "" Then Return ValidationError.FineTuneID
		  If Request.FrequencyPenalty > 0.00001 Then Return ValidationError.FrequencyPenalty
		  If Request.IsSet("quality") Then Return ValidationError.HighQuality
		  If Request.Input <> "" Then Return ValidationError.Input
		  If Request.Instruction <> "" Then Return ValidationError.Instruction
		  If Request.Language <> "" Then Return ValidationError.Language
		  ' If Request.LearningRateMultiplier > 0.00001 Then Return ValidationError.LearningRateMultiplier
		  If Request.LogItBias <> Nil Then Return ValidationError.LogItBias
		  If Request.IsSet("logprobs") Then Return ValidationError.LogProbabilities
		  If Request.MaskImage <> Nil Then Return ValidationError.MaskImage
		  If Request.MaxTokens > 0 Then Return ValidationError.MaxTokens
		  ' If Request.Model = Nil Then Return ValidationError.Model
		  ' If Request.NumberOfEpochs <> 1 Then Return ValidationError.NumberOfEpochs
		  If Request.NumberOfResults > 1 Then Return ValidationError.NumberOfResults
		  If Request.PresencePenalty > 0.00001 Then Return ValidationError.PresencePenalty
		  If Request.Prompt <> "" Then Return ValidationError.Prompt
		  ' If Request.PromptLossWeight > 0.00001 Then Return ValidationError.PromptLossWeight
		  If Request.Purpose <> "" Then Return ValidationError.Purpose
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
		  ' If Request.Suffix <> "" Then Return ValidationError.Suffix
		  If Request.Temperature > 0.00001 Then Return ValidationError.Temperature
		  If Request.Top_P > 0.00001 Then Return ValidationError.Top_P
		  If Request.TrainingFile = "" Then Return ValidationError.TrainingFile ' required
		  ' If Request.ValidationFile <> "" Then Return ValidationError.ValidationFile
		  If Request.Voice <> "" Then Return ValidationError.Voice
		  Return ValidationError.None
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ListEvents() As JSONItem()
		  ' Returns a JSONItem containing a list of events from a running fine-tune job.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.FineTuneJob.ListEvents
		  
		  Do Until mLock.TryEnter()
		    #If RBVersion < 2020 Then
		      App.YieldToNextThread()
		    #Else
		      Thread.YieldToNext()
		    #EndIf
		  Loop
		  
		  Dim events() As JSONItem
		  Try
		    Dim hasmore As Boolean
		    Do
		      Dim lst As JSONItem
		      Dim endpoint As String = "/v1/fine_tuning/jobs/" + Me.ID + "/events"
		      If UBound(events) > -1 Then endpoint = endpoint + "?after=" + events(UBound(events)).Value("id")
		      Dim data As String = mClient.SendRequest(endpoint)
		      Try
		        lst = New JSONItem(data)
		      Catch err As JSONException
		        Raise New OpenAIException(mClient)
		      End Try
		      If lst = Nil Or Not lst.HasName("data") Then Raise New OpenAIException(lst)
		      hasmore = lst.Lookup("has_more", False)
		      lst = lst.Value("data")
		      
		      For i As Integer = 0 To lst.Count - 1
		        events.Append(lst.Child(i))
		      Next
		    Loop Until Not hasmore
		  Finally
		    mLock.Leave()
		  End Try
		  Return events
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Sub ListMyFineTunes()
		  ReDim FineTuneList(-1)
		  Dim client As New OpenAIClient
		  Dim hasmore As Boolean
		  Do
		    Dim lst As JSONItem
		    Dim endpoint As String = "/v1/fine_tuning/jobs?limit=50"
		    If UBound(FineTuneList) > -1 Then endpoint = endpoint + "&after=" + FineTuneList(UBound(FineTuneList)).ID
		    Dim data As String = client.SendRequest(endpoint)
		    Try
		      lst = New JSONItem(data)
		    Catch err As JSONException
		      Raise New OpenAIException(client)
		    End Try
		    If lst = Nil Or Not lst.HasName("data") Then Raise New OpenAIException(lst)
		    hasmore = lst.Lookup("has_more", False)
		    lst = lst.Value("data")
		    
		    For i As Integer = 0 To lst.Count - 1
		      FineTuneList.Append(New OpenAI.FineTuneJob(lst.Child(i), New OpenAIClient))
		    Next
		  Loop Until Not hasmore
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Lookup(Index As Integer, Refresh As Boolean = False) As OpenAI.FineTuneJob
		  If Refresh Or UBound(FineTuneList) = -1 Then ListMyFineTunes()
		  Return FineTuneList(Index)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Lookup(FineTuneID As String, Refresh As Boolean = False) As OpenAI.FineTuneJob
		  If Refresh Or UBound(FineTuneList) = -1 Then ListMyFineTunes()
		  For i As Integer = 0 To UBound(FineTuneList)
		    If FineTuneList(i).ID = FineTuneID Then
		      Return FineTuneList(i)
		    End If
		  Next
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Refresh()
		  ' Refreshes the job state and other metadata.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.FineTuneJob.Refresh
		  
		  Do Until mLock.TryEnter()
		    #If RBVersion < 2020 Then
		      App.YieldToNextThread()
		    #Else
		      Thread.YieldToNext()
		    #EndIf
		  Loop
		  
		  Try
		    Dim data As String = mClient.SendRequest("/v1/fine_tuning/jobs/" + Me.ID)
		    Dim result As JSONItem
		    Try
		      result = New JSONItem(data)
		    Catch err As JSONException
		      Raise New OpenAIException(mClient)
		    End Try
		    If result.Lookup("object", "") <> "fine_tuning.job" Then Raise New OpenAIException("Weird JSON reply!" + EndOfLine + data)
		    If result.Lookup("error", Nil) <> Nil Then
		      result = result.Value("error")
		      Raise New OpenAIException(result)
		    End If
		    mJob = result
		  Finally
		    mLock.Leave()
		  End Try
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Do Until mLock.TryEnter()
			    #If RBVersion < 2020 Then
			      App.YieldToNextThread()
			    #Else
			      Thread.YieldToNext()
			    #EndIf
			  Loop
			  
			  Dim results As Integer
			  Try
			    results = mJob.Lookup("created_at", 0)
			  Finally
			    mLock.Leave()
			  End Try
			  If results > 0 Then Return time_t(results)
			End Get
		#tag EndGetter
		Created As Date
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Do Until mLock.TryEnter()
			    #If RBVersion < 2020 Then
			      App.YieldToNextThread()
			    #Else
			      Thread.YieldToNext()
			    #EndIf
			  Loop
			  
			  Dim results As Integer
			  Try
			    Dim data As JSONItem = mJob.Lookup("error", Nil)
			    If data <> Nil Then results = data.Lookup("code", 0)
			  Finally
			    mLock.Leave()
			  End Try
			  Return results
			End Get
		#tag EndGetter
		ErrorCode As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Do Until mLock.TryEnter()
			    #If RBVersion < 2020 Then
			      App.YieldToNextThread()
			    #Else
			      Thread.YieldToNext()
			    #EndIf
			  Loop
			  
			  Dim results As String
			  Try
			    Dim data As JSONItem = mJob.Lookup("error", Nil)
			    If data <> Nil Then results = data.Lookup("message", "")
			  Finally
			    mLock.Leave()
			  End Try
			  Return results
			End Get
		#tag EndGetter
		ErrorMessage As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Do Until mLock.TryEnter()
			    #If RBVersion < 2020 Then
			      App.YieldToNextThread()
			    #Else
			      Thread.YieldToNext()
			    #EndIf
			  Loop
			  
			  Dim results As String
			  Try
			    Dim data As JSONItem = mJob.Lookup("error", Nil)
			    If data <> Nil Then results = data.Lookup("param", "")
			  Finally
			    mLock.Leave()
			  End Try
			  Return results
			End Get
		#tag EndGetter
		ErrorParam As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Do Until mLock.TryEnter()
			    #If RBVersion < 2020 Then
			      App.YieldToNextThread()
			    #Else
			      Thread.YieldToNext()
			    #EndIf
			  Loop
			  
			  Dim m As OpenAI.Model
			  Try
			    If mJob.HasName("fine_tuned_model") Then
			      Dim results As String = mJob.Value("fine_tuned_model")
			      m = OpenAI.Model.Lookup(results)
			    End If
			  Finally
			    mLock.Leave()
			  End Try
			  Return m
			End Get
		#tag EndGetter
		FineTunedModel As OpenAI.Model
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private Shared FineTuneList() As FineTuneJob
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Do Until mLock.TryEnter()
			    #If RBVersion < 2020 Then
			      App.YieldToNextThread()
			    #Else
			      Thread.YieldToNext()
			    #EndIf
			  Loop
			  
			  Dim results As Integer
			  Try
			    results = mJob.Lookup("finished_at", 0)
			  Finally
			    mLock.Leave()
			  End Try
			  If results > 0 Then Return time_t(results)
			End Get
		#tag EndGetter
		Finished As Date
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Do Until mLock.TryEnter()
			    #If RBVersion < 2020 Then
			      App.YieldToNextThread()
			    #Else
			      Thread.YieldToNext()
			    #EndIf
			  Loop
			  
			  Dim params As New Dictionary
			  Try
			    Dim results As JSONItem = mJob.Lookup("hyperparameters", Nil)
			    For i As Integer = 0 To results.Count - 1
			      Dim nm As String = results.Name(i)
			      Dim vl As Variant = results.Value(nm)
			      params.Value(nm) = vl
			    Next
			  Finally
			    mLock.Leave()
			  End Try
			  Return params
			End Get
		#tag EndGetter
		Hyperparameters As Dictionary
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Do Until mLock.TryEnter()
			    #If RBVersion < 2020 Then
			      App.YieldToNextThread()
			    #Else
			      Thread.YieldToNext()
			    #EndIf
			  Loop
			  
			  Dim results As String
			  Try
			    results = mJob.Lookup("id", "")
			  Finally
			    mLock.Leave()
			  End Try
			  Return results
			End Get
		#tag EndGetter
		ID As String
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mClient As OpenAIClient
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mJob As JSONItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLock As CriticalSection
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Do Until mLock.TryEnter()
			    #If RBVersion < 2020 Then
			      App.YieldToNextThread()
			    #Else
			      Thread.YieldToNext()
			    #EndIf
			  Loop
			  
			  Dim results As String
			  Try
			    results = mJob.Lookup("organization_id", "")
			  Finally
			    mLock.Leave()
			  End Try
			  Return results
			End Get
		#tag EndGetter
		Organization As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return ValidationOpt
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
			  Do Until mLock.TryEnter()
			    #If RBVersion < 2020 Then
			      App.YieldToNextThread()
			    #Else
			      Thread.YieldToNext()
			    #EndIf
			  Loop
			  
			  Dim count As Integer
			  Try
			    If mJob.HasName("result_files") Then
			      Dim results As JSONItem = mJob.Value("result_files")
			      count = results.Count
			    End If
			  Finally
			    mLock.Leave()
			  End Try
			  Return count
			End Get
		#tag EndGetter
		ResultFileCount As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Do Until mLock.TryEnter()
			    #If RBVersion < 2020 Then
			      App.YieldToNextThread()
			    #Else
			      Thread.YieldToNext()
			    #EndIf
			  Loop
			  
			  Dim stat As JobStatus
			  Try
			    Select Case mJob.Lookup("status", "pending")
			    Case "validating_files"
			      stat = JobStatus.ValidatingFiles
			    Case "queued"
			      stat = JobStatus.Queued
			    Case "running"
			      stat = JobStatus.Running
			    Case "succeeded"
			      stat = JobStatus.Succeeded
			    Case "failed"
			      stat = JobStatus.Failed
			    Case "cancelled"
			      stat = JobStatus.Canceled
			    Else
			      stat = JobStatus.Pending
			    End Select
			  Finally
			    mLock.Leave()
			  End Try
			  Return stat
			End Get
		#tag EndGetter
		Status As OpenAI.JobStatus
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Do Until mLock.TryEnter()
			    #If RBVersion < 2020 Then
			      App.YieldToNextThread()
			    #Else
			      Thread.YieldToNext()
			    #EndIf
			  Loop
			  
			  Dim count As Integer
			  Try
			    If mJob.HasName("trained_tokens") Then
			      Dim results As Variant = mJob.Value("trained_tokens")
			      If results <> Nil Then count = results.IntegerValue
			    End If
			  Finally
			    mLock.Leave()
			  End Try
			  Return count
			End Get
		#tag EndGetter
		TokenCount As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Do Until mLock.TryEnter()
			    #If RBVersion < 2020 Then
			      App.YieldToNextThread()
			    #Else
			      Thread.YieldToNext()
			    #EndIf
			  Loop
			  
			  Dim f As OpenAI.File
			  Try
			    If mJob.HasName("training_file") Then
			      Dim results As String = mJob.Value("training_file")
			      f = OpenAI.File.Lookup(results)
			    End If
			  Finally
			    mLock.Leave()
			  End Try
			  Return f
			End Get
		#tag EndGetter
		TrainingFile As OpenAI.File
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Do Until mLock.TryEnter()
			    #If RBVersion < 2020 Then
			      App.YieldToNextThread()
			    #Else
			      Thread.YieldToNext()
			    #EndIf
			  Loop
			  
			  Dim f As OpenAI.File
			  Try
			    If mJob.HasName("validation_file") Then
			      Dim results As String = mJob.Value("validation_file")
			      f = OpenAI.File.Lookup(results)
			    End If
			  Finally
			    mLock.Leave()
			  End Try
			  Return f
			End Get
		#tag EndGetter
		ValidationFile As OpenAI.File
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private Shared ValidationOpt As Boolean = True
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
			Name="Endpoint"
			Group="Behavior"
			Type="String"
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
			Name="Replacement"
			Group="Behavior"
			Type="String"
			InheritedFrom="OpenAI.Model"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ResultCount"
			Group="Behavior"
			Type="Integer"
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
