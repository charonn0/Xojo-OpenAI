#tag Class
Private Class TokenEngineCreator
Inherits OpenAI.TokenEngine
	#tag Method, Flags = &h1000
		Sub Constructor(Result As OpenAI.Response, ResultIndex As Integer)
		  // Calling the overridden superclass constructor.
		  // Constructor(Result As OpenAI.Response, ResultIndex As Integer) -- From OpenAI.TokenEngine
		  Super.Constructor(Result, ResultIndex)
		  
		End Sub
	#tag EndMethod


End Class
#tag EndClass
