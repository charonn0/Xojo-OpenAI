#tag Class
Protected Class Image
Inherits OpenAI.Response
	#tag Method, Flags = &h1001
		Protected Sub Constructor(ResponseData As JSONItem)
		  // Calling the overridden superclass constructor.
		  // Constructor(ResponseData As JSONItem) -- From Response
		  Super.Constructor(ResponseData)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function CreateVariation(Request As OpenAI.Request) As OpenAI.Image
		  ' Given an existing image, the model will create one or more variations of it.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Image.CreateVariation
		  ' https://beta.openai.com/docs/api-reference/images/create-variation
		  
		  Dim client As New OpenAIClient
		  Dim result As JSONItem = client.SendRequest("/v1/images/variations", Request)
		  If result = Nil Or result.HasName("error") Then Raise New OpenAIException(result)
		  Return New OpenAI.Image(result)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function CreateVariation(Prompt As Picture, Size As String = "1024x1024", AsURL As Boolean = False) As OpenAI.Image
		  ' Given an existing image, the model will create one or more variations of it.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Image.CreateVariation
		  ' https://beta.openai.com/docs/api-reference/images/create-variation
		  
		  Dim request As New OpenAI.Request()
		  request.SourceImage = Prompt
		  request.Size = Size
		  request.ResultsAsURL = AsURL
		  Return Image.CreateVariation(request)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Edit(Request As OpenAI.Request) As OpenAI.Image
		  ' Given an existing image, the model will create one or more edited versions of it according
		  ' to the prompt.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Image.Edit
		  ' https://beta.openai.com/docs/api-reference/images/create-edit
		  
		  Dim client As New OpenAIClient
		  Dim result As JSONItem = client.SendRequest("/v1/images/edits", Request)
		  If result = Nil Or result.HasName("error") Then Raise New OpenAIException(result)
		  Return New OpenAI.Image(result)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Edit(Original As Picture, Prompt As String, Mask As Picture, Size As String = "1024x1024", AsURL As Boolean = False) As OpenAI.Image
		  ' Given an existing image, the model will create one or more edited versions of it according
		  ' to the prompt.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Image.Edit
		  ' https://beta.openai.com/docs/api-reference/images/create-edit
		  
		  Dim request As New OpenAI.Request()
		  request.Prompt = Prompt
		  request.SourceImage = Original
		  request.MaskImage = Mask
		  request.Size = Size
		  request.ResultsAsURL = AsURL
		  Return Image.Edit(request)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Generate(Request As OpenAI.Request) As OpenAI.Image
		  ' Generate one or more images according to a natural language prompt.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Image.Generate
		  ' https://beta.openai.com/docs/api-reference/images/create
		  
		  Dim client As New OpenAIClient
		  Dim result As JSONItem = client.SendRequest("/v1/images/generations", Request)
		  If result = Nil Or result.HasName("error") Then Raise New OpenAIException(result)
		  Return New OpenAI.Image(result)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Generate(Prompt As String, Size As String = "1024x1024", AsURL As Boolean = False) As OpenAI.Image
		  ' Generate one or more images according to a natural language prompt.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Image.Generate
		  ' https://beta.openai.com/docs/api-reference/images/create
		  
		  Dim request As New OpenAI.Request()
		  request.Prompt = Prompt
		  request.Size = Size
		  request.ResultsAsURL = AsURL
		  Return Image.Generate(request)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetResult(Index As Integer = 0) As Variant
		  ' Returns the result at Index, as a Picture object or a String URL.
		  '
		  ' See:
		  ' https://github.com/charonn0/Xojo-OpenAI/wiki/OpenAI.Response.GetResult
		  
		  Dim results As JSONItem = Super.GetResult(Index)
		  If results.HasName("b64_json") Then
		    Return Picture.FromData(DecodeBase64(results.Value("b64_json")))
		  ElseIf results.HasName("url") Then
		    Return DefineEncoding(results.Value("url"), Encodings.UTF8)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ResultType(Index As Integer = 0) As OpenAI.ResultType
		  Dim results As JSONItem = Super.GetResult(Index)
		  If results.HasName("b64_json") Then
		    Return OpenAI.ResultType.Picture
		  ElseIf results.HasName("url") Then
		    Return OpenAI.ResultType.PictureURL
		  End If
		End Function
	#tag EndMethod


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
