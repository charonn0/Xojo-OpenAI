#tag Class
Private Class FileCreator
Inherits OpenAI.File
	#tag Method, Flags = &h1000
		Sub Constructor(ResponseData As JSONItem)
		  // Calling the overridden superclass constructor.
		  // Constructor(ResponseData As JSONItem) -- From Response
		  Super.Constructor(ResponseData)
		  
		End Sub
	#tag EndMethod


End Class
#tag EndClass
