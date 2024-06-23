#tag Class
Protected Class Response
	#tag Method, Flags = &h0
		Sub Constructor(ResponseData As FolderItem)
		  Dim bs As BinaryStream = BinaryStream.Open(ResponseData)
		  Dim data As String = bs.Read(bs.Length)
		  bs.Close
		  Me.Constructor(New JSONItem(data))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(ResponseData As JSONItem)
		  ' Loads a previously created Response that was stored as JSON using Response.ToString()
		  ' The OriginalRequest property will be Nil in re-loaded Responses.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Response.Constructor
		  
		  mResponse = ResponseData
		  mClient = New OpenAIClient()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Constructor(ResponseData As JSONItem, Client As OpenAIClient, OriginalRequest As OpenAI.Request)
		  mResponse = ResponseData
		  mClient = Client
		  mOriginalRequest = OriginalRequest
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Create(Endpoint As String, Request As OpenAI.Request, RequestMethod As String = "POST") As OpenAI.Response
		  ' Perform the specified request against the specified API Endpoint.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Response.Create
		  
		  Dim client As New OpenAIClient
		  Dim response As JSONItem = CreateRaw(client, Endpoint, Request, RequestMethod)
		  If response = Nil Or response.HasName("error") Then Raise New OpenAIException(response)
		  Return New OpenAI.Response(response, client, Request)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Create(Endpoint As String, RequestMethod As String = "GET") As OpenAI.Response
		  ' Perform the specified request against the specified API Endpoint.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Response.Create
		  
		  Dim client As New OpenAIClient
		  Dim response As JSONItem = CreateRaw(client, Endpoint, RequestMethod)
		  If response = Nil Or response.HasName("error") Then Raise New OpenAIException(response)
		  Return New OpenAI.Response(response, client, Nil)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Shared Function CreateRaw(Client As OpenAIClient, Endpoint As String, Request As OpenAI.Request, RequestMethod As String = "POST") As JSONItem
		  Dim response As JSONItem
		  Dim data As String = Client.SendRequest(Endpoint, request, RequestMethod)
		  Try
		    response = New JSONItem(data)
		  Catch err As JSONException
		    Raise New OpenAIException(Client)
		  End Try
		  Return response
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Shared Function CreateRaw(Client As OpenAIClient, Endpoint As String, RequestMethod As String = "GET") As JSONItem
		  Dim data As String = Client.SendRequest(Endpoint, RequestMethod)
		  Dim response As JSONItem
		  Try
		    response = New JSONItem(data)
		  Catch err As JSONException
		    Raise New OpenAIException(Client)
		  End Try
		  Return response
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function CreateRaw(Endpoint As String, Request As OpenAI.Request, RequestMethod As String = "POST") As MemoryBlock
		  ' Perform the specified request against the specified API Endpoint, and
		  ' return the raw binary response without any interpretation or error checking.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Response.CreateRaw
		  
		  Dim client As New OpenAIClient
		  Dim data As String = client.SendRequest(Endpoint, request, RequestMethod)
		  If client.LastStatusCode = 200 And client.LastErrorCode = 0 Then Return data
		  Raise New OpenAIException(client)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function CreateRaw(Endpoint As String, RequestMethod As String = "GET") As MemoryBlock
		  ' Perform the specified request against the specified API Endpoint, and
		  ' return the raw binary response without any interpretation or error checking.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Response.CreateRaw
		  
		  Dim client As New OpenAIClient
		  Dim data As String = client.SendRequest(Endpoint, RequestMethod)
		  If client.LastStatusCode <> 200 Or client.LastErrorCode = 0 Then Return data
		  Raise New OpenAIException(client)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FinishReason(Index As Integer = 0) As String
		  ' Returns the reason for finishing the result at Index, as a String.
		  ' Not all endpoints supply this information.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Response.FinishReason
		  
		  Return GetResultAttribute(Index, "finish_reason", "")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetCreationDate() As Date
		  Return time_t(mResponse.Value("created"))
		  
		Exception err As KeyNotFoundException
		  Return Nil
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetResponseFormat() As String
		  Return "txt"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetResult(Index As Integer = 0) As Variant
		  ' Use this method to retrieve the response(s) to the request. The first (and often only)
		  ' response is at index zero. The last response is at Response.ResultCount-1.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Response.GetResult
		  
		  Dim results As JSONItem
		  Select Case True
		  Case mResponse.HasName("data")
		    results = mResponse.Value("data")
		    
		  Case mResponse.HasName("choices")
		    results = mResponse.Value("choices")
		    
		  Case mResponse.HasName("results")
		    results = mResponse.Value("results")
		    
		  Case mResponse.HasName("error")
		    Raise New OpenAIException(mResponse)
		    
		  End Select
		  
		  Return results.Child(Index)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetResultAttribute(Index As Integer, AttributeName As String, DefaultValue As Variant = Nil) As Variant
		  ' Use this method to retrieve parts of the JSON reply that are not exposed through the wrapper.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Response.GetResultAttribute
		  
		  Dim results As JSONItem
		  Select Case True
		  Case mResponse.HasName("data")
		    results = mResponse.Value("data")
		    
		  Case mResponse.HasName("choices")
		    results = mResponse.Value("choices")
		    
		  Case mResponse.HasName("results")
		    results = mResponse.Value("results")
		    
		  Case mResponse.HasName("error")
		    Raise New OpenAIException(mResponse)
		    
		  Else
		    Return DefaultValue
		    
		  End Select
		  
		  results = results.Child(Index)
		  Return results.Lookup(AttributeName, DefaultValue)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetResultCount() As Integer
		  Dim results As JSONItem
		  Select Case True
		  Case mResponse.HasName("data")
		    results = mResponse.Value("data")
		    
		  Case mResponse.HasName("choices")
		    results = mResponse.Value("choices")
		    
		  Case mResponse.HasName("results")
		    results = mResponse.Value("results")
		    
		  Case mResponse.HasName("error")
		    Raise New OpenAIException(mResponse)
		    
		  End Select
		  Return results.Count
		  
		  
		Exception err As KeyNotFoundException
		  Return 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetResultType() As OpenAI.ResultType
		  Return OpenAI.ResultType.JSONObject
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasResultAttribute(Index As Integer, AttributeName As String) As Boolean
		  ' Use this method to detect parts of the JSON reply that are not exposed through the wrapper.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Response.HasResultAttribute
		  
		  Dim results As JSONItem
		  Select Case True
		  Case mResponse.HasName("data")
		    results = mResponse.Value("data")
		    
		  Case mResponse.HasName("choices")
		    results = mResponse.Value("choices")
		    
		  Case mResponse.HasName("results")
		    results = mResponse.Value("results")
		    
		  Else
		    Return False
		    
		  End Select
		  
		  results = results.Child(Index)
		  Return results.HasName(AttributeName)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function IsValid(Request As OpenAI.Request) As OpenAI.ValidationError
		  ' For custom requests just assume the user knows what they're doing
		  #pragma Unused Request
		  Return ValidationError.None
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Convert() As JSONItem
		  ' Returns the raw JSON of the response as received from the API.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Response.Operator_Convert
		  
		  Return mResponse
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Save(SaveTo As FolderItem, Overwrite As Boolean = False)
		  Dim bs As BinaryStream = BinaryStream.Create(SaveTo, Overwrite)
		  bs.Write(Me.ToString)
		  bs.Close
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToString() As String
		  ' Serializes the internal JSONItem that was constructed from OpenAI's original response.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Response.ToString
		  
		  Return mResponse.ToString()
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' This property contains the date and time of when this response was generated.
			  '
			  ' See:
			  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Response.Created
			  
			  Return GetCreationDate()
			End Get
		#tag EndGetter
		Created As Date
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' This property contains the API ID of the response, if it has one.
			  '
			  ' See:
			  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Response.ID
			  
			  Return mResponse.Lookup("id", "")
			End Get
		#tag EndGetter
		ID As String
	#tag EndComputedProperty

	#tag Property, Flags = &h1
		Protected mClient As OpenAIClient
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' This property contains the API ID of the response, if it has one.
			  '
			  ' See:
			  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Response.Model
			  
			  If mResponse.HasName("model") Then
			    Return OpenAI.Model.Lookup(mResponse.Value("model").StringValue)
			  End If
			  
			End Get
		#tag EndGetter
		Model As OpenAI.Model
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mOriginalRequest As OpenAI.Request
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mResponse As JSONItem
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mOriginalRequest
			End Get
		#tag EndGetter
		OriginalRequest As OpenAI.Request
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Note
			When enabled, requests will be checked for basic sanity (using the IsValid() shared method) before
			being sent over the wire. This check is not fool-proof. Please report any requests that give false
			positives/negatives
		#tag EndNote
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
			  ' This property contains the API ID of the response, if it has one.
			  '
			  ' See:
			  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Response.ResponseFormat
			  
			  Return GetResponseFormat()
			End Get
		#tag EndGetter
		ResponseFormat As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Me.GetResultCount()
			End Get
		#tag EndGetter
		ResultCount As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return Me.GetResultType()
			End Get
		#tag EndGetter
		ResultType As OpenAI.ResultType
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Dim results As JSONItem = mResponse.Lookup("data", Nil)
			  If results <> Nil And results.Count > 0 Then
			    results = results.Child(0)
			    Return results.Lookup("revised_prompt", "")
			  End If
			End Get
		#tag EndGetter
		RevisedPrompt As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mResponse.HasName("system_fingerprint") Then
			    If mResponse.Value("system_fingerprint") <> Nil Then
			      Return mResponse.Value("system_fingerprint")
			    End If
			  End If
			End Get
		#tag EndGetter
		SystemFingerprint As String
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private Shared ValidationOpt As Boolean = True
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="ID"
			Group="Behavior"
			Type="String"
		#tag EndViewProperty
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
			Name="PromptTokenCount"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ReplyTokenCount"
			Group="Behavior"
			Type="Integer"
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
			Name="TokenCount"
			Group="Behavior"
			Type="Integer"
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
