#tag Class
Protected Class Model
	#tag Method, Flags = &h1
		Protected Sub Constructor(Response As JSONItem)
		  mModel = Response
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
		https://beta.openai.com/docs/models/overview
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
			  Dim perms As JSONItem = mModel.Value("permission")
			  perms = perms.Child(0)
			  Return perms.Value("is_blocking")
			  
			  Exception err As KeyNotFoundException
			    Return False
			End Get
		#tag EndGetter
		IsBlocking As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h1
		Protected mModel As JSONItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Shared ModelList() As Model
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
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
