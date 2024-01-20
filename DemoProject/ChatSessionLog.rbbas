#tag Class
Protected Class ChatSessionLog
	#tag Method, Flags = &h0
		Sub AddMessage(Request As OpenAI.Request, Response As OpenAI.Response)
		  mSession.Append(Request:Response)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(LogFile As FolderItem)
		  mSaveFile = LogFile
		  If mSaveFile.Exists Then Load(mSaveFile)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Load(LogFile As FolderItem)
		  Dim bs As BinaryStream = BinaryStream.Open(LogFile)
		  Dim data As String = bs.Read(bs.Length, Encodings.UTF8)
		  bs.Close
		  Dim log As New JSONItem(data)
		  
		  For i As Integer = 0 To log.Count - 1
		    Dim item As JSONItem = log.Child(i)
		    Dim js1 As JSONItem = item.Value("request")
		    Dim js2 As JSONItem = item.Value("response")
		    Dim req As New OpenAI.Request(js1)
		    Dim res As New OpenAI.Response(js2)
		    mSession.Append(req:res)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Save()
		  Dim output As New JSONItem
		  
		  For i As Integer = 0 To UBound(mSession)
		    Dim req As OpenAI.Request = mSession(i).Left
		    Dim res As OpenAI.Response = mSession(i).Right
		    Dim j1 As JSONItem = req
		    Dim j2 As JSONItem = res
		    Dim j3 As New JSONItem
		    j3.Value("request") = j1
		    j3.Value("response") = j2
		    output.Append(j3)
		  Next
		  
		  Dim bs As BinaryStream = BinaryStream.Create(mSaveFile, True)
		  Dim data As String = output.ToString
		  bs.Write(data)
		  bs.Close
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mSaveFile As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSession() As Pair
	#tag EndProperty


End Class
#tag EndClass
