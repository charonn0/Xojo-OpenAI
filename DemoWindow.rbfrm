#tag DesktopWindow
Begin DesktopWindow DemoWindow
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
   Composite       =   False
   DefaultLocation =   2
   FullScreen      =   False
   HasBackgroundColor=   False
   HasCloseButton  =   True
   HasFullScreenButton=   False
   HasMaximizeButton=   True
   HasMinimizeButton=   True
   Height          =   700
   ImplicitInstance=   True
   MacProcID       =   0
   MaximumHeight   =   32000
   MaximumWidth    =   32000
   MenuBar         =   1475233791
   MenuBarVisible  =   True
   MinimumHeight   =   700
   MinimumWidth    =   905
   Resizeable      =   True
   Title           =   "Xojo-OpenAI Playground"
   Type            =   0
   Visible         =   True
   Width           =   905
   Begin DesktopGroupBox OpenAIGroup
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "OpenAI"
      Enabled         =   False
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   649
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   11
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   42
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   883
      Begin DesktopTextArea PromptText
         AllowAutoDeactivate=   True
         AllowFocusRing  =   True
         AllowSpellChecking=   True
         AllowStyledText =   True
         AllowTabs       =   False
         BackgroundColor =   &cFFFFFF
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Format          =   ""
         HasBorder       =   True
         HasHorizontalScrollbar=   False
         HasVerticalScrollbar=   True
         Height          =   91
         HideSelection   =   True
         Index           =   -2147483648
         InitialParent   =   "OpenAIGroup"
         Italic          =   False
         Left            =   36
         LineHeight      =   0.0
         LineSpacing     =   1.0
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MaximumCharactersAllowed=   0
         Multiline       =   True
         ReadOnly        =   False
         Scope           =   2
         TabIndex        =   2
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   ""
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   99
         Transparent     =   False
         Underline       =   False
         UnicodeMode     =   0
         ValidationMask  =   ""
         Visible         =   True
         Width           =   300
      End
      Begin DesktopLabel Label2
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
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
         Scope           =   2
         Selectable      =   False
         TabIndex        =   0
         TabPanelIndex   =   0
         TabStop         =   False
         Text            =   "Prompt/Input:"
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   75
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   186
      End
      Begin DesktopLabel Label3
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "OpenAIGroup"
         Italic          =   False
         Left            =   591
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   1
         TabPanelIndex   =   0
         TabStop         =   False
         Text            =   "Reply/Output:"
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   75
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   186
      End
      Begin DesktopTextArea ReplyText
         AllowAutoDeactivate=   True
         AllowFocusRing  =   True
         AllowSpellChecking=   True
         AllowStyledText =   True
         AllowTabs       =   False
         BackgroundColor =   &cFFFFFF
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Format          =   ""
         HasBorder       =   True
         HasHorizontalScrollbar=   False
         HasVerticalScrollbar=   True
         Height          =   91
         HideSelection   =   True
         Index           =   -2147483648
         InitialParent   =   "OpenAIGroup"
         Italic          =   False
         Left            =   585
         LineHeight      =   0.0
         LineSpacing     =   1.0
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         MaximumCharactersAllowed=   0
         Multiline       =   True
         ReadOnly        =   True
         Scope           =   2
         TabIndex        =   4
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   ""
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   99
         Transparent     =   False
         Underline       =   False
         UnicodeMode     =   0
         ValidationMask  =   ""
         Visible         =   True
         Width           =   300
      End
      Begin DesktopCanvas ReplyImageCanvas
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   True
         AllowTabs       =   False
         Backdrop        =   0
         Enabled         =   True
         Height          =   464
         Index           =   -2147483648
         InitialParent   =   "OpenAIGroup"
         Left            =   36
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         TabIndex        =   9
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   ""
         Top             =   216
         Transparent     =   False
         Visible         =   True
         Width           =   849
      End
      Begin DesktopLabel Label4
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
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
         Scope           =   2
         Selectable      =   False
         TabIndex        =   8
         TabPanelIndex   =   0
         TabStop         =   False
         Text            =   "Image output:"
         TextAlignment   =   0
         TextColor       =   &c00000000
         Tooltip         =   ""
         Top             =   191
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   186
      End
      Begin DesktopButton DoCompletionBtn
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Submit a natural language prompt"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "OpenAIGroup"
         Italic          =   False
         Left            =   348
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   6
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   ""
         Top             =   142
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   225
      End
      Begin DesktopButton DoGenImageURLBtn
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Generate Image as a URL"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "OpenAIGroup"
         Italic          =   False
         Left            =   348
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   5
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   ""
         Top             =   120
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   225
      End
      Begin DesktopButton DoGenImageBtn
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Generate Image"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "OpenAIGroup"
         Italic          =   False
         Left            =   348
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   3
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   ""
         Top             =   99
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   225
      End
      Begin DesktopButton DoModerationBtn
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Categorize text for violence/sex/etc."
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "OpenAIGroup"
         Italic          =   False
         Left            =   348
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   7
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   ""
         Top             =   163
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   225
      End
   End
   Begin DesktopTextField APIKeyField
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowSpellChecking=   False
      AllowTabs       =   False
      BackgroundColor =   &cFFFFFF
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Format          =   ""
      HasBorder       =   True
      Height          =   22
      Hint            =   ""
      Index           =   -2147483648
      Italic          =   False
      Left            =   95
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      MaximumCharactersAllowed=   0
      Password        =   False
      ReadOnly        =   False
      Scope           =   2
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   11
      Transparent     =   False
      Underline       =   False
      ValidationMask  =   ""
      Visible         =   True
      Width           =   707
   End
   Begin DesktopButton SetAPIKeyBtn
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "Set"
      Default         =   True
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   22
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   814
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   11
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin DesktopLabel APIKeyLbl
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
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
      Scope           =   2
      Selectable      =   False
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   False
      Text            =   "API Key:"
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   11
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   79
   End
   Begin Timer RefreshTimer
      Enabled         =   True
      Index           =   -2147483648
      InitialParent   =   ""
      LockedInPosition=   False
      Mode            =   0
      Period          =   1
      Scope           =   2
      TabPanelIndex   =   0
   End
