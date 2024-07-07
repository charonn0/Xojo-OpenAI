#tag Class
Protected Class Model
	#tag Method, Flags = &h1
		Protected Sub Constructor(Response As JSONItem)
		  mModel = Response
		  Select Case Me.ID
		  Case "whisper-1"
		    mEndpoint = "/v1/audio/transcriptions;/v1/audio/translations"
		  Case "gpt-4", "gpt-4-0613", "gpt-4-32k", "gpt-4-32k-0613", "gpt-3.5-turbo", "gpt-3.5-turbo-0613", _
		     "gpt-3.5-turbo-16k", "gpt-3.5-turbo-16k-0613", "gpt-3.5-turbo-0301"
		    mEndpoint = "/v1/chat/completions"
		  Case "text-davinci-003", "text-davinci-002", "text-curie-001", "text-babbage-001", "text-ada-001", _
		    "babbage-code-search-code", "text-similarity-babbage-001", "text-davinci-001", "babbage-code-search-text", _
		    "babbage-similarity", "code-search-babbage-text-001", "code-search-babbage-code-001", "text-similarity-ada-001", _
		    "curie-instruct-beta", "ada-code-search-code", "ada-similarity", "code-search-ada-text-001", _
		    "text-search-ada-query-001", "davinci-search-document", "ada-code-search-text", "davinci-instruct-beta", _
		    "text-similarity-curie-001", "code-search-ada-code-001", "ada-search-query", "text-search-davinci-query-001", _
		    "curie-search-query", "davinci-search-query", "babbage-search-document", "ada-search-document", _
		    "text-search-curie-query-001", "text-search-babbage-doc-001", "curie-search-document", "text-search-curie-doc-001", _
		    "babbage-search-query", "text-search-davinci-doc-001", "text-search-babbage-query-001", "curie-similarity", _
		    "text-similarity-davinci-001", "davinci-similarity"
		    mEndpoint = "/v1/completions"
		  Case "text-davinci-edit-001", "code-davinci-edit-001"
		    mEndpoint = "/v1/edits"
		  Case "davinci", "curie", "babbage", "ada"
		    mEndpoint = "/v1/fine-tunes"
		  Case "text-embedding-ada-002", "text-search-ada-doc-001"
		    mEndpoint = "/v1/embeddings"
		  Case "text-moderation-stable", "text-moderation-latest"
		    mEndpoint = "/v1/moderations"
		  Case "tts-1", "tts-1-hd"
		    mEndpoint = "/v1/audio/speech"
		  Case "dall-e-2", "dall-e-3"
		    mEndpoint = "/v1/images/generations"
		  Else
		    If InStr(Me.ID, "instruct") > 0 Then
		      mEndpoint = "/v1/completions"
		    ElseIf Left(Me.ID, 3) = "GPT" Then
		      mEndpoint = "/v1/chat/completions"
		    ElseIf Left(Me.ID, 4) = "dall" Then
		      mEndpoint = "/v1/images/generations"
		    ElseIf Left(Me.ID, 3) = "tts" Then
		      mEndpoint = "/v1/audio/speech"
		    ElseIf Left(Me.ID, 7) = "whisper" Then
		      mEndpoint = "/v1/audio/transcriptions;/v1/audio/translations"
		    ElseIf Left(Me.ID, 7) = "davinci" Or Left(Me.ID, 7) = "babbage" Then
		      mEndpoint = "/v1/completions"
		    Else
		      mEndpoint = ""
		    End If
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Count(Refresh As Boolean = False) As Integer
		  ' Counts the number of AI models known by the API.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Model.Count
		  
		  If Refresh Or UBound(ModelList) = -1 Then ListAvailableModels()
		  Return UBound(ModelList) + 1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Delete()
		  ' Deletes the specified fine-tuned Model. You must be the owner of the model.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Model.Delete
		  
		  Dim client As New OpenAIClient()
		  Dim data As String = client.SendRequest("/v1/models/" + Me.ID, "DELETE")
		  Dim response As JSONItem
		  Try
		    response = New JSONItem(data)
		  Catch err As JSONException
		    Raise New OpenAIException(client)
		  End Try
		  If response = Nil Or response.HasName("error") Then Raise New OpenAIException(response) Else ReDim ModelList(-1)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function GetModelsForEndpoint(Endpoint As String, Refresh As Boolean = False) As OpenAI.Model()
		  ' Returns a list of AI models that are compatible with the specified endpoint. The Endpoint parameter
		  ' is only the path part of the overall URL. For example, in the URL https://api.openai.com/v1/chat/completions
		  ' the endpoint is "/v1/chat/completions"
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Model.GetModelsForEndpoint
		  
		  If Refresh Or UBound(ModelList) = -1 Then ListAvailableModels()
		  Dim matches() As OpenAI.Model
		  For Each m As OpenAI.Model In ModelList
		    Dim ends() As String = Split(m.Endpoint, ";")
		    For Each e As String In ends
		      If e.Trim = Endpoint Then
		        matches.Append(m)
		        Exit For e
		      End If
		    Next
		  Next
		  Return matches
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Sub ListAvailableModels()
		  ReDim ModelList(-1)
		  Dim client As New OpenAIClient
		  Dim data As String = client.SendRequest("/v1/models")
		  Dim lst As JSONItem
		  Try
		    lst = New JSONItem(data)
		  Catch err As JSONException
		    Raise New OpenAIException(client)
		  End Try
		  If lst = Nil Or Not lst.HasName("data") Then Raise New OpenAIException(lst)
		  lst = lst.Value("data")
		  
		  For i As Integer = 0 To lst.Count - 1
		    Dim m As New OpenAI.Model(lst.Child(i))
		    ModelList.Append(m)
		  Next
		  
		  ' text-moderation-stable and text-moderation-latest are the two models that
		  ' may be used with the Moderation endpoint, but they are not listed by the
		  ' Models endpoint, so they're added here
		  ModelList.Append(New OpenAI.Model(New JSONItem(TEXT_MODERATION_LATEST)))
		  ModelList.Append(New OpenAI.Model(New JSONItem(TEXT_MODERATION_STABLE)))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Lookup(Index As Integer, Refresh As Boolean = False) As OpenAI.Model
		  ' Returns the Model at Index.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Model.Lookup
		  
		  If Refresh Or UBound(ModelList) = -1 Then ListAvailableModels()
		  Return ModelList(Index)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Lookup(ModelName As String, Refresh As Boolean = False) As OpenAI.Model
		  ' Returns the Model that matches the specified name.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Model.Lookup
		  
		  If Refresh Or UBound(ModelList) = -1 Then ListAvailableModels()
		  For i As Integer = 0 To UBound(ModelList)
		    If ModelList(i).ID = ModelName Then Return ModelList(i)
		  Next
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Convert(FromName As String)
		  Dim m As Model = OpenAI.Model.Lookup(FromName)
		  If m = Nil Then Raise New OpenAIException("Invalid model name: '" + FromName + "'")
		  Me.Constructor(m.mModel)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToString() As String
		  Return mModel.ToString()
		End Function
	#tag EndMethod


	#tag Note, Name = About models
		https://platform.openai.com/docs/models/overview
	#tag EndNote


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If Not mModel.HasName("permission") Then Return False
			  Dim perms As JSONItem = mModel.Value("permission")
			  If perms = Nil Then Return False
			  perms = perms.Child(0)
			  Return perms.Value("allow_create_engine")
			  
			  Exception err As KeyNotFoundException
			    Return False
			End Get
		#tag EndGetter
		AllowCreate As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If Not mModel.HasName("permission") Then Return False
			  Dim perms As JSONItem = mModel.Value("permission")
			  If perms = Nil Then Return False
			  perms = perms.Child(0)
			  Return perms.Value("allow_fine_tuning")
			  
			  Exception err As KeyNotFoundException
			    Return False
			End Get
		#tag EndGetter
		AllowFineTuning As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If Not mModel.HasName("permission") Then Return False
			  Dim perms As JSONItem = mModel.Value("permission")
			  If perms = Nil Then Return False
			  perms = perms.Child(0)
			  Return perms.Value("allow_logprobs")
			  
			  Exception err As KeyNotFoundException
			    Return False
			End Get
		#tag EndGetter
		AllowLogProbs As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If Not mModel.HasName("permission") Then Return False
			  Dim perms As JSONItem = mModel.Value("permission")
			  If perms = Nil Then Return False
			  perms = perms.Child(0)
			  Return perms.Value("allow_sampling")
			  
			  Exception err As KeyNotFoundException
			    Return False
			End Get
		#tag EndGetter
		AllowSampling As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If Not mModel.HasName("permission") Then Return False
			  Dim perms As JSONItem = mModel.Value("permission")
			  If perms = Nil Then Return False
			  perms = perms.Child(0)
			  Return perms.Value("allow_search_indices")
			  
			  Exception err As KeyNotFoundException
			    Return False
			End Get
		#tag EndGetter
		AllowSearchIndices As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If Not mModel.HasName("permission") Then Return False
			  Dim perms As JSONItem = mModel.Value("permission")
			  If perms = Nil Then Return False
			  perms = perms.Child(0)
			  Return perms.Value("allow_view")
			  
			  Exception err As KeyNotFoundException
			    Return False
			End Get
		#tag EndGetter
		AllowView As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return time_t(mModel.Value("created"))
			  
			  Exception err As KeyNotFoundException
			    Return Nil
			End Get
		#tag EndGetter
		Created As Date
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' Returns the API endpoint associated with this AI Model. If the Model is associated with more
			  ' than one endpoint then they will be delimited by semicolons (;).
			  
			  return mEndpoint
			End Get
		#tag EndGetter
		Endpoint As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If Not mModel.HasName("permission") Then Return ""
			  Dim perms As JSONItem = mModel.Value("permission")
			  perms = perms.Child(0)
			  If perms.Value("group") <> Nil Then Return perms.Value("group")
			  
			  Exception err As KeyNotFoundException
			    Return ""
			End Get
		#tag EndGetter
		Group As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mModel.Value("id")
			  
			  Exception err As KeyNotFoundException
			    Return ""
			End Get
		#tag EndGetter
		ID As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If Not mModel.HasName("permission") Then Return False
			  Dim perms As JSONItem = mModel.Value("permission")
			  perms = perms.Child(0)
			  Return perms.Value("is_blocking")
			  
			  Exception err As KeyNotFoundException
			    Return False
			End Get
		#tag EndGetter
		IsBlocking As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mEndpoint As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mModel As JSONItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Shared ModelList() As Model
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If Not mModel.HasName("permission") Then Return ""
			  Dim perms As JSONItem = mModel.Value("permission")
			  perms = perms.Child(0)
			  Return perms.Value("organization")
			  
			  Exception err As KeyNotFoundException
			    Return ""
			End Get
		#tag EndGetter
		Organization As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mModel.Value("owned_by")
			  
			  Exception err As KeyNotFoundException
			    Return ""
			End Get
		#tag EndGetter
		OwnedBy As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mModel.HasName("parent") And mModel.Value("parent") <> Nil Then
			    Dim nm As String = mModel.Value("parent")
			    Return OpenAI.Model.Lookup(nm)
			  End If
			  
			  Exception err As KeyNotFoundException
			    Return Nil
			End Get
		#tag EndGetter
		Parent As OpenAI.Model
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' If an AI Model has been deprecated by OpenAI, this property will contain a list
			  ' of its recommended replacement(s). If a model is not deprecated this property 
			  ' will be empty.
			  '
			  ' See:
			  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Model.Replacement
			  ' https://platform.openai.com/docs/deprecations
			  
			  Static deprecations As Dictionary
			  If deprecations = Nil Then
			    deprecations = New Dictionary( _
			    "ada":"ada-002",_
			    "ada":"ada-002",_
			    "babbage":"babbage-002",_
			    "babbage":"babbage-002",_
			    "code-cushman-001":"gpt-4",_
			    "code-cushman-002":"gpt-4",_
			    "code-davinci-001":"gpt-4",_
			    "code-davinci-002":"gpt-4",_
			    "code-davinci-002":"gpt-3.5-turbo-base",_
			    "code-davinci-edit-001":"gpt-4",_
			    "code-search-ada-code-001":"text-embedding-ada-002",_
			    "code-search-ada-text-001":"text-embedding-ada-002",_
			    "code-search-babbage-code-001":"text-embedding-ada-002",_
			    "code-search-babbage-text-001":"text-embedding-ada-002",_
			    "curie":"curie-002",_
			    "curie":"curie-002",_
			    "davinci":"davinci-002",_
			    "davinci":"davinci-002, gpt-3.5-turbo, gpt-4",_
			    "gpt-3.5-turbo-0301":"gpt-3.5-turbo-0613",_
			    "gpt-4-0314":"gpt-4-0613",_
			    "gpt-4-32k-0314":"gpt-4-32k-0613",_
			    "text-ada-001":"gpt-3.5-turbo-instruct",_
			    "text-babbage-001":"gpt-3.5-turbo-instruct",_
			    "text-curie-001":"gpt-3.5-turbo-instruct",_
			    "text-davinci-001":"gpt-3.5-turbo-instruct",_
			    "text-davinci-002":"gpt-3.5-turbo-instruct",_
			    "text-davinci-003":"gpt-3.5-turbo-instruct",_
			    "text-davinci-edit-001":"gpt-4",_
			    "text-search-ada-doc-001":"text-embedding-ada-002",_
			    "text-search-ada-query-001":"text-embedding-ada-002",_
			    "text-search-babbage-doc-001":"text-embedding-ada-002",_
			    "text-search-babbage-query-001":"text-embedding-ada-002",_
			    "text-search-curie-doc-001":"text-embedding-ada-002",_
			    "text-search-curie-query-001":"text-embedding-ada-002",_
			    "text-search-davinci-doc-001":"text-embedding-ada-002",_
			    "text-search-davinci-query-001":"text-embedding-ada-002",_
			    "text-similarity-ada-001":"text-embedding-ada-002",_
			    "text-similarity-babbage-001":"text-embedding-ada-002",_
			    "text-similarity-curie-001":"text-embedding-ada-002",_
			    "text-similarity-davinci-001":"text-embedding-ada-002")
			  End If
			  Return deprecations.Lookup(Me.ID, "")
			End Get
		#tag EndGetter
		Replacement As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Dim mdl As OpenAI.Model
			  If mModel.HasName("root") And mModel.Value("root") <> Nil Then
			    Dim nm As String = mModel.Value("root")
			    mdl = OpenAI.Model.Lookup(nm)
			    If Not (mdl Is Me) Then Return mdl
			  End If
			  Select Case True
			  Case InStr(Me.ID, "davinci") > 0
			    mdl = OpenAI.Model.Lookup("davinci")
			  Case InStr(Me.ID, "babbage") > 0
			    mdl = OpenAI.Model.Lookup("babbage")
			  Case InStr(Me.ID, "ada") > 0
			    mdl = OpenAI.Model.Lookup("ada")
			  Case InStr(Me.ID, "curie") > 0
			    mdl = OpenAI.Model.Lookup("curie")
			  End Select
			  If mdl Is Me Then Return Nil
			  Return mdl
			  
			  Exception err As KeyNotFoundException
			    Return Nil
			End Get
		#tag EndGetter
		Root As OpenAI.Model
	#tag EndComputedProperty


	#tag Constant, Name = TEXT_MODERATION_LATEST, Type = String, Dynamic = False, Default = \"{\"id\":\"text-moderation-latest\"\x2C\"object\":\"model\"\x2C\"created\":0\x2C\"owned_by\":\"openai\"\x2C\"permission\":[{\"id\":\"\"\x2C\"object\":\"model_permission\"\x2C\"created\":0\x2C\"allow_create_engine\":false\x2C\"allow_sampling\":false\x2C\"allow_logprobs\":false\x2C\"allow_search_indices\":false\x2C\"allow_view\":false\x2C\"allow_fine_tuning\":false\x2C\"organization\":\"*\"\x2C\"group\":null\x2C\"is_blocking\":false}]\x2C\"root\":\"text-moderation\"\x2C\"parent\":null}", Scope = Private
	#tag EndConstant

	#tag Constant, Name = TEXT_MODERATION_STABLE, Type = String, Dynamic = False, Default = \"{\"id\":\"text-moderation-stable\"\x2C\"object\":\"model\"\x2C\"created\":0\x2C\"owned_by\":\"openai\"\x2C\"permission\":[{\"id\":\"\"\x2C\"object\":\"model_permission\"\x2C\"created\":0\x2C\"allow_create_engine\":false\x2C\"allow_sampling\":false\x2C\"allow_logprobs\":false\x2C\"allow_search_indices\":false\x2C\"allow_view\":false\x2C\"allow_fine_tuning\":false\x2C\"organization\":\"*\"\x2C\"group\":null\x2C\"is_blocking\":false}]\x2C\"root\":\"text-moderation\"\x2C\"parent\":null}", Scope = Private
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="AllowCreate"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowFineTuning"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowLogProbs"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowSampling"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowSearchIndices"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowView"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Group"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ID"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
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
		#tag EndViewProperty
		#tag ViewProperty
			Name="OwnedBy"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
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
