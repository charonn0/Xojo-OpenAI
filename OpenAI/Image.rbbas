#tag Class
Protected Class Image
Inherits OpenAI.Response
	#tag Method, Flags = &h0
		 Shared Function CreateVariation(Prompt As Picture, Size As String = "1024x1024", AsURL As Boolean = False) As OpenAI.Image
		  Dim frmt As String = "b64_json"
		  If AsURL Then frmt = "url"
		  Return Image.CreateVariation(Prompt, Size, frmt, 1, "")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function CreateVariation(Prompt As Picture, Size As String, ResponseFormat As String, ResultCount As Integer, User As String) As OpenAI.Image
		  Dim request As New OpenAI.Request()
		  request.SourceImage = Prompt
		  request.Size = Size
		  request.ResultsAsURL = (ResponseFormat = "url")
		  If ResultCount > 1 Then request.NumberOfResults = ResultCount
		  If User <> "" Then request.User = User
		  Dim result As JSONItem = SendRequest("/v1/images/variations", request)
		  Return New ImageCreator(result)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Edit(Original As Picture, Prompt As String, Mask As Picture, ResultCount As Integer, Size As String, ResponseFormat As String, User As String) As OpenAI.Image
		  Dim request As New OpenAI.Request()
		  request.Prompt = Prompt
		  request.SourceImage = Original
		  request.MaskImage = Mask
		  If ResultCount > 1 Then request.NumberOfResults = ResultCount
		  request.Size = Size
		  request.ResultsAsURL = (ResponseFormat = "url")
		  If User <> "" Then request.User = User
		  Dim result As JSONItem = SendRequest("/v1/images/edits", request)
		  Return New ImageCreator(result)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Edit(Original As Picture, Prompt As String, Mask As Picture, Size As String = "1024x1024", AsURL As Boolean = False) As OpenAI.Image
		  Dim frmt As String = "b64_json"
		  If AsURL Then frmt = "url"
		  Return Image.Edit(Original, Prompt, Mask, 1, Size, frmt, "")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Generate(Prompt As String, Size As String = "1024x1024", AsURL As Boolean = False) As OpenAI.Image
		  Dim frmt As String = "b64_json"
		  If AsURL Then frmt = "url"
		  Return Image.Generate(Prompt, Size, frmt, 1, "")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Generate(Prompt As String, Size As String, ResponseFormat As String, ResultCount As Integer, User As String) As OpenAI.Image
		  Dim request As New OpenAI.Request()
		  request.Prompt = Prompt
		  request.Size = Size
		  request.ResultsAsURL = (ResponseFormat = "url")
		  If User <> "" Then request.User = User
		  If ResultCount > 1 Then request.NumberOfResults = ResultCount
		  Dim result As JSONItem = SendRequest("/v1/images/generations", request)
		  Return New ImageCreator(result)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetResult(Index As Integer) As Variant
		  Dim results As JSONItem = Super.GetResult(Index)
		  If results.HasName("b64_json") Then
		    Return Picture.FromData(DecodeBase64(results.Value("b64_json")))
		  ElseIf results.HasName("url") Then
		    Return DefineEncoding(results.Value("url"), Encodings.UTF8)
		  End If
		End Function
	#tag EndMethod


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
