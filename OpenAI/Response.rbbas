#tag Class
Protected Class Response
	#tag Method, Flags = &h1
		Protected Sub Constructor(ResponseData As JSONItem, Client As OpenAIClient)
		  mResponse = ResponseData
		  mClient = Client
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Create(Endpoint As String) As OpenAI.Response
		  ' Perform a GET request against the specified API Endpoint.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Response.Create
		  
		  Dim client As New OpenAIClient
		  Dim data As String = client.SendRequest(Endpoint)
		  Dim response As New JSONItem(data)
		  If response = Nil Or response.HasName("error") Then Raise New OpenAIException(response)
		  Return New OpenAI.Response(response, client)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Create(Endpoint As String, Request As OpenAI.Request) As OpenAI.Response
		  ' Perform the specified request against the specified API Endpoint.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Response.Create
		  
		  Dim client As New OpenAIClient
		  Dim response As New JSONItem(client.SendRequest(Endpoint, request))
		  If response = Nil Or response.HasName("error") Then Raise New OpenAIException(response)
		  Return New OpenAI.Response(response, client)
		  
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
		 Shared Function IsValid(Request As OpenAI.Request) As Boolean
		  Return Completion.IsValid(Request) Or File.IsValid(Request) Or FineTune.IsValid(Request) _
		  Or Image.IsValid(Request) Or Moderation.IsValid(Request)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ResultType(Index As Integer = 0) As OpenAI.ResultType
		  #pragma Unused Index
		  Return OpenAI.ResultType.JSONObject
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

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
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
			End Get
		#tag EndGetter
		ResultCount As Integer
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
