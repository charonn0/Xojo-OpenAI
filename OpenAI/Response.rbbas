#tag Class
Protected Class Response
	#tag Method, Flags = &h1
		Protected Sub Constructor(ResponseData As JSONItem, Client As OpenAIClient)
		  mResponse = ResponseData
		  mClient = Client
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Create(Endpoint As String, Request As OpenAI.Request, RequestMethod As String = "POST") As OpenAI.Response
		  ' Perform the specified request against the specified API Endpoint.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Response.Create
		  
		  Dim client As New OpenAIClient
		  Dim response As JSONItem
		  Dim data As String = client.SendRequest(Endpoint, request, RequestMethod)
		  Try
		    response = New JSONItem(data)
		  Catch err As JSONException
		    Raise New OpenAIException(client)
		  End Try
		  If response = Nil Or response.HasName("error") Then Raise New OpenAIException(response)
		  Return New OpenAI.Response(response, client)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Create(Endpoint As String, RequestMethod As String = "GET") As OpenAI.Response
		  ' Perform the specified request against the specified API Endpoint.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Response.Create
		  
		  Dim client As New OpenAIClient
		  Dim data As String = client.SendRequest(Endpoint, RequestMethod)
		  Dim response As JSONItem
		  Try
		    response = New JSONItem(data)
		  Catch err As JSONException
		    Raise New OpenAIException(client)
		  End Try
		  If response = Nil Or response.HasName("error") Then Raise New OpenAIException(response)
		  Return New OpenAI.Response(response, client)
		  
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

	#tag Method, Flags = &h0
		Function GetResult(Index As Integer = 0) As Variant
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
		 Shared Function IsValid(Request As OpenAI.Request) As OpenAI.ValidationError
		  ' For custom requests just assume the user knows what they're doing
		  #pragma Unused Request
		  Return ValidationError.None
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Tokens(ResultIndex As Integer = 0) As OpenAI.TokenEngine
		  If UBound(mTokens) = -1 Then
		    For i As Integer = 0 To Me.ResultCount - 1
		      mTokens.Append(New TokenEngineCreator(Me, i))
		    Next
		  End If
		  Return mTokens(ResultIndex)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToString() As String
		  Return mResponse.ToString()
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return GetCreationDate()
			End Get
		#tag EndGetter
		Created As Date
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mResponse.Value("id")
			  
			  Exception err As KeyNotFoundException
			    Return ""
			End Get
		#tag EndGetter
		ID As String
	#tag EndComputedProperty

	#tag Property, Flags = &h1
		Protected mClient As OpenAIClient
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mResponse As JSONItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTokens() As OpenAI.TokenEngine
	#tag EndProperty

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
			  Completion.Prevalidate = value
			  File.Prevalidate = value
			  FineTune.Prevalidate = value
			  Image.Prevalidate = value
			  Moderation.Prevalidate = value
			End Set
		#tag EndSetter
		Shared Prevalidate As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mResponse.HasName("usage") Then
			    Dim usage As JSONItem = mResponse.Value("usage")
			    Return usage.Lookup("prompt_tokens", 0)
			  End If
			  
			  Exception err As KeyNotFoundException
			    Return 0
			End Get
		#tag EndGetter
		PromptTokenCount As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mResponse.HasName("usage") Then
			    Dim usage As JSONItem = mResponse.Value("usage")
			    Return usage.Lookup("completion_tokens", 0)
			  End If
			  
			  Exception err As KeyNotFoundException
			    Return 0
			End Get
		#tag EndGetter
		ReplyTokenCount As Integer
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
			  If mResponse.HasName("usage") Then
			    Dim usage As JSONItem = mResponse.Value("usage")
			    Return usage.Lookup("total_tokens", 0)
			  End If
			  
			  Exception err As KeyNotFoundException
			    Return 0
			End Get
		#tag EndGetter
		TokenCount As Integer
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
