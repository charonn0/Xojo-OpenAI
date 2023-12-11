#tag Class
Protected Class OpenAIException
Inherits RuntimeException
	#tag Method, Flags = &h1000
		Sub Constructor(ErrorObject As JSONItem)
		  If ErrorObject <> Nil Then
		    ErrorObject = ErrorObject.Value("error")
		    If ErrorObject.Value("message") <> Nil Then Me.Message = ErrorObject.Value("message")
		    If ErrorObject.Value("type") <> Nil Then Me.Message = Me.Message + EndOfLine + ErrorObject.Value("type")
		    If ErrorObject.Value("param") <> Nil Then Me.Message = Me.Message + EndOfLine + "Param:" + ErrorObject.Value("param")
		    If ErrorObject.Value("code") <> Nil Then Me.Message = Me.Message + EndOfLine + "Code:" + ErrorObject.Value("code")
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1000
		Sub Constructor(Validation As OpenAI.ValidationError)
		  Dim err As String
		  Select Case Validation
		  Case ValidationError.BatchSize
		    err = "BatchSize"
		  Case ValidationError.BestOf
		    err = "BestOf"
		  Case ValidationError.ClassificationBetas
		    err = "ClassificationBetas"
		  Case ValidationError.ClassificationNClasses
		    err = "ClassificationNClasses"
		  Case ValidationError.ClassificationPositiveClass
		    err = "ClassificationPositiveClass"
		  Case ValidationError.ComputeClassificationMetrics
		    err = "ComputeClassificationMetrics"
		  Case ValidationError.Echo
		    err = "Echo"
		  Case ValidationError.File
		    err = "File"
		  Case ValidationError.FileName
		    err = "FileName"
		  Case ValidationError.FineTuneID
		    err = "FineTuneID"
		  Case ValidationError.FrequencyPenalty
		    err = "FrequencyPenalty"
		  Case ValidationError.HighQuality
		    err = "HighQuality"
		  Case ValidationError.Input
		    err = "Input"
		  Case ValidationError.Instruction
		    err = "Instruction"
		  Case ValidationError.LearningRateMultiplier
		    err = "LearningRateMultiplier"
		  Case ValidationError.LogItBias
		    err = "LogItBias"
		  Case ValidationError.LogProbabilities
		    err = "LogProbabilities"
		  Case ValidationError.MaskImage
		    err = "MaskImage"
		  Case ValidationError.MaxTokens
		    err = "MaxTokens"
		  Case ValidationError.Model
		    err = "Model"
		  Case ValidationError.NumberOfEpochs
		    err = "NumberOfEpochs"
		  Case ValidationError.NumberOfResults
		    err = "NumberOfResults"
		  Case ValidationError.PresencePenalty
		    err = "PresencePenalty"
		  Case ValidationError.Prompt
		    err = "Prompt"
		  Case ValidationError.PromptLossWeight
		    err = "PromptLossWeight"
		  Case ValidationError.Purpose
		    err = "Purpose"
		  Case ValidationError.ResultsAsURL
		    err = "ResultsAsURL"
		  Case ValidationError.Size
		    err = "Size"
		  Case ValidationError.SourceImage
		    err = "SourceImage"
		  Case ValidationError.Stop
		    err = "Stop"
		  Case ValidationError.Style
		    err = "Style"
		  Case ValidationError.Suffix
		    err = "Suffix"
		  Case ValidationError.Temperature
		    err = "Temperature"
		  Case ValidationError.Top_P
		    err = "Top_P"
		  Case ValidationError.TrainingFile
		    err = "TrainingFile"
		  Case ValidationError.ValidationFile
		    err = "ValidationFile"
		  End Select
		  
		  Me.Message = "Request parameter " + err + " appears to be invalid."
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1000
		Sub Constructor(Client As OpenAIClient)
		  Me.ErrorNumber = Client.LastErrorCode
		  Me.Message = "HTTP " + Str(Client.LastStatusCode) + ": " + Client.LastErrorMessage
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1000
		Sub Constructor(Message As String)
		  Me.Message = Message
		End Sub
	#tag EndMethod


	#tag ViewBehavior
		#tag ViewProperty
			Name="ErrorNumber"
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			InheritedFrom="RuntimeException"
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
			Name="Message"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
			InheritedFrom="RuntimeException"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InheritedFrom="Object"
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
