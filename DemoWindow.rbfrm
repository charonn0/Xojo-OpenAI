#tag Window
Begin Window DemoWindow
   BackColor       =   "&cFFFFFF00"
   Backdrop        =   0
   CloseButton     =   True
   Composite       =   False
   Frame           =   0
   FullScreen      =   False
   HasBackColor    =   False
   Height          =   700
   ImplicitInstance=   True
   LiveResize      =   True
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   True
   MaxWidth        =   32000
   MenuBar         =   0
   MenuBarVisible  =   True
   MinHeight       =   64
   MinimizeButton  =   True
   MinWidth        =   64
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
      Height          =   649
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
      TabIndex        =   0
      TabPanelIndex   =   0
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   42
      Underline       =   False
      Visible         =   True
      Width           =   883
      Begin TextArea PromptText
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
         Height          =   91
         HelpTag         =   ""
         HideSelection   =   True
         Index           =   -2147483648
         InitialParent   =   "OpenAIGroup"
         Italic          =   False
         Left            =   36
         LimitText       =   0
         LockBottom      =   False
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
         TabIndex        =   0
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   ""
         TextColor       =   "&c00000000"
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   99
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   300
      End
      Begin Label Label2
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
         Left            =   46
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   0
         Selectable      =   False
         TabIndex        =   1
         TabPanelIndex   =   0
         Text            =   "Prompt/Input:"
         TextAlign       =   0
         TextColor       =   "&c00000000"
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   75
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   186
      End
      Begin Label Label3
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
         Left            =   591
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   0
         Selectable      =   False
         TabIndex        =   2
         TabPanelIndex   =   0
         Text            =   "Reply/Output:"
         TextAlign       =   0
         TextColor       =   "&c00000000"
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   75
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   186
      End
      Begin TextArea ReplyText
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
         Height          =   91
         HelpTag         =   ""
         HideSelection   =   True
         Index           =   -2147483648
         InitialParent   =   "OpenAIGroup"
         Italic          =   False
         Left            =   585
         LimitText       =   0
         LockBottom      =   False
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
         TabIndex        =   3
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   ""
         TextColor       =   "&c00000000"
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   99
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
         Height          =   464
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "OpenAIGroup"
         Left            =   36
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   0
         TabIndex        =   4
         TabPanelIndex   =   0
         TabStop         =   True
         Top             =   216
         UseFocusRing    =   True
         Visible         =   True
         Width           =   849
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
         Left            =   46
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   0
         Selectable      =   False
         TabIndex        =   5
         TabPanelIndex   =   0
         Text            =   "Image output:"
         TextAlign       =   0
         TextColor       =   "&c00000000"
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   191
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   186
      End
      Begin PushButton DoCompletionBtn
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   0
         Cancel          =   False
         Caption         =   "Submit a natural language prompt"
         Default         =   False
         Enabled         =   True
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "OpenAIGroup"
         Italic          =   False
         Left            =   348
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   0
         TabIndex        =   6
         TabPanelIndex   =   0
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   142
         Underline       =   False
         Visible         =   True
         Width           =   209
      End
      Begin PushButton DoGenImageURLBtn
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   0
         Cancel          =   False
         Caption         =   "Generate Image as a URL"
         Default         =   False
         Enabled         =   True
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "OpenAIGroup"
         Italic          =   False
         Left            =   348
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   0
         TabIndex        =   7
         TabPanelIndex   =   0
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   120
         Underline       =   False
         Visible         =   True
         Width           =   209
      End
      Begin PushButton DoGenImageBtn
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   0
         Cancel          =   False
         Caption         =   "Generate Image"
         Default         =   False
         Enabled         =   True
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "OpenAIGroup"
         Italic          =   False
         Left            =   348
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   0
         TabIndex        =   8
         TabPanelIndex   =   0
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   99
         Underline       =   False
         Visible         =   True
         Width           =   209
      End
      Begin PushButton DoModerationBtn
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   0
         Cancel          =   False
         Caption         =   "Categorize text for violence/sex/etc."
         Default         =   False
         Enabled         =   True
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "OpenAIGroup"
         Italic          =   False
         Left            =   348
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   0
         TabIndex        =   9
         TabPanelIndex   =   0
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   163
         Underline       =   False
         Visible         =   True
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
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextColor       =   "&c00000000"
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   11
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
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   11
      Underline       =   False
      Visible         =   True
      Width           =   59
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
      TabIndex        =   3
      TabPanelIndex   =   0
      Text            =   "API Key:"
      TextAlign       =   2
      TextColor       =   "&c00000000"
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   11
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
End
#tag EndWindow

