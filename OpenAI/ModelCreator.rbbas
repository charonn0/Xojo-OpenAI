#tag Class
 Attributes ( hidden = true ) Class ModelCreator
Inherits OpenAI.Model
	#tag Method, Flags = &h1000
		Sub Constructor(Response As JSONItem)
		  // Calling the overridden superclass constructor.
		  // Constructor(Response As JSONItem) -- From Model
		  Super.Constructor(Response)
		  
		End Sub
	#tag EndMethod


	#tag ViewBehavior
		#tag ViewProperty
			Name="AllowCreate"
			Group="Behavior"
			Type="Boolean"
			InheritedFrom="OpenAI.Model"
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowFineTuning"
			Group="Behavior"
			Type="Boolean"
			InheritedFrom="OpenAI.Model"
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowLogProbs"
			Group="Behavior"
			Type="Boolean"
			InheritedFrom="OpenAI.Model"
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowSampling"
			Group="Behavior"
			Type="Boolean"
			InheritedFrom="OpenAI.Model"
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowSearchIndices"
			Group="Behavior"
			Type="Boolean"
			InheritedFrom="OpenAI.Model"
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowView"
			Group="Behavior"
			Type="Boolean"
			InheritedFrom="OpenAI.Model"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Group"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
			InheritedFrom="OpenAI.Model"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ID"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
			InheritedFrom="OpenAI.Model"
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
			InheritedFrom="OpenAI.Model"
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
			InheritedFrom="OpenAI.Model"
		#tag EndViewProperty
		#tag ViewProperty
			Name="OwnedBy"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
			InheritedFrom="OpenAI.Model"
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