End
#tag EndDesktopWindow

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
		Sub Paint(g As Graphics, areas() As Rect)
		  #Pragma unused areas
		  
		  If Not (mAPIImage Is Nil) Then
		    
		    Var Height, Width As Integer
		    Var SourceY, SourceX As Integer = 0
		    
		    If mAPIImage.Width <= g.Width And mAPIImage.Height <= g.Height Then
		      
		      Width = mAPIImage.Width
		      Height = mAPIImage.Height
		      
		    Else
		      
		      If g.Width >= g.Height And mAPIImage.Width >= mAPIImage.Height Then
		        
		        Width = g.Width
		        Height = (mAPIImage.Height * Width) / mAPIImage.Width
		        
		        If Height > g.Height Then
		          
		          Height = g.Height
		          Width = (mAPIImage.Width*Height)/mAPIImage.Height
		          
		        End If
		        
		      ElseIf g.Width >= g.Height And mAPIImage.Width <= mAPIImage.Height Then
		        
		        Height = g.Height
		        Width = (mAPIImage.Width * Height) / mAPIImage.Height
		        
		      ElseIf g.Width <= g.Height And mAPIImage.Width >= mAPIImage.Height Then
		        
		        Width = g.Width
		        Height = (mAPIImage.Height * Width) / mAPIImage.Width
		        
		      ElseIf g.Width <= g.Height And mAPIImage.Width <= mAPIImage.Height Then
		        
		        Height = g.Height
		        Width = (mAPIImage.Width*Height)/mAPIImage.Height
		        
		        If Width > g.Width Then
		          
		          Width = g.Width
		          Height = (mAPIImage.Height*Width)/mAPIImage.Width
		          
		        End If
		        
		      End If
		      
		    End If
		    
		    sourcex = (g.Width/2) - (Width/2)
		    sourcey = (g.Height/2) - (Height/2)
		    
		    g.DrawPicture(mAPIImage,sourcex,sourcey,Width,Height,0,0,mAPIImage.Width,mAPIImage.Height)
		    
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Function ConstructContextualMenu(base As DesktopMenuItem, x As Integer, y As Integer) As Boolean
		  #pragma Unused x
		  #pragma Unused y
		  
		  If mAPIImage <> Nil Then
		    base.AddMenu(New MenuItem("Save as..."))
		    Return True
		  End If
		  
		End Function
	#tag EndEvent
	#tag Event
		Function ContextualMenuItemSelected(selectedItem As DesktopMenuItem) As Boolean
		  Select Case selectedItem.Text
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
		Sub Pressed()
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
		Sub Pressed()
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
		Sub Pressed()
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
		Sub Pressed()
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
#tag Events APIKeyField
	#tag Event
		Sub Opening()
		  Me.Hint = OpenAI.APIKey
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SetAPIKeyBtn
	#tag Event
		Sub Pressed()
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
		  Me.Default = False
		  DoCompletionBtn.Default = True
		  Self.Title = "Xojo-OpenAI Playground - Ready"
		  PromptText.SetFocus()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events RefreshTimer
	#tag Event
		Sub Action()
		  Self.Title = "Xojo-OpenAI Playground - Ready"
		  ReplyImageCanvas.Refresh(True)
		  ReplyText.Text = mAPIReply
		  DoGenImageBtn.Enabled = True
		  DoGenImageURLBtn.Enabled = True
		  DoCompletionBtn.Enabled = True
		  DoModerationBtn.Enabled = True
		  
		End Sub
	#tag EndEvent
#tag EndEvents