#tag WindowCode
	#tag Method, Flags = &h21
		Private Sub RunCreateImage(Sender As Thread)
		  #pragma Unused Sender
		  Dim img As OpenAI.Response = OpenAI.Image.Generate(mAPIPrompt, "512x512")
		  mAPIImage = img.GetResult(0)
		  RefreshTimer.Mode = Timer.ModeSingle
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RunCreateImageURL(Sender As Thread)
		  #pragma Unused Sender
		  Dim txt As OpenAI.Response = OpenAI.Image.Generate(mAPIPrompt, "512x512", True)
		  mAPIReply = txt.GetResult(0)
		  RefreshTimer.Mode = Timer.ModeSingle
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RunDoCompletion(Sender As Thread)
		  #pragma Unused Sender
		  Dim txt As OpenAI.Response = OpenAI.Completion.Create(mAPIPrompt)
		  mAPIReply = txt.GetResult(0)
		  RefreshTimer.Mode = Timer.ModeSingle
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RunDoModeration(Sender As Thread)
		  #pragma Unused Sender
		  Dim obj As OpenAI.Response = OpenAI.Moderation.Create(mAPIPrompt)
		  Dim js As JSONItem = obj.GetResult(0)
		  js.Compact = False
		  mAPIReply = js.ToString
		  RefreshTimer.Mode = Timer.ModeSingle
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mAPIImage As Picture
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mAPIPrompt As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mAPIReply As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mWorker As Thread
	#tag EndProperty


#tag EndWindowCode

#tag Events ReplyImageCanvas
	#tag Event
		Sub Paint(g As Graphics)
		  If mAPIImage <> Nil Then
		    g.DrawPicture(mAPIImage, 0, 0)
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Function ConstructContextualMenu(base as MenuItem, x as Integer, y as Integer) As Boolean
		  #pragma Unused x
		  #pragma Unused y
		  
		  If mAPIImage <> Nil Then
		    base.Append(New MenuItem("Save as..."))
		    Return True
		  End If
		  
		End Function
	#tag EndEvent
	#tag Event
		Function ContextualMenuAction(hitItem as MenuItem) As Boolean
		  Select Case hitItem.Text
		  Case "Save as..."
		    If mAPIImage <> Nil Then
		      Dim out As FolderItem = GetSaveFolderItem("", "output.png")
		      If out <> Nil Then mAPIImage.Save(out, Picture.SaveAsPNG)
		      Return True
		    End If
		  End Select
		  
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events DoCompletionBtn
	#tag Event
		Sub Action()
		  If PromptText.Text = "" Then Return
		  Self.Title = "Xojo-OpenAI Playground - Working..."
		  mAPIPrompt = PromptText.Text
		  DoGenImageBtn.Enabled = False
		  DoGenImageURLBtn.Enabled = False
		  DoCompletionBtn.Enabled = False
		  DoModerationBtn.Enabled = False
		  mWorker = New Thread
		  AddHandler mWorker.Run, WeakAddressOf RunDoCompletion
		  mWorker.Priority = 3
		  mWorker.Run()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events DoGenImageURLBtn
	#tag Event
		Sub Action()
		  If PromptText.Text = "" Then Return
		  Self.Title = "Xojo-OpenAI Playground - Working..."
		  mAPIPrompt = PromptText.Text
		  DoGenImageBtn.Enabled = False
		  DoGenImageURLBtn.Enabled = False
		  DoCompletionBtn.Enabled = False
		  DoModerationBtn.Enabled = False
		  mWorker = New Thread
		  AddHandler mWorker.Run, WeakAddressOf RunCreateImageURL
		  mWorker.Priority = 3
		  mWorker.Run()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events DoGenImageBtn
	#tag Event
		Sub Action()
		  If PromptText.Text = "" Then Return
		  Self.Title = "Xojo-OpenAI Playground - Working..."
		  mAPIPrompt = PromptText.Text
		  DoGenImageBtn.Enabled = False
		  DoGenImageURLBtn.Enabled = False
		  DoCompletionBtn.Enabled = False
		  DoModerationBtn.Enabled = False
		  mWorker = New Thread
		  AddHandler mWorker.Run, WeakAddressOf RunCreateImage
		  mWorker.Priority = 3
		  mWorker.Run()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events DoModerationBtn
	#tag Event
		Sub Action()
		  If PromptText.Text = "" Then Return
		  Self.Title = "Xojo-OpenAI Playground - Working..."
		  mAPIPrompt = PromptText.Text
		  DoGenImageBtn.Enabled = False
		  DoGenImageURLBtn.Enabled = False
		  DoCompletionBtn.Enabled = False
		  DoModerationBtn.Enabled = False
		  mWorker = New Thread
		  AddHandler mWorker.Run, WeakAddressOf RunDoModeration
		  mWorker.Priority = 3
		  mWorker.Run()
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
		  Self.Title = "Xojo-OpenAI Playground - Working..."
		  OpenAI.APIKey = APIKeyField.Text
		  Dim count As Integer = OpenAI.Model.Count()
		  If count <= 0 Then
		    Call MsgBox("Invalid API Key!", 16, "Key Rejected")
		    OpenAI.APIKey = ""
		    Self.Title = "Xojo-OpenAI Playground"
		    Return
		  End If
		  
		  OpenAIGroup.Enabled = True
		  APIKeyLbl.Enabled = False
		  APIKeyField.Enabled = False
		  Me.Enabled = False
		  Self.Title = "Xojo-OpenAI Playground - Ready"
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events RefreshTimer
	#tag Event
		Sub Action()
		  Self.Title = "Xojo-OpenAI Playground - Ready"
		  ReplyImageCanvas.Invalidate(True)
		  ReplyText.Text = mAPIReply
		  DoGenImageBtn.Enabled = True
		  DoGenImageURLBtn.Enabled = True
		  DoCompletionBtn.Enabled = True
		  DoModerationBtn.Enabled = True
		  
		End Sub
	#tag EndEvent
#tag EndEvents
