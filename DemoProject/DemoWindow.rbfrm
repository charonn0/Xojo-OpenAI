#tag Window
Begin Window DemoWindow
   BackColor       =   "&cFFFFFF00"
   Backdrop        =   0
   CloseButton     =   True
   Composite       =   False
   Frame           =   0
   FullScreen      =   False
   HasBackColor    =   False
   Height          =   647
   ImplicitInstance=   True
   LiveResize      =   True
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   True
   MaxWidth        =   32000
   MenuBar         =   0
   MenuBarVisible  =   True
   MinHeight       =   578
   MinimizeButton  =   True
   MinWidth        =   905
   Placement       =   2
   Resizeable      =   True
   Title           =   "Xojo-OpenAI Playground"
   Visible         =   True
   Width           =   905
   Begin GroupBox OpenAIGroup
      AutoDeactivate  =   True
      Bold            =   False
      Caption         =   "OpenAI"
      Enabled         =   False
      Height          =   555
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   11
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   0
      TabIndex        =   2
      TabPanelIndex   =   0
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   59
      Underline       =   False
      Visible         =   True
      Width           =   883
      Begin Label ReplyInfoLbl
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "OpenAIGroup"
         Italic          =   False
         Left            =   32
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   False
         Multiline       =   False
         Scope           =   0
         Selectable      =   False
         TabIndex        =   21
         TabPanelIndex   =   0
         Text            =   "Reply/Output:"
         TextAlign       =   0
         TextColor       =   "&c00000000"
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   300
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   292
      End
      Begin LinkTextArea ReplyText
         AcceptTabs      =   False
         Alignment       =   0
         AutoDeactivate  =   True
         AutomaticallyCheckSpelling=   True
         BackColor       =   "&cFFFFFF00"
         Bold            =   False
         Border          =   True
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Format          =   ""
         Height          =   281
         HelpTag         =   ""
         HideSelection   =   True
         Index           =   -2147483648
         InitialParent   =   "OpenAIGroup"
         Italic          =   False
         Left            =   32
         LimitText       =   0
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Mask            =   ""
         Multiline       =   True
         ReadOnly        =   False
         Scope           =   0
         ScrollbarHorizontal=   False
         ScrollbarVertical=   True
         Styled          =   True
         TabIndex        =   22
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   ""
         TextColor       =   "&c00000000"
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   325
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   300
      End
      Begin Canvas ReplyImageCanvas
         AcceptFocus     =   False
         AcceptTabs      =   False
         AutoDeactivate  =   True
         Backdrop        =   0
         DoubleBuffer    =   False
         Enabled         =   True
         EraseBackground =   True
         Height          =   281
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "OpenAIGroup"
         Left            =   338
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   0
         TabIndex        =   24
         TabPanelIndex   =   0
         TabStop         =   True
         Top             =   325
         UseFocusRing    =   True
         Visible         =   True
         Width           =   547
      End
      Begin Label Label4
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "OpenAIGroup"
         Italic          =   False
         Left            =   344
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   False
         Multiline       =   False
         Scope           =   0
         Selectable      =   False
         TabIndex        =   23
         TabPanelIndex   =   0
         Text            =   "Image output:"
         TextAlign       =   0
         TextColor       =   "&c00000000"
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   300
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   186
      End
      Begin Listbox ModelList
         AutoDeactivate  =   True
         AutoHideScrollbars=   True
         Bold            =   False
         Border          =   True
         ColumnCount     =   2
         ColumnsResizable=   False
         ColumnWidths    =   ""
         DataField       =   ""
         DataSource      =   ""
         DefaultRowHeight=   -1
         Enabled         =   True
         EnableDrag      =   False
         EnableDragReorder=   False
         GridLinesHorizontal=   0
         GridLinesVertical=   0
         HasHeading      =   True
         HeadingIndex    =   -1
         Height          =   176
         HelpTag         =   ""
         Hierarchical    =   True
         Index           =   -2147483648
         InitialParent   =   "OpenAIGroup"
         InitialValue    =   "AI model	Used for"
         Italic          =   False
         Left            =   509
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         RequiresSelection=   False
         Scope           =   0
         ScrollbarHorizontal=   False
         ScrollBarVertical=   True
         SelectionType   =   0
         TabIndex        =   11
         TabPanelIndex   =   0
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   81
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   376
         _ScrollOffset   =   0
         _ScrollWidth    =   -1
      End
      Begin Listbox OptionsListBox
         AutoDeactivate  =   True
         AutoHideScrollbars=   True
         Bold            =   False
         Border          =   True
         ColumnCount     =   2
         ColumnsResizable=   True
         ColumnWidths    =   "25%,*"
         DataField       =   ""
         DataSource      =   ""
         DefaultRowHeight=   -1
         Enabled         =   True
         EnableDrag      =   False
         EnableDragReorder=   False
         GridLinesHorizontal=   0
         GridLinesVertical=   0
         HasHeading      =   True
         HeadingIndex    =   -1
         Height          =   152
         HelpTag         =   ""
         Hierarchical    =   False
         Index           =   -2147483648
         InitialParent   =   "OpenAIGroup"
         InitialValue    =   "Option	Value"
         Italic          =   False
         Left            =   36
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         RequiresSelection=   False
         Scope           =   0
         ScrollbarHorizontal=   False
         ScrollBarVertical=   True
         SelectionType   =   0
         TabIndex        =   25
         TabPanelIndex   =   0
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   105
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   468
         _ScrollOffset   =   0
         _ScrollWidth    =   -1
      End
      Begin PopupMenu TaskSelectMenu
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "OpenAIGroup"
         InitialValue    =   "Select AI Task...\r\nImages: Generate\r\nImages: Generate variation\r\nImages: Modify\r\nImages: Recognize\r\nAudio: Synthesize speech\r\nAudio: Transcribe English audio\r\nAudio: Translate audio to English text\r\nText: Categorize for sex, violence, etc.\r\nText: Chat"
         Italic          =   False
         Left            =   36
         ListIndex       =   0
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   0
         TabIndex        =   26
         TabPanelIndex   =   0
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   81
         Underline       =   False
         Visible         =   True
         Width           =   409
      End
      Begin PushButton PerformRequestBtn
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   0
         Cancel          =   False
         Caption         =   "Go"
         Default         =   False
         Enabled         =   True
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "OpenAIGroup"
         Italic          =   False
         Left            =   448
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Scope           =   0
         TabIndex        =   27
         TabPanelIndex   =   0
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   79
         Underline       =   False
         Visible         =   True
         Width           =   56
      End
      Begin PushButton DoAbortBtn
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   0
         Cancel          =   False
         Caption         =   "Abort"
         Default         =   False
         Enabled         =   True
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "OpenAIGroup"
         Italic          =   False
         Left            =   357
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         Scope           =   0
         TabIndex        =   28
         TabPanelIndex   =   0
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   275
         Underline       =   False
         Visible         =   False
         Width           =   209
      End
      Begin ProgressBar RequestProgressBar
         AutoDeactivate  =   True
         Enabled         =   True
         Height          =   12
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "OpenAIGroup"
         Left            =   357
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         Maximum         =   0
         Scope           =   0
         TabPanelIndex   =   0
         Top             =   263
         Value           =   0
         Visible         =   False
         Width           =   209
      End
   End
   Begin TextField APIKeyField
      AcceptTabs      =   False
      Alignment       =   0
      AutoDeactivate  =   True
      AutomaticallyCheckSpelling=   False
      BackColor       =   "&cFFFFFF00"
      Bold            =   False
      Border          =   True
      CueText         =   ""
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Format          =   ""
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      Italic          =   False
      Left            =   95
      LimitText       =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Mask            =   ""
      Password        =   False
      ReadOnly        =   False
      Scope           =   0
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextColor       =   "&c00000000"
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   25
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   746
   End
   Begin PushButton SetAPIKeyBtn
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   0
      Cancel          =   False
      Caption         =   "Set"
      Default         =   False
      Enabled         =   True
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   846
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      Scope           =   0
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   25
      Underline       =   False
      Visible         =   True
      Width           =   48
   End
   Begin Label APIKeyLbl
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   11
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   4
      TabPanelIndex   =   0
      Text            =   "API Key:"
      TextAlign       =   2
      TextColor       =   "&c00000000"
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   25
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   79
   End
   Begin Timer RefreshTimer
      Height          =   32
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   ""
      LockedInPosition=   False
      Mode            =   0
      Period          =   1
      Scope           =   0
      TabPanelIndex   =   0
      Top             =   ""
      Width           =   32
   End
   Begin Label URLLbl
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   286
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   5
      TabPanelIndex   =   0
      Text            =   "https://github.com/charonn0/Xojo-OpenAI"
      TextAlign       =   1
      TextColor       =   "&c0000FF00"
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   2
      Transparent     =   False
      Underline       =   True
      Visible         =   True
      Width           =   333
   End
   Begin Label StatusBarLbl
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   True
      Left            =   11
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   False
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   3
      TabPanelIndex   =   0
      Text            =   "Waiting for API key"
      TextAlign       =   0
      TextColor       =   "&c00000000"
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   626
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   894
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Open()
		  mAPIOptions = New Dictionary
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Shared Function FetchImageURL(ImageURL As String) As Picture
		  #If RBVersion > 2018.03 Then
		    Dim connection As New URLConnection
		    Return Picture.FromData(Connection.SendSync("GET", ImageURL, 5))
		  #ElseIf RBVersion > 2014.02 Then
		    Dim connection As New HTTPSecureSocket
		    connection.ConnectionType = SSLSocket.SSLv23
		    Return Picture.FromData(connection.Get(ImageURL, 5))
		  #Else
		    #pragma Unused ImageURL
		    Return Nil
		  #endif
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Sub FillGradient(g As Graphics, StartColor As Color, EndColor As Color)
		  Dim ratio, endratio as Double
		  For i As Integer = 0 To g.Height
		    ratio = ((g.Height - i) / g.Height)
		    endratio = (i / g.Height)
		    g.ForeColor = RGB(startColor.Red * endratio + endColor.Red * ratio, startColor.Green * endratio + endColor.Green * ratio, _
		    startColor.Blue * endratio + endColor.Blue * ratio)
		    g.DrawLine(0, i, g.Width, i)
		  next
		  g.ForeColor = endColor
		  g.DrawLine(0, 0, g.Width, 0)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetCreateImageRequest() As OpenAI.Request
		  Dim request As New OpenAI.Request()
		  request.Prompt = GetOption("Prompt", "")
		  request.Size = GetOption("Size", "1024x1024")
		  request.ResultsAsURL = GetOption("ResponseAsURL", False)
		  If IsOptionSet("Number of results") Then request.NumberOfResults = GetOption("Number of results")
		  If IsOptionSet("Quality") Then request.HighQuality = (GetOption("Quality") = "hd")
		  If IsOptionSet("Style") Then request.Style = GetOption("Style")
		  If IsOptionSet("User") Then request.Style = GetOption("User")
		  If Not IsOptionSet("Model") Then SetOption("Model") = OpenAI.Model.Lookup("dall-e-2")
		  request.Model = GetOption("Model")
		  Return request
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetCreateImageVariationRequest() As OpenAI.Request
		  Dim request As New OpenAI.Request()
		  Dim f As FolderItem = GetOption("Image", Nil)
		  request.SourceImage = Picture.Open(f) 
		  request.Size = GetOption("Size", "1024x1024")
		  request.ResultsAsURL = GetOption("ResponseAsURL", False)
		  If IsOptionSet("Number of results") Then request.NumberOfResults = GetOption("Number of results")
		  If IsOptionSet("User") Then request.Style = GetOption("User")
		  If Not IsOptionSet("Model") Then SetOption("Model") = OpenAI.Model.Lookup("dall-e-2")
		  request.Model = GetOption("Model")
		  Return request
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetEditImageRequest() As OpenAI.Request
		  Dim request As New OpenAI.Request()
		  request.Prompt = GetOption("Prompt", "")
		  request.Size = GetOption("Size", "1024x1024")
		  request.ResultsAsURL = GetOption("ResponseAsURL", False)
		  If IsOptionSet("Number of results") Then request.NumberOfResults = GetOption("Number of results")
		  If IsOptionSet("User") Then request.Style = GetOption("User")
		  If Not IsOptionSet("Model") Then SetOption("Model") = OpenAI.Model.Lookup("dall-e-2")
		  request.Model = GetOption("Model")
		  
		  Dim f As FolderItem = GetOption("Image", Nil)
		  If f = Nil Then Raise New OpenAI.OpenAIException("No valid image specified.")
		  request.SourceImage = Picture.Open(f)
		  
		  f = GetOption("Image", Nil)
		  If f <> Nil Then request.MaskImage = Picture.Open(f)
		  
		  Return request
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetModerationRequest() As OpenAI.Request
		  Dim request As New OpenAI.Request()
		  request.Input = GetOption("Input", "")
		  request.Model = GetOption("Model", OpenAI.Model.Lookup("text-moderation-stable"))
		  If IsOptionSet("Number of results") Then request.NumberOfResults = GetOption("Number of results")
		  Return request
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetOption(Name As String, Optional DefaultValue As Variant = Nil) As Variant
		  Return mAPIOptions.Lookup(Name, DefaultValue)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetRecognizeImageRequest() As OpenAI.Request
		  Dim request As New OpenAI.Request()
		  If IsOptionSet("Number of results") Then request.NumberOfResults = GetOption("Number of results")
		  If IsOptionSet("Stop") Then request.Stop = GetOption("Stop")
		  If IsOptionSet("Temperature") Then request.Temperature = GetOption("Temperature")
		  If IsOptionSet("MaxTokens") Then request.MaxTokens = GetOption("MaxTokens")
		  If IsOptionSet("User") Then request.User = GetOption("User")
		  If Not IsOptionSet("Model") Then SetOption("Model") = OpenAI.Model.Lookup("gpt-4o")
		  request.Model = GetOption("Model")
		  
		  Dim chatlog As New OpenAI.ChatCompletionData()
		  Dim prmpt As String = GetOption("Prompt", "")
		  Dim url As String
		  If GetOption("Image URL", "") <> "" Then
		    url = GetOption("Image URL", "")
		  ElseIf GetOption("Image", Nil) <> Nil Then
		    Dim f As FolderItem = GetOption("Image")
		    Dim p As Picture = Picture.Open(f)
		    url = "data:image/png;base64," + EncodeBase64(p.GetData(Picture.FormatPNG))
		  Else
		    Raise New OpenAI.OpenAIException("No valid image specified.")
		  End If
		  chatlog.AddMessage("user", prmpt, url)
		  request.Messages = chatlog
		  
		  Return request
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetSpeechSynthRequest() As OpenAI.Request
		  Dim request As New OpenAI.Request
		  request.Model = GetOption("Model", OpenAI.Model.Lookup("tts-1"))
		  request.Input = GetOption("Input", "")
		  request.Voice = GetOption("Voice", "alloy")
		  If IsOptionSet("speed") Then request.Speed = GetOption("Speed")
		  Select Case GetOption("Response format", "")
		  Case "mp3", ""
		    request.ResultsAsMP3 = True
		  Case "opus"
		    request.ResultsAsOpus = True
		  Case "aac"
		    request.ResultsAsAAC = True
		  Case "flac"
		    request.ResultsAsFLAC = True
		  End Select
		  Return request
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetTranscriptionRequest() As OpenAI.Request
		  Dim request As New OpenAI.Request()
		  Dim bs As BinaryStream = BinaryStream.Open(mAudioFile)
		  request.File = bs.Read(bs.Length)
		  bs.Close
		  request.FileName = mAudioFile.Name
		  request.FileMIMEType = MIMEType(mAudioFile)
		  If IsOptionSet("Temperature") Then request.Temperature = GetOption("Temperature")
		  request.Model = GetOption("Model", OpenAI.Model.Lookup("whisper-1"))
		  Return request
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetTranslationRequest() As OpenAI.Request
		  Dim request As New OpenAI.Request()
		  Dim bs As BinaryStream = BinaryStream.Open(mAudioFile)
		  request.File = bs.Read(bs.Length)
		  bs.Close
		  request.FileName = mAudioFile.Name
		  request.FileMIMEType = MIMEType(mAudioFile)
		  If IsOptionSet("Temperature") Then request.Temperature = GetOption("Temperature")
		  request.Model = GetOption("Model", OpenAI.Model.Lookup("whisper-1"))
		  Return request
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function IsOptionSet(Name As String) As Boolean
		  Return mAPIOptions.HasKey(Name)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub LoadModels()
		  ModelList.DeleteAllRows()
		  For i As Integer = 0 To OpenAI.Model.Count - 1
		    Dim mdl As OpenAI.Model = OpenAI.Model.Lookup(i)
		    Dim usedfor As String
		    Select Case mdl.Endpoint
		    Case "/v1/audio/transcriptions;/v1/audio/translations"
		      usedfor = "Speech-to-Text"
		      
		    Case "/v1/chat/completions"
		      If InStr(mdl.ID, "vision") > 0 Then
		        usedfor = "Image recognition"
		      Else
		        usedfor = "Chat"
		      End If
		      
		    Case "/v1/completions"
		      usedfor = "Text completion"
		      Continue ' skip. deprecated
		      
		    Case "/v1/edits"
		      usedfor = "Text modification"
		      Continue ' skip. deprecated
		      
		    Case "/v1/fine-tunes"
		      usedfor = "Fine tuning"
		      
		    Case "/v1/embeddings"
		      usedfor = "Embeddings"
		      
		    Case "/v1/moderations"
		      usedfor = "Moderation"
		      
		    Case "/v1/images/generations"
		      usedfor = "Image generating"
		      
		    Case "/v1/audio/speech"
		      usedfor = "Text-to-Speech"
		      
		    Else
		      If mdl.ID.Left(3) = "ft:" Then
		        usedfor = "Custom"
		      Else
		        usedfor = "Deprecated"
		      End If
		      
		    End Select
		    ModelList.AddFolder(mdl.ID)
		    ModelList.Cell(ModelList.LastIndex, 1) = usedfor
		    ModelList.RowTag(ModelList.LastIndex) = mdl
		  Next
		  ModelList.ColumnsortDirection(0)=ListBox.SortAscending
		  ModelList.SortedColumn=0 //first column is the sort column
		  ModelList.Sort
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function MIMEType(File As FolderItem) As String
		  Static mime As Dictionary
		  If mime = Nil Then
		    mime = New Dictionary
		    Dim exts() As String = Split(UploadabeFileTypes.AudioFlac.Extensions, ";")
		    For Each e As String In exts
		      mime.Value(e) = "audio/flac"
		    Next
		    exts() = Split(UploadabeFileTypes.AudioMp4.Extensions, ";")
		    For Each e As String In exts
		      mime.Value(e) = "audio/mp4"
		    Next
		    exts() = Split(UploadabeFileTypes.AudioMpeg.Extensions, ";")
		    For Each e As String In exts
		      mime.Value(e) = "audio/mpeg"
		    Next
		    exts() = Split(UploadabeFileTypes.AudioXWav.Extensions, ";")
		    For Each e As String In exts
		      mime.Value(e) = "audio/x-wav"
		    Next
		    exts() = Split(UploadabeFileTypes.VideoMpeg.Extensions, ";")
		    For Each e As String In exts
		      mime.Value(e) = "video/mpeg"
		    Next
		    exts() = Split(UploadabeFileTypes.VideoWebm.Extensions, ";")
		    For Each e As String In exts
		      mime.Value(e) = "video/webm"
		    Next
		    exts() = Split(UploadabeFileTypes.Png.Extensions, ";")
		    For Each e As String In exts
		      mime.Value(e) = "image/png"
		    Next
		    exts() = Split(UploadabeFileTypes.Jpeg.Extensions, ";")
		    For Each e As String In exts
		      mime.Value(e) = "image/jpeg"
		    Next
		  End If
		  
		  Return mime.Lookup("." + NthField(File.Name, ".", CountFields(File.Name, ".")).Lowercase, "")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RunCreateImage(Sender As Thread)
		  #pragma Unused Sender
		  Dim request As OpenAI.Request = GetCreateImageRequest()
		  mAPIReply = OpenAI.Image.Create(request)
		  RefreshTimer.Mode = Timer.ModeSingle
		  
		Exception err As OpenAI.OpenAIException
		  mLastError = err
		  RefreshTimer.Mode = Timer.ModeSingle
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RunCreateImageVariation(Sender As Thread)
		  #pragma Unused Sender
		  Dim request As OpenAI.Request = GetCreateImageVariationRequest()
		  mAPIReply = OpenAI.Image.CreateVariation(request)
		  RefreshTimer.Mode = Timer.ModeSingle
		  
		Exception err As OpenAI.OpenAIException
		  mLastError = err
		  RefreshTimer.Mode = Timer.ModeSingle
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RunDoModeration(Sender As Thread)
		  #pragma Unused Sender
		  Dim request As OpenAI.Request = GetModerationRequest()
		  mAPIReply = OpenAI.Moderation.Create(request)
		  RefreshTimer.Mode = Timer.ModeSingle
		  
		Exception err As OpenAI.OpenAIException
		  mLastError = err
		  RefreshTimer.Mode = Timer.ModeSingle
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RunDoSpeechSynth(Sender As Thread)
		  #pragma Unused Sender
		  
		  Dim request As OpenAI.Request = GetSpeechSynthRequest()
		  mAPIReply = OpenAI.AudioGeneration.Create(request)
		  RefreshTimer.Mode = Timer.ModeSingle
		  
		Exception err As OpenAI.OpenAIException
		  mLastError = err
		  RefreshTimer.Mode = Timer.ModeSingle
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RunDoTranscription(Sender As Thread)
		  #pragma Unused Sender
		  Dim request As OpenAI.Request = GetTranscriptionRequest()
		  mAPIReply = OpenAI.AudioTranscription.Create(request)
		  RefreshTimer.Mode = Timer.ModeSingle
		  
		Exception err As OpenAI.OpenAIException
		  mLastError = err
		  RefreshTimer.Mode = Timer.ModeSingle
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RunDoTranslation(Sender As Thread)
		  #pragma Unused Sender
		  Dim request As OpenAI.Request = GetTranslationRequest()
		  mAPIReply = OpenAI.AudioTranslation.Create(request)
		  RefreshTimer.Mode = Timer.ModeSingle
		  
		Exception err As OpenAI.OpenAIException
		  mLastError = err
		  RefreshTimer.Mode = Timer.ModeSingle
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RunEditImage(Sender As Thread)
		  #pragma Unused Sender
		  Dim request As OpenAI.Request = GetEditImageRequest()
		  mAPIReply = OpenAI.Image.Edit(request)
		  RefreshTimer.Mode = Timer.ModeSingle
		  
		Exception err As OpenAI.OpenAIException
		  mLastError = err
		  RefreshTimer.Mode = Timer.ModeSingle
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RunRecognizeImage(Sender As Thread)
		  #pragma Unused Sender
		  Dim request As OpenAI.Request = GetRecognizeImageRequest()
		  mAPIReply = OpenAI.ImageRecognition.Create(request)
		  RefreshTimer.Mode = Timer.ModeSingle
		  
		Exception err As OpenAI.OpenAIException
		  mLastError = err
		  RefreshTimer.Mode = Timer.ModeSingle
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Shared Function Scale(Source As Picture, Ratio As Double = 1.0) As Picture
		  //Returns a scaled version of the passed Picture object.
		  //A ratio of 1.0 is 100% (no change,) 0.5 is 50% (half size) and so forth.
		  //This function should be cross-platform safe.
		  
		  Dim wRatio, hRatio As Double
		  wRatio = (Ratio * Source.width)
		  hRatio = (Ratio * Source.Height)
		  If wRatio = Source.Width And hRatio = Source.Height Then Return Source
		  #If RBVersion < 2016.04 Then
		    If Not App.UseGDIPlus Then App.UseGDIPlus = True
		  #endif
		  Dim photo As New Picture(wRatio, hRatio)
		  Photo.Graphics.DrawPicture(Source, 0, 0, Photo.Width, Photo.Height, 0, 0, Source.Width, Source.Height)
		  Return photo
		  
		Exception
		  Return Source
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SetOption(Name As String, Assigns Value As Variant)
		  If Name = "Prompt" And Value IsA OpenAI.Model Then Break
		  If Name = "Model" And Not Value IsA OpenAI.Model Then Break
		  mAPIOptions.Value(Name) = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ToggleLockUI()
		  OptionsListBox.Enabled = Not OptionsListBox.Enabled
		  TaskSelectMenu.Enabled = Not TaskSelectMenu.Enabled
		  PerformRequestBtn.Enabled = Not PerformRequestBtn.Enabled
		  DoAbortBtn.Visible = Not DoAbortBtn.Visible
		  RequestProgressBar.Visible = Not RequestProgressBar.Visible
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mAPIImage As Picture
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mAPIOptions As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mAPIReply As OpenAI.Response
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mAudioFile As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastError As OpenAI.OpenAIException
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastPointer As MouseCursor
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mModelListHasFocus As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOptionListHasFocus As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mScale As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mWorker As Thread
	#tag EndProperty


