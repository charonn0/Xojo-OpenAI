#tag Class
Protected Class FineTune
Inherits OpenAI.Model
	#tag Method, Flags = &h0
		Sub Cancel()
		  Do Until mLock.TryEnter()
		    #If RBVersion < 2020 Then
		      App.YieldToNextThread()
		    #Else
		      Thread.YieldToNext()
		    #EndIf
		  Loop
		  
		  Try
		    Dim data As String = mClient.SendRequest("/v1/fine-tunes/" + Me.ID + "/cancel", "POST")
		    Dim result As JSONItem
		    Try
		      result = New JSONItem(data)
		      mModel = result
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
		  If FineTune.Prevalidate Then
		    Dim err As ValidationError = FineTune.IsValid(Request)
		    If err <> ValidationError.None Then Raise New OpenAIException(err)
		  End If
		  Dim data As String = client.SendRequest("/v1/fine-tunes", request)
		  Dim result As JSONItem
		  Try
		    result = New JSONItem(data)
		  Catch err As JSONException
		    Raise New OpenAIException(client)
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
		  Do Until mLock.TryEnter()
		    #If RBVersion < 2020 Then
		      App.YieldToNextThread()
		    #Else
		      Thread.YieldToNext()
		    #EndIf
		  Loop
		  
		  Try
		    Dim data As String = mclient.SendRequest("/v1/models/" + Me.ID, "DELETE")
		    Dim result As JSONItem
		    Try
		      result = New JSONItem(data)
		      mModel = result
		    Catch err As JSONException
		      Raise New OpenAIException(mClient)
		    End Try
		    If result.HasName("error") Then Raise New OpenAIException(result) Else ReDim FineTuneList(-1)
		  Finally
		    mLock.Leave()
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetResult(Index As Integer) As OpenAI.File
		  Do Until mLock.TryEnter()
		    #If RBVersion < 2020 Then
		      App.YieldToNextThread()
		    #Else
		      Thread.YieldToNext()
		    #EndIf
		  Loop
		  
		  Try
		    If mModel.HasName("result_files") Then
		      Dim results As JSONItem = mModel.Value("result_files")
		      results = results.Child(Index)
		      Return OpenAI.File.Lookup(results.Value("id").StringValue)
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
		  If Request.Input <> "" Then Return ValidationError.Input
		  If Request.Instruction <> "" Then Return ValidationError.Instruction
		  ' If Request.LearningRateMultiplier > 0.00001 Then Return ValidationError.LearningRateMultiplier
		  If Request.LogItBias <> Nil Then Return ValidationError.LogItBias
		  If Request.LogProbabilities <> 0 Then Return ValidationError.LogProbabilities
		  If Request.MaskImage <> Nil Then Return ValidationError.MaskImage
		  If Request.MaxTokens > 0 Then Return ValidationError.MaxTokens
		  ' If Request.Model = Nil Then Return ValidationError.Model
		  ' If Request.NumberOfEpochs <> 1 Then Return ValidationError.NumberOfEpochs
		  If Request.NumberOfResults > 1 Then Return ValidationError.NumberOfResults
		  If Request.PresencePenalty > 0.00001 Then Return ValidationError.PresencePenalty
		  If Request.Prompt <> "" Then Return ValidationError.Prompt
		  ' If Request.PromptLossWeight > 0.00001 Then Return ValidationError.PromptLossWeight
		  If Request.Purpose <> "" Then Return ValidationError.Purpose
		  If Request.ResultsAsURL = True Then Return ValidationError.ResultsAsURL
		  If Request.Size <> "" Then Return ValidationError.Size
		  If Request.SourceImage <> Nil Then Return ValidationError.SourceImage
		  If Request.Stop <> "" Then Return ValidationError.Stop
		  ' If Request.Suffix <> "" Then Return ValidationError.Suffix
		  If Request.Temperature > 0.00001 Then Return ValidationError.Temperature
		  If Request.Top_P > 0.00001 Then Return ValidationError.Top_P
		  If Request.TrainingFile = "" Then Return ValidationError.TrainingFile ' required
		  ' If Request.ValidationFile <> "" Then Return ValidationError.ValidationFile
		  Return ValidationError.None
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ListEvents() As JSONItem
		  Do Until mLock.TryEnter()
		    #If RBVersion < 2020 Then
		      App.YieldToNextThread()
		    #Else
		      Thread.YieldToNext()
		    #EndIf
		  Loop
		  
		  Try
		    Dim data As String = mClient.SendRequest("/v1/fine-tunes/" + Me.ID + "/events")
		    Dim result As JSONItem
		    Try
		      result = New JSONItem(data)
		      If result.HasName("data") Then
		        Return result.Value("data")
		      End If
		    Catch err As JSONException
		      Raise New OpenAIException(mClient)
		    End Try
		    If result.HasName("error") Then
		      Raise New OpenAIException(result)
		    Else
		      Raise New OpenAIException("Weird JSON reply!" + EndOfLine + data)
		    End If
		  Finally
		    mLock.Leave()
		  End Try
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
		    Raise New OpenAIException(client)
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

	#tag Method, Flags = &h0
		Sub Refresh()
		  Do Until mLock.TryEnter()
		    #If RBVersion < 2020 Then
		      App.YieldToNextThread()
		    #Else
		      Thread.YieldToNext()
		    #EndIf
		  Loop
		  
		  Try
		    Dim data As String = mClient.SendRequest("/v1/fine-tunes/" + Me.ID)
		    Dim result As JSONItem
		    Try
		      result = New JSONItem(data)
		      mModel = result
		    Catch err As JSONException
		      Raise New OpenAIException(mClient)
		    End Try
		    If result.HasName("error") Then
		      Raise New OpenAIException(result)
		    Else
		      Raise New OpenAIException("Weird JSON reply!" + EndOfLine + data)
		    End If
		  Finally
		    mLock.Leave()
		  End Try
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private Shared FineTuneList() As FineTune
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Me.Status = "succeeded" Or Me.Status = "cancelled"
			End Get
		#tag EndGetter
		IsComplete As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Me.Status = "pending"
			End Get
		#tag EndGetter
		IsPending As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mLock As CriticalSection
	#tag EndProperty

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
			  
			  Try
			    If mModel.HasName("result_files") Then
			      Dim results As JSONItem = mModel.Value("result_files")
			      Return results.Count
			    End If
			  Finally
			    mLock.Leave()
			  End Try
			End Get
		#tag EndGetter
		ResultCount As Integer
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
			  
			  Try
			    If mModel.HasName("status") Then Return mModel.Value("status")
			  Finally
			    mLock.Leave()
			  End Try
			End Get
		#tag EndGetter
		Status As String
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private Shared ValidationOpt As Boolean = True
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