#tag EndWindowCode

#tag Events ReplyText
	#tag Event
		Function ConstructContextualMenu(base as MenuItem, x as Integer, y as Integer) As Boolean
		  #pragma Unused x
		  #pragma Unused y
		  If Me.Text <> "" And mAPIReply <> Nil Then
		    Dim serialize As New MenuItem("Dump to file...")
		    serialize.Tag = mAPIReply
		    base.Append(serialize)
		    Return True
		  End If
		End Function
	#tag EndEvent
	#tag Event
		Function ContextualMenuAction(hitItem as MenuItem) As Boolean
		  Select Case hitItem.Text
		  Case "Dump to file..."
		    Dim f As FolderItem = GetSaveFolderItem(".json", mAPIReply.ID + ".json")
		    If f <> Nil Then
		      Dim s As String = mAPIReply.ToString()
		      Dim bs As BinaryStream = BinaryStream.Create(f)
		      bs.Write(s)
		      bs.Close()
		    End If
		  End Select
		  
		  Return True
		  
		End Function
	#tag EndEvent
	#tag Event
		Sub ClickLink(LinkText As String, LinkValue As Variant)
		  #pragma Unused LinkText
		  If VarType(LinkValue) = Variant.TypeString Then ShowURL(LinkValue.StringValue)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ReplyImageCanvas
	#tag Event
		Function ConstructContextualMenu(base as MenuItem, x as Integer, y as Integer) As Boolean
		  #pragma Unused x
		  #pragma Unused y
		  
		  If mAPIImage <> Nil Then
		    base.Append(New MenuItem("Save picture..."))
		    base.Append(New MenuItem("Dump to file..."))
		    Dim scle As New MenuItem("Scale preview")
		    scle.Checked = mScale
		    base.Append(scle)
		    Return True
		  End If
		  
		End Function
	#tag EndEvent
	#tag Event
		Function ContextualMenuAction(hitItem as MenuItem) As Boolean
		  Select Case hitItem.Text
		  Case "Save picture..."
		    If mAPIImage <> Nil Then
		      Dim out As FolderItem = GetSaveFolderItem("", "output.png")
		      If out <> Nil Then mAPIImage.Save(out, Picture.SaveAsPNG)
		      Return True
		    End If
		    
		  Case "Scale preview"
		    mScale = Not mScale
		    Me.Invalidate(True)
		    Return True
		    
		  Case "Dump to file..."
		    Dim f As FolderItem = GetSaveFolderItem(".json", mAPIReply.ID + ".json")
		    If f <> Nil Then
		      Dim s As String = mAPIReply.ToString()
		      Dim bs As BinaryStream = BinaryStream.Create(f)
		      bs.Write(s)
		      bs.Close()
		    End If
		    Return True
		    
		  End Select
		  
		End Function
	#tag EndEvent
	#tag Event
		Sub Paint(g As Graphics)
		  #If RBVersion > 2012.01 Then
		    #pragma Unused areas
		  #endif
		  If g.Width <= 0 Or g.Height <= 0 Then Return
		  If mAPIImage <> Nil Then
		    Dim ratio As Double = 1.0
		    If g.Width < mAPIImage.Width Then ratio = g.Width / mAPIImage.Width
		    If g.Height < mAPIImage.Height Then ratio = Min(g.Height / mAPIImage.Height, ratio)
		    Dim p As Picture = transparencycheckerboard
		    For i As Integer = 0 To g.Width Step p.Width
		      For j As Integer = 0 To g.Height Step p.Height
		        g.DrawPicture(p, i, j)
		      Next
		    Next
		    Dim scaled As Picture
		    If mScale Then
		      scaled = Scale(mAPIImage, ratio)
		    Else
		      scaled = mAPIImage
		    End If
		    g.DrawPicture(scaled, (g.Width - scaled.Width) / 2, (g.Height - scaled.Height) / 2)
		  Else
		    Dim s As String = "No image data"
		    g.ForeColor = &cC0C0C000
		    g.FillRect(0, 0, g.Width, g.Height)
		    g.ForeColor = &c00000000
		    g.TextSize = 15
		    Dim w, h As Integer
		    w = g.StringWidth(s)
		    h = g.StringHeight(s, w)
		    w = (g.Width - w) / 2
		    h = (g.Height - h) / 2
		    g.DrawString(s, w, h)
		  End If
		  g.ForeColor = &c80808000
		  g.DrawRect(0, 0, g.Width, g.Height)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ModelList
	#tag Event
		Sub Change()
		  If Me.ListIndex < 0 Then Return
		  Dim mdl As OpenAI.Model = Me.RowTag(Me.ListIndex)
		  If mdl <> Nil Then
		    SetOption("Model") = mdl
		    For i As Integer = 0 To OptionsListBox.ListCount - 1
		      If OptionsListBox.Cell(i, 0) = "Model" Then
		        OptionsListBox.Cell(i, 1) = mdl.ID
		        OptionsListBox.CellTag(i, 1) = mdl
		        Exit For
		      End If
		    Next
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Function KeyDown(Key As String) As Boolean
		  If Asc(Key) = &h0D And Me.ListIndex > -1 Then
		    Dim mdl As OpenAI.Model = Me.RowTag(Me.ListIndex)
		    If mdl <> Nil Then Me.Expanded(Me.ListIndex) = Not Me.Expanded(Me.ListIndex)
		    Return True
		  End If
		End Function
	#tag EndEvent
	#tag Event
		Function ConstructContextualMenu(base as MenuItem, x as Integer, y as Integer) As Boolean
		  Dim row As Integer = Me.RowFromXY(x, y)
		  If row > -1 And Me.RowTag(row) <> Nil Then
		    Dim serialize As New MenuItem("Dump to file...")
		    serialize.Tag = Me.RowTag(row)
		    base.Append(serialize)
		    Return True
		  End If
		End Function
	#tag EndEvent
	#tag Event
		Function ContextualMenuAction(hitItem as MenuItem) As Boolean
		  Select Case hitItem.Text
		  Case "Dump to file..."
		    Dim mdl As OpenAI.Model = hitItem.Tag
		    Dim f As FolderItem = GetSaveFolderItem(".json", mdl.ID + ".json")
		    If f <> Nil Then
		      Dim s As String = mdl.ToString()
		      Dim bs As BinaryStream = BinaryStream.Create(f)
		      bs.Write(s)
		      bs.Close()
		    End If
		  End Select
		  
		  Return True
		  
		End Function
	#tag EndEvent
	#tag Event
		Sub ExpandRow(row As Integer)
		  Dim mdl As OpenAI.Model = Me.RowTag(row)
		  If mdl <> Nil Then
		    Dim props() As Introspection.PropertyInfo = Introspection.GetType(mdl).GetProperties()
		    For i As Integer = 0 To UBound(props)
		      If props(i).IsPublic Then
		        Try
		          Dim vle As Variant = props(i).Value(mdl)
		          Me.InsertRow(row + 1, props(i).Name, 1)
		          If vle IsA OpenAI.Model Then
		            Dim modl As OpenAI.Model = vle
		            Me.Cell(Me.LastIndex, 1) = modl.ID
		          Else
		            Me.Cell(Me.LastIndex, 1) = vle.StringValue
		          End If
		        Catch
		        End Try
		      End If
		    Next
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub DoubleClick()
		  Me.Expanded(Me.ListIndex) = Not Me.Expanded(Me.ListIndex)
		End Sub
	#tag EndEvent
	#tag Event
		Function CellTextPaint(g As Graphics, row As Integer, column As Integer, x as Integer, y as Integer) As Boolean
		  If Me.Selected(row) And (Me.RowTag(row) <> Nil) Then
		    g.ForeColor = &cFFFFFF00
		    g.DrawString(Me.Cell(row, column), x, y)
		    Return True
		  End If
		End Function
	#tag EndEvent
	#tag Event
		Sub GotFocus()
		  mModelListHasFocus = True
		End Sub
	#tag EndEvent
	#tag Event
		Sub LostFocus()
		  mModelListHasFocus = False
		End Sub
	#tag EndEvent
	#tag Event
		Function CellBackgroundPaint(g As Graphics, row As Integer, column As Integer) As Boolean
		  Dim start, stop As Color
		  If row > Me.ListCount - 1 Then Return False
		  ' If Me.RowTag(row) <> Nil Or Me.Cell(row, 0) = "Automatic" Then
		  If Me.Selected(row) Then
		    If mModelListHasFocus Then
		      start = &c0080C000
		      stop = &c7DBEFF00
		    Else
		      start = &c80808000
		      stop = &cC0C0C000
		    End If
		    FillGradient(g, start, stop)
		    If mModelListHasFocus Then
		      g.ForeColor = &c0080FF00
		    Else
		      g.ForeColor = &c80808000
		    End If
		    If column = 0 Then
		      g.DrawRect(0, 0, g.Width + 1, g.Height)
		    Else
		      g.DrawRect(-1, 0, g.Width - 2, g.Height)
		    End If
		  End If
		  Return True
		  ' Else
		  ' g.ForeColor = &cC0C0C000
		  ' g.FillRect(0, 0, g.Width, g.Height)
		  ' Return False
		  ' End If
		  
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events OptionsListBox
	#tag Event
		Sub CellAction(row As Integer, column As Integer)
		  Select Case Me.Cell(row, 0)
		  Case "Prompt", "Quality", "Size", "Style", "User", "Stop", "Input", "Voice", "Response format", "Language", "Image URL"
		    SetOption(Me.Cell(row, 0)) = Me.Cell(row, column)
		  Case "Number of results", "MaxTokens"
		    SetOption(Me.Cell(row, 0)) = Val(Me.Cell(row, column))
		  Case "ResponseAsURL"
		    SetOption("ResponseAsURL") = (Me.CellState(row, column) = CheckBox.CheckedStates.Checked)
		  Case "Temperature"
		    SetOption("Temperature") = CDbl(Me.Cell(row, column))
		  Case "File"
		    SetOption("File") = GetFolderItem(Me.Cell(row, column))
		  Case "Image"
		    SetOption("Image") = GetFolderItem(Me.Cell(row, column))
		  Case "Model"
		    Dim m As OpenAI.Model = OpenAI.Model.Lookup(Me.Cell(row, column))
		    SetOption("Model") = m
		  End Select
		End Sub
	#tag EndEvent
	#tag Event
		Function CellClick(row as Integer, column as Integer, x as Integer, y as Integer) As Boolean
		  #pragma Unused x
		  #pragma Unused y
		  If column <> 1 Then Return False
		  Dim s As String = Me.Cell(row, 0)
		  Select Case s
		  Case "File"
		    Dim f As FolderItem = GetOpenFolderItem(UploadabeFileTypes.All)
		    If f = Nil Then Return False
		    #If RBVersion > 2019 Then
		      Me.Cell(row, column) = f.NativePath
		    #Else
		      Me.Cell(row, column) = f.AbsolutePath
		    #endif
		    SetOption("File") = f
		    Return True
		    
		  Case "Image"
		    Dim f As FolderItem = GetOpenFolderItem(UploadabeFileTypes.AllImageTypes)
		    If f = Nil Then Return False
		    #If RBVersion > 2019 Then
		      Me.Cell(row, column) = f.NativePath
		    #Else
		      Me.Cell(row, column) = f.AbsolutePath
		    #endif
		    SetOption("Image") = f
		    Return True
		    
		  Case "Mask"
		    Dim f As FolderItem = GetOpenFolderItem(UploadabeFileTypes.AllImageTypes)
		    If f = Nil Then Return False
		    #If RBVersion > 2019 Then
		      Me.Cell(row, column) = f.NativePath
		    #Else
		      Me.Cell(row, column) = f.AbsolutePath
		    #endif
		    SetOption("Mask") = f
		    Return True
		    
		  End Select
		End Function
	#tag EndEvent
	#tag Event
		Function CellTextPaint(g As Graphics, row As Integer, column As Integer, x as Integer, y as Integer) As Boolean
		  If Me.RowTag(row) = True Then g.Bold = True
		  
		  If Me.Selected(row) Then
		    g.ForeColor = &cFFFFFF00
		    g.DrawString(Me.Cell(row, column), x, y)
		    Return True
		  End If
		End Function
	#tag EndEvent
	#tag Event
		Function CellBackgroundPaint(g As Graphics, row As Integer, column As Integer) As Boolean
		  Dim start, stop As Color
		  If row > Me.ListCount - 1 Then Return False
		  If Me.Selected(row) Then
		    If mOptionListHasFocus Then
		      start = &c0080C000
		      stop = &c7DBEFF00
		    Else
		      start = &c80808000
		      stop = &cC0C0C000
		    End If
		    FillGradient(g, start, stop)
		    If mOptionListHasFocus Then
		      g.ForeColor = &c0080FF00
		    Else
		      g.ForeColor = &c80808000
		    End If
		    If column = 0 Then
		      g.DrawRect(0, 0, g.Width + 1, g.Height)
		    Else
		      g.DrawRect(-1, 0, g.Width - 2, g.Height)
		    End If
		  End If
		  Return True
		End Function
	#tag EndEvent
	#tag Event
		Sub LostFocus()
		  mOptionListHasFocus = False
		End Sub
	#tag EndEvent
	#tag Event
		Sub GotFocus()
		  mOptionListHasFocus = True
		End Sub
	#tag EndEvent
	#tag Event
		Function ContextualMenuAction(hitItem as MenuItem) As Boolean
		  If hitItem.Text = "Dump to file..." Then
		    Dim request As OpenAI.Request
		    Dim nm As String
		    Select Case TaskSelectMenu.Text
		    Case "Images: Generate"
		      nm = "image_generation_request.json"
		      request = GetCreateImageRequest()
		    Case "Images: Generate variation"
		      nm = "image_generation_request.json"
		      request = GetCreateImageVariationRequest()
		    Case "Images: Modify"
		      nm = "image_edit_request.json"
		      request = GetEditImageRequest()
		    Case "Images: Recognize"
		      nm = "image_recognition_request.json"
		      request = GetRecognizeImageRequest()
		    Case "Text: Categorize for sex, violence, etc."
		      nm = "moderation_request.json"
		      request = GetModerationRequest()
		    Case "Audio: Synthesize speech"
		      nm = "texttospeech_request.json"
		      request = GetSpeechSynthRequest()
		    Case "Audio: Transcribe English audio"
		      nm = "transcription_request.json"
		      request = GetTranscriptionRequest()
		    Case "Audio: Translate audio to English text"
		      nm = "translation_request.json"
		      request = GetTranslationRequest()
		    End Select
		    If request = Nil Then Return True
		    Dim f As FolderItem = GetSaveFolderItem(".json", nm)
		    If f = Nil Then Return True
		    Dim bs As BinaryStream = BinaryStream.Create(f, True)
		    Dim reqjs As JSONItem = request
		    bs.Write(reqjs.ToString)
		    bs.Close
		    Return True
		  End If
		  
		End Function
	#tag EndEvent
	#tag Event
		Function ConstructContextualMenu(base as MenuItem, x as Integer, y as Integer) As Boolean
		  #pragma Unused x
		  #pragma Unused y
		  If TaskSelectMenu.Text <> "Select AI task..." And TaskSelectMenu.Text <> "Text: Chat" Then
		    Dim serialize As New MenuItem("Dump to file...")
		    base.Append(serialize)
		    Return True
		  End If
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events TaskSelectMenu
	#tag Event
		Sub Change()
		  If Me.Text = "Select AI Task..." Then Return
		  OptionsListBox.DeleteAllRows
		  Dim m As OpenAI.Model
		  If IsOptionSet("Model") Then m = GetOption("Model", Nil)
		  mAPIOptions = New Dictionary
		  If m <> Nil Then SetOption("Model") = m
		  Select Case Me.Text
		  Case "Images: Generate"
		    OptionsListBox.AddRow("Prompt", "")
		    OptionsListBox.RowTag(OptionsListBox.LastIndex) = True ' required
		    OptionsListBox.CellType(OptionsListBox.LastIndex, 1) = Listbox.TypeEditable
		    SetOption("Prompt") = ""
		    
		    OptionsListBox.AddRow("Number of results", "1")
		    OptionsListBox.RowTag(OptionsListBox.LastIndex) = False ' optional
		    OptionsListBox.CellType(OptionsListBox.LastIndex, 1) = Listbox.TypeEditable
		    
		    OptionsListBox.AddRow("Quality", "standard")
		    OptionsListBox.RowTag(OptionsListBox.LastIndex) = False ' optional
		    OptionsListBox.CellType(OptionsListBox.LastIndex, 1) = Listbox.TypeEditable
		    
		    OptionsListBox.AddRow("ResponseAsURL", "")
		    OptionsListBox.RowTag(OptionsListBox.LastIndex) = False ' optional
		    OptionsListBox.CellType(OptionsListBox.LastIndex, 1) = Listbox.TypeCheckbox
		    OptionsListBox.CellState(OptionsListBox.LastIndex, 1) = CheckBox.CheckedStates.Checked
		    SetOption(OptionsListBox.Cell(OptionsListBox.LastIndex, 0)) = OptionsListBox.CellTag(OptionsListBox.LastIndex, 1)
		    SetOption("ResponseAsURL") = True
		    
		    OptionsListBox.AddRow("Size", "1024x1024")
		    OptionsListBox.RowTag(OptionsListBox.LastIndex) = False ' optional
		    OptionsListBox.CellType(OptionsListBox.LastIndex, 1) = Listbox.TypeEditable
		    
		    OptionsListBox.AddRow("Style", "vivid")
		    OptionsListBox.RowTag(OptionsListBox.LastIndex) = False ' optional
		    OptionsListBox.CellType(OptionsListBox.LastIndex, 1) = Listbox.TypeEditable
		    
		  Case "Images: Modify"
		    OptionsListBox.AddRow("Image", "")
		    OptionsListBox.RowTag(OptionsListBox.LastIndex) = True ' required
		    OptionsListBox.AddRow("Mask", "")
		    OptionsListBox.RowTag(OptionsListBox.LastIndex) = False ' optional
		    
		    OptionsListBox.AddRow("Prompt", "")
		    OptionsListBox.RowTag(OptionsListBox.LastIndex) = True ' required
		    OptionsListBox.CellType(OptionsListBox.LastIndex, 1) = Listbox.TypeEditable
		    SetOption("Prompt") = ""
		    
		    OptionsListBox.AddRow("Number of results", "1")
		    OptionsListBox.RowTag(OptionsListBox.LastIndex) = False ' optional
		    OptionsListBox.CellType(OptionsListBox.LastIndex, 1) = Listbox.TypeEditable
		    
		    OptionsListBox.AddRow("ResponseAsURL", "")
		    OptionsListBox.RowTag(OptionsListBox.LastIndex) = False ' optional
		    OptionsListBox.CellType(OptionsListBox.LastIndex, 1) = Listbox.TypeCheckbox
		    OptionsListBox.CellState(OptionsListBox.LastIndex, 1) = CheckBox.CheckedStates.Checked
		    SetOption(OptionsListBox.Cell(OptionsListBox.LastIndex, 0)) = OptionsListBox.CellTag(OptionsListBox.LastIndex, 1)
		    SetOption("ResponseAsURL") = True
		    
		    OptionsListBox.AddRow("Size", "1024x1024")
		    OptionsListBox.RowTag(OptionsListBox.LastIndex) = False ' optional
		    OptionsListBox.CellType(OptionsListBox.LastIndex, 1) = Listbox.TypeEditable
		    
		  Case "Images: Generate variation"
		    OptionsListBox.AddRow("Image", "")
		    OptionsListBox.RowTag(OptionsListBox.LastIndex) = True ' required
		    
		    OptionsListBox.AddRow("Number of results", "1")
		    OptionsListBox.RowTag(OptionsListBox.LastIndex) = False ' optional
		    OptionsListBox.CellType(OptionsListBox.LastIndex, 1) = Listbox.TypeEditable
		    
		    OptionsListBox.AddRow("ResponseAsURL", "")
		    OptionsListBox.RowTag(OptionsListBox.LastIndex) = False ' optional
		    OptionsListBox.CellType(OptionsListBox.LastIndex, 1) = Listbox.TypeCheckbox
		    OptionsListBox.CellState(OptionsListBox.LastIndex, 1) = CheckBox.CheckedStates.Checked
		    SetOption(OptionsListBox.Cell(OptionsListBox.LastIndex, 0)) = OptionsListBox.CellTag(OptionsListBox.LastIndex, 1)
		    SetOption("ResponseAsURL") = True
		    
		    OptionsListBox.AddRow("Size", "1024x1024")
		    OptionsListBox.RowTag(OptionsListBox.LastIndex) = False ' optional
		    OptionsListBox.CellType(OptionsListBox.LastIndex, 1) = Listbox.TypeEditable
		    
		  Case "Images: Recognize"
		    OptionsListBox.AddRow("Image", "")
		    OptionsListBox.RowTag(OptionsListBox.LastIndex) = True ' required
		    
		    OptionsListBox.AddRow("Image URL", "")
		    OptionsListBox.CellType(OptionsListBox.LastIndex, 1) = Listbox.TypeEditable
		    SetOption("Image URL") = ""
		    OptionsListBox.RowTag(OptionsListBox.LastIndex) = True ' required
		    
		    OptionsListBox.AddRow("Prompt", "")
		    OptionsListBox.RowTag(OptionsListBox.LastIndex) = True ' required
		    OptionsListBox.CellType(OptionsListBox.LastIndex, 1) = Listbox.TypeEditable
		    SetOption("Prompt") = ""
		    
		    OptionsListBox.AddRow("MaxTokens", "1024")
		    OptionsListBox.RowTag(OptionsListBox.LastIndex) = False ' optional
		    OptionsListBox.CellType(OptionsListBox.LastIndex, 1) = Listbox.TypeEditable
		    SetOption("MaxTokens") = 1024
		    
		    OptionsListBox.AddRow("Number of results", "1")
		    OptionsListBox.RowTag(OptionsListBox.LastIndex) = False ' optional
		    OptionsListBox.CellType(OptionsListBox.LastIndex, 1) = Listbox.TypeEditable
		    
		    OptionsListBox.AddRow("Stop", "")
		    OptionsListBox.RowTag(OptionsListBox.LastIndex) = False ' optional
		    OptionsListBox.CellType(OptionsListBox.LastIndex, 1) = Listbox.TypeEditable
		    
		    OptionsListBox.AddRow("Temperature", "1.0")
		    OptionsListBox.RowTag(OptionsListBox.LastIndex) = False ' optional
		    OptionsListBox.CellType(OptionsListBox.LastIndex, 1) = Listbox.TypeEditable
		    
		  Case "Text: Categorize for sex, violence, etc."
		    OptionsListBox.AddRow("Input", "")
		    OptionsListBox.RowTag(OptionsListBox.LastIndex) = True ' required
		    OptionsListBox.CellType(OptionsListBox.LastIndex, 1) = Listbox.TypeEditable
		    SetOption("Input") = ""
		    
		  Case "Audio: Synthesize speech"
		    OptionsListBox.AddRow("Input", "")
		    OptionsListBox.RowTag(OptionsListBox.LastIndex) = True ' required
		    OptionsListBox.CellType(OptionsListBox.LastIndex, 1) = Listbox.TypeEditable
		    SetOption("Input") = ""
		    
		    OptionsListBox.AddRow("Voice", "alloy")
		    OptionsListBox.RowTag(OptionsListBox.LastIndex) = False ' optional
		    OptionsListBox.CellType(OptionsListBox.LastIndex, 1) = Listbox.TypeEditable
		    SetOption("Voice") = "alloy"
		    
		    OptionsListBox.AddRow("Response format", "mp3")
		    OptionsListBox.RowTag(OptionsListBox.LastIndex) = True ' required
		    OptionsListBox.CellType(OptionsListBox.LastIndex, 1) = Listbox.TypeEditable
		    SetOption("Response format") = "mp3"
		    
		  Case "Audio: Transcribe English audio", "Audio: Translate audio to English text"
		    OptionsListBox.AddRow("File", "")
		    OptionsListBox.RowTag(OptionsListBox.LastIndex) = True ' required
		    OptionsListBox.CellType(OptionsListBox.LastIndex, 1) = Listbox.TypeEditable
		    
		    OptionsListBox.AddRow("Language", "")
		    OptionsListBox.RowTag(OptionsListBox.LastIndex) = False ' optional
		    OptionsListBox.CellType(OptionsListBox.LastIndex, 1) = Listbox.TypeEditable
		    
		    OptionsListBox.AddRow("Prompt", "")
		    OptionsListBox.RowTag(OptionsListBox.LastIndex) = False ' optional
		    OptionsListBox.CellType(OptionsListBox.LastIndex, 1) = Listbox.TypeEditable
		    
		    OptionsListBox.AddRow("Temperature", "1.0")
		    OptionsListBox.RowTag(OptionsListBox.LastIndex) = False ' optional
		    OptionsListBox.CellType(OptionsListBox.LastIndex, 1) = Listbox.TypeEditable
		    
		  Case "Text: Chat"
		    OptionsListBox.AddRow("", "Select a model and click ""Go""")
		    Return
		    ' OptionsListBox.AddRow("Prompt", "")
		    ' OptionsListBox.CellType(OptionsListBox.LastIndex, 1) = Listbox.TypeEditable
		    ' SetOption("Prompt") = ""
		    '
		    ' OptionsListBox.AddRow("MaxTokens", "1024")
		    ' OptionsListBox.CellType(OptionsListBox.LastIndex, 1) = Listbox.TypeEditable
		    ' SetOption("MaxTokens") = 1024
		    '
		    ' OptionsListBox.AddRow("Number of results", "1")
		    ' OptionsListBox.CellType(OptionsListBox.LastIndex, 1) = Listbox.TypeEditable
		    '
		    ' OptionsListBox.AddRow("Stop", "")
		    ' OptionsListBox.CellType(OptionsListBox.LastIndex, 1) = Listbox.TypeEditable
		    '
		    ' OptionsListBox.AddRow("Temperature", "1.0")
		    ' OptionsListBox.CellType(OptionsListBox.LastIndex, 1) = Listbox.TypeEditable
		    
		  Else
		    Return
		  End Select
		  
		  OptionsListBox.AddRow("User", "")
		  OptionsListBox.RowTag(OptionsListBox.LastIndex) = False ' optional
		  OptionsListBox.CellType(OptionsListBox.LastIndex, 1) = Listbox.TypeEditable
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PerformRequestBtn
	#tag Event
		Sub Action()
		  If TaskSelectMenu.Text = "Select AI Task..." Then Return
		  If Not IsOptionSet("Model") Then
		    For i As Integer = 0 To ModelList.ListCount - 1
		      If ModelList.Selected(i) Then
		        Dim m As OpenAI.Model = ModelList.RowTag(i)
		        If m <> Nil Then SetOption("Model") = m
		        Exit For
		      End If
		    Next
		    If Not IsOptionSet("Model") Then
		      Call MsgBox("You must select an AI model from the list.", 16, "Missing parameter")
		      Return
		    End If
		  End If
		  Select Case TaskSelectMenu.Text
		  Case "Images: Generate"
		    StatusBarLbl.Text = "Working..."
		    ToggleLockUI()
		    mWorker = New Thread
		    AddHandler mWorker.Run, WeakAddressOf RunCreateImage
		    mWorker.Priority = 3
		    mWorker.Run()
		    
		  Case "Images: Modify"
		    StatusBarLbl.Text = "Working..."
		    ToggleLockUI()
		    mWorker = New Thread
		    AddHandler mWorker.Run, WeakAddressOf RunEditImage
		    mWorker.Priority = 3
		    mWorker.Run()
		    
		  Case "Images: Generate variation"
		    StatusBarLbl.Text = "Working..."
		    ToggleLockUI()
		    mWorker = New Thread
		    AddHandler mWorker.Run, WeakAddressOf RunCreateImageVariation
		    mWorker.Priority = 3
		    mWorker.Run()
		    
		  Case "Images: Recognize"
		    StatusBarLbl.Text = "Working..."
		    ToggleLockUI()
		    mWorker = New Thread
		    AddHandler mWorker.Run, WeakAddressOf RunRecognizeImage
		    mWorker.Priority = 3
		    mWorker.Run()
		    
		  Case "Text: Categorize for sex, violence, etc."
		    StatusBarLbl.Text = "Working..."
		    ToggleLockUI()
		    mWorker = New Thread
		    AddHandler mWorker.Run, WeakAddressOf RunDoModeration
		    mWorker.Priority = 3
		    mWorker.Run()
		    
		    
		  Case "Audio: Synthesize speech"
		    mAudioFile = GetSaveFolderItem(UploadabeFileTypes.All, "output." + GetOption("Response format", "mp3"))
		    If mAudioFile = Nil Then Return
		    StatusBarLbl.Text = "Working..."
		    ToggleLockUI()
		    mWorker = New Thread
		    AddHandler mWorker.Run, WeakAddressOf RunDoSpeechSynth
		    mWorker.Priority = 3
		    mWorker.Run()
		    
		  Case "Audio: Transcribe English audio"
		    mAudioFile = GetOption("File")
		    If mAudioFile = Nil Or Not mAudioFile.Exists Or mAudioFile.Directory Then Return
		    StatusBarLbl.Text = "Working..."
		    ToggleLockUI()
		    mWorker = New Thread
		    AddHandler mWorker.Run, WeakAddressOf RunDoTranscription
		    mWorker.Priority = 3
		    mWorker.Run()
		    
		  Case "Audio: Translate audio to English text"
		    mAudioFile = GetOption("File")
		    If mAudioFile = Nil Or Not mAudioFile.Exists Or mAudioFile.Directory Then Return
		    StatusBarLbl.Text = "Working..."
		    ToggleLockUI()
		    mWorker = New Thread
		    AddHandler mWorker.Run, WeakAddressOf RunDoTranslation
		    mWorker.Priority = 3
		    mWorker.Run()
		    
		  Case "Text: Chat"
		    Dim m As OpenAI.Model = GetOption("Model", OpenAI.Model.Lookup("gpt-4"))
		    Dim chatwnd As New ChatWindow(m)
		    chatwnd.Show()
		  End Select
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events DoAbortBtn
	#tag Event
		Sub Action()
		  If mWorker = Nil Then Return
		  If MsgBox("Abort this request?", 4 + 48, "Confirm abort") <> 6 Then Return
		  mWorker.Kill()
		  StatusBarLbl.Text = "Aborted"
		  OptionsListBox.Enabled = True
		  TaskSelectMenu.Enabled = True
		  PerformRequestBtn.Enabled = True
		  mWorker = Nil
		  ReplyText.Text = "Aborted by user."
		  Me.Visible = False
		  RequestProgressBar.Visible = False
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SetAPIKeyBtn
	#tag Event
		Sub Action()
		  If APIKeyField.Text = "" Then
		    MsgBox("Please enter your OpenAI API key to begin.")
		    Return
		  End If
		  StatusBarLbl.Text = "Working..."
		  OpenAI.APIKey = APIKeyField.Text
		  Try
		    Call OpenAI.Model.Count()
		  Catch err As OpenAI.OpenAIException
		    Call MsgBox(err.Message, 16, "Key Rejected")
		    OpenAI.APIKey = ""
		    StatusBarLbl.Text = "Waiting for API key"
		    Return
		  End Try
		  
		  LoadModels()
		  OpenAIGroup.Enabled = True
		  APIKeyLbl.Enabled = False
		  APIKeyField.Enabled = False
		  Me.Enabled = False
		  StatusBarLbl.Text = "Ready"
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events RefreshTimer
	#tag Event
		Sub Action()
		  ReplyText.Clear()
		  If mLastError <> Nil Then ' an error occurred
		    mAPIImage = Nil
		    mAPIReply = Nil
		    ReplyText.Text = mLastError.Message
		    Call MsgBox("OpenAI rejected the request.", 16, "API Error")
		    mLastError = Nil
		    StatusBarLbl.Text = "Error"
		  Else
		    Select Case mAPIReply.ResultType
		    Case OpenAI.ResultType.String
		      mAPIImage = Nil
		      ReplyText.Text = ""
		      For i As Integer = 0 To mAPIReply.ResultCount - 1
		        Dim s As String = Trim(mAPIReply.GetResult(i))
		        ReplyText.Text = ReplyText.Text + "[result #" + Str(i + 1) + "]" + EndOfLine + s + EndOfLine + EndOfLine
		      Next
		    Case OpenAI.ResultType.JSONObject
		      mAPIImage = Nil
		      Dim js As JSONItem = mAPIReply.GetResult
		      js.Compact = False
		      ReplyText.Text = RTrim(js.ToString)
		      
		    Case OpenAI.ResultType.Picture
		      ReplyText.Text = mAPIReply.RevisedPrompt
		      mAPIImage = mAPIReply.GetResult
		      
		    Case OpenAI.ResultType.PictureURL
		      Dim url As String = Trim(mAPIReply.GetResult)
		      ReplyText.AppendText("URL: ")
		      ReplyText.AppendLink(url, url)
		      If mAPIReply.RevisedPrompt <> "" Then ReplyText.AppendText(EndOfLine + EndOfLine + "Revised prompt: " + mAPIReply.RevisedPrompt)
		      mAPIImage = FetchImageURL(url)
		      
		    Case OpenAI.ResultType.Audio
		      ReplyText.Text = ""
		      Dim bs As BinaryStream
		      Try
		        bs = BinaryStream.Create(mAudioFile)
		        bs.Write(mAPIReply.GetResult(0).StringValue)
		        bs.Close
		      Catch
		        Call MsgBox("Unable to save audio!", 16, "Save error")
		        Return
		      End Try
		      Call MsgBox("Audio file saved to '" + mAudioFile.Name + "'", 64, "Operation complete")
		    End Select
		    StatusBarLbl.Text = "Ready"
		  End If
		  
		  ReplyImageCanvas.Invalidate(True)
		  ToggleLockUI()
		  If mAPIReply <> Nil Then
		    Dim finres As String = mAPIReply.FinishReason
		    If finres = "" Then
		      StatusBarLbl.Text = "Complete."
		    Else
		      StatusBarLbl.Text = "Complete. Finish reason:" + mAPIReply.FinishReason
		    End If
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events URLLbl
	#tag Event
		Sub MouseUp(X As Integer, Y As Integer)
		  #pragma Unused X
		  #pragma Unused Y
		  ShowURL("https://github.com/charonn0/Xojo-OpenAI")
		End Sub
	#tag EndEvent
	#tag Event
		Function MouseDown(X As Integer, Y As Integer) As Boolean
		  #pragma Unused X
		  #pragma Unused Y
		  Return True
		End Function
	#tag EndEvent
	#tag Event
		Sub MouseEnter()
		  mLastPointer = Me.MouseCursor
		  Me.MouseCursor = System.Cursors.FingerPointer
		  Me.TextColor = &c0080FF00
		  Me.Underline = False
		End Sub
	#tag EndEvent
	#tag Event
		Sub MouseExit()
		  Me.MouseCursor = mLastPointer
		  Me.TextColor = &c0000FF00
		  Me.Underline = True
		End Sub
	#tag EndEvent
#tag EndEvents
