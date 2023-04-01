#tag Window
Begin Window DemoWindow
   BackColor       =   "&cFFFFFF00"
   Backdrop        =   0
   CloseButton     =   True
   Composite       =   False
   Frame           =   0
   FullScreen      =   False
   HasBackColor    =   False
   Height          =   6.47e+2
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
   Width           =   9.05e+2
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
      TabIndex        =   0
      TabPanelIndex   =   0
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   59
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
         Height          =   215
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
         LockRight       =   True
         LockTop         =   False
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
         Top             =   100
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
         LockTop         =   False
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
         Top             =   76
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   186
      End
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
         Left            =   36
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   False
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
         Top             =   373
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   292
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
         Height          =   207
         HelpTag         =   ""
         HideSelection   =   True
         Index           =   -2147483648
         InitialParent   =   "OpenAIGroup"
         Italic          =   False
         Left            =   36
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
         TabIndex        =   3
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   ""
         TextColor       =   "&c00000000"
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   398
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
         Height          =   207
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "OpenAIGroup"
         Left            =   364
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   0
         TabIndex        =   4
         TabPanelIndex   =   0
         TabStop         =   True
         Top             =   398
         UseFocusRing    =   True
         Visible         =   True
         Width           =   512
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
         Left            =   367
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   False
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
         Top             =   373
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
         Left            =   364
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         Scope           =   0
         TabIndex        =   6
         TabPanelIndex   =   0
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   143
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
         Left            =   364
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         Scope           =   0
         TabIndex        =   7
         TabPanelIndex   =   0
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   121
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
         Left            =   364
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         Scope           =   0
         TabIndex        =   8
         TabPanelIndex   =   0
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   100
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
         Left            =   364
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         Scope           =   0
         TabIndex        =   9
         TabPanelIndex   =   0
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   164
         Underline       =   False
         Visible         =   True
         Width           =   209
      End
      Begin Listbox ModelList
         AutoDeactivate  =   True
         AutoHideScrollbars=   True
         Bold            =   ""
         Border          =   True
         ColumnCount     =   1
         ColumnsResizable=   ""
         ColumnWidths    =   ""
         DataField       =   ""
         DataSource      =   ""
         DefaultRowHeight=   -1
         Enabled         =   True
         EnableDrag      =   ""
         EnableDragReorder=   ""
         GridLinesHorizontal=   0
         GridLinesVertical=   0
         HasHeading      =   True
         HeadingIndex    =   -1
         Height          =   184
         HelpTag         =   ""
         Hierarchical    =   False
         Index           =   -2147483648
         InitialParent   =   "OpenAIGroup"
         InitialValue    =   "Select an AI model"
         Italic          =   ""
         Left            =   609
         LockBottom      =   ""
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         RequiresSelection=   ""
         Scope           =   0
         ScrollbarHorizontal=   ""
         ScrollBarVertical=   True
         SelectionType   =   0
         TabIndex        =   10
         TabPanelIndex   =   0
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0
         TextUnit        =   0
         Top             =   105
         Underline       =   ""
         UseFocusRing    =   True
         Visible         =   True
         Width           =   258
         _ScrollWidth    =   -1
      End
      Begin Slider MaxTokensSlider
         AutoDeactivate  =   True
         Enabled         =   True
         Height          =   23
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "OpenAIGroup"
         Left            =   476
         LineStep        =   8
         LiveScroll      =   True
         LockBottom      =   ""
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         Maximum         =   2048
         Minimum         =   1
         PageStep        =   32
         Scope           =   0
         TabIndex        =   11
         TabPanelIndex   =   0
         TabStop         =   True
         TickStyle       =   1
         Top             =   321
         Value           =   64
         Visible         =   True
         Width           =   336
      End
      Begin Slider TemperatureSlider
         AutoDeactivate  =   True
         Enabled         =   True
         Height          =   23
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "OpenAIGroup"
         Left            =   476
         LineStep        =   1
         LiveScroll      =   True
         LockBottom      =   ""
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         Maximum         =   100
         Minimum         =   0
         PageStep        =   20
         Scope           =   0
         TabIndex        =   12
         TabPanelIndex   =   0
         TabStop         =   True
         TickStyle       =   1
         Top             =   298
         Value           =   0
         Visible         =   True
         Width           =   336
      End
      Begin Label Label1
         AutoDeactivate  =   True
         Bold            =   ""
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "OpenAIGroup"
         Italic          =   ""
         Left            =   364
         LockBottom      =   ""
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         Multiline       =   ""
         Scope           =   0
         Selectable      =   False
         TabIndex        =   13
         TabPanelIndex   =   0
         Text            =   "Max tokens:"
         TextAlign       =   2
         TextColor       =   &h000000
         TextFont        =   "System"
         TextSize        =   0
         TextUnit        =   0
         Top             =   324
         Transparent     =   False
         Underline       =   ""
         Visible         =   True
         Width           =   100
      End
      Begin Label Label5
         AutoDeactivate  =   True
         Bold            =   ""
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "OpenAIGroup"
         Italic          =   ""
         Left            =   364
         LockBottom      =   ""
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         Multiline       =   ""
         Scope           =   0
         Selectable      =   False
         TabIndex        =   14
         TabPanelIndex   =   0
         Text            =   "Temperature:"
         TextAlign       =   2
         TextColor       =   &h000000
         TextFont        =   "System"
         TextSize        =   0
         TextUnit        =   0
         Top             =   301
         Transparent     =   False
         Underline       =   ""
         Visible         =   True
         Width           =   100
      End
      Begin Label MaxTokensLbl
         AutoDeactivate  =   True
         Bold            =   ""
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "OpenAIGroup"
         Italic          =   ""
         Left            =   822
         LockBottom      =   ""
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         Multiline       =   ""
         Scope           =   0
         Selectable      =   False
         TabIndex        =   15
         TabPanelIndex   =   0
         Text            =   64
         TextAlign       =   0
         TextColor       =   &h000000
         TextFont        =   "System"
         TextSize        =   0
         TextUnit        =   0
         Top             =   324
         Transparent     =   False
         Underline       =   ""
         Visible         =   True
         Width           =   63
      End
      Begin Label TemperatureLbl
         AutoDeactivate  =   True
         Bold            =   ""
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "OpenAIGroup"
         Italic          =   ""
         Left            =   822
         LockBottom      =   ""
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         Multiline       =   ""
         Scope           =   0
         Selectable      =   False
         TabIndex        =   16
         TabPanelIndex   =   0
         Text            =   0.00
         TextAlign       =   0
         TextColor       =   &h000000
         TextFont        =   "System"
         TextSize        =   0
         TextUnit        =   0
         Top             =   301
         Transparent     =   False
         Underline       =   ""
         Visible         =   True
         Width           =   63
      End
      Begin Slider ResultCountSlider
         AutoDeactivate  =   True
         Enabled         =   True
         Height          =   23
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "OpenAIGroup"
         Left            =   476
         LineStep        =   1
         LiveScroll      =   True
         LockBottom      =   ""
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         Maximum         =   100
         Minimum         =   1
         PageStep        =   20
         Scope           =   0
         TabIndex        =   17
         TabPanelIndex   =   0
         TabStop         =   True
         TickStyle       =   1
         Top             =   344
         Value           =   1
         Visible         =   True
         Width           =   336
      End
      Begin Label Label6
         AutoDeactivate  =   True
         Bold            =   ""
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "OpenAIGroup"
         Italic          =   ""
         Left            =   364
         LockBottom      =   ""
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         Multiline       =   ""
         Scope           =   0
         Selectable      =   False
         TabIndex        =   18
         TabPanelIndex   =   0
         Text            =   "Result count:"
         TextAlign       =   2
         TextColor       =   &h000000
         TextFont        =   "System"
         TextSize        =   0
         TextUnit        =   0
         Top             =   347
         Transparent     =   False
         Underline       =   ""
         Visible         =   True
         Width           =   100
      End
      Begin Label ResultCountLbl
         AutoDeactivate  =   True
         Bold            =   ""
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "OpenAIGroup"
         Italic          =   ""
         Left            =   822
         LockBottom      =   ""
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         Multiline       =   ""
         Scope           =   0
         Selectable      =   False
         TabIndex        =   19
         TabPanelIndex   =   0
         Text            =   1
         TextAlign       =   0
         TextColor       =   &h000000
         TextFont        =   "System"
         TextSize        =   0
         TextUnit        =   0
         Top             =   347
         Transparent     =   False
         Underline       =   ""
         Visible         =   True
         Width           =   63
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
         Left            =   364
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         Scope           =   0
         TabIndex        =   20
         TabPanelIndex   =   0
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   271
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
         Left            =   364
         LockBottom      =   ""
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         Maximum         =   0
         Scope           =   0
         TabPanelIndex   =   0
         Top             =   259
         Value           =   0
         Visible         =   False
         Width           =   209
      End
      Begin PushButton DoTranscriptionBtn
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   0
         Cancel          =   False
         Caption         =   "Transcribe a media file"
         Default         =   False
         Enabled         =   True
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "OpenAIGroup"
         Italic          =   False
         Left            =   364
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         Scope           =   0
         TabIndex        =   21
         TabPanelIndex   =   0
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   186
         Underline       =   False
         Visible         =   True
         Width           =   209
      End
      Begin PushButton DoTranslationBtn
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   0
         Cancel          =   False
         Caption         =   "Translate a media file"
         Default         =   False
         Enabled         =   True
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "OpenAIGroup"
         Italic          =   False
         Left            =   364
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         Scope           =   0
         TabIndex        =   22
         TabPanelIndex   =   0
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   208
         Underline       =   False
         Visible         =   True
         Width           =   209
      End
      Begin PushButton DoChatBtn
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   0
         Cancel          =   False
         Caption         =   "Start a chat"
         Default         =   False
         Enabled         =   True
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "OpenAIGroup"
         Italic          =   False
         Left            =   364
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         Scope           =   0
         TabIndex        =   23
         TabPanelIndex   =   0
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   230
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
      TabIndex        =   2
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
      TabIndex        =   3
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
      Left            =   0
      LockedInPosition=   False
      Mode            =   0
      Period          =   1
      Scope           =   0
      TabPanelIndex   =   0
      Top             =   0
      Width           =   32
   End
   Begin Label URLLbl
      AutoDeactivate  =   True
      Bold            =   ""
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   ""
      Left            =   286
      LockBottom      =   ""
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Multiline       =   ""
      Scope           =   0
      Selectable      =   False
      TabIndex        =   4
      TabPanelIndex   =   0
      Text            =   "https://github.com/charonn0/Xojo-OpenAI"
      TextAlign       =   1
      TextColor       =   &h000000FF
      TextFont        =   "System"
      TextSize        =   0
      TextUnit        =   0
      Top             =   2
      Transparent     =   False
      Underline       =   True
      Visible         =   True
      Width           =   333
   End
   Begin Label StatusBarLbl
      AutoDeactivate  =   True
      Bold            =   ""
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
      Multiline       =   ""
      Scope           =   0
      Selectable      =   False
      TabIndex        =   5
      TabPanelIndex   =   0
      Text            =   "Waiting for API key"
      TextAlign       =   0
      TextColor       =   "&c00000000"
      TextFont        =   "System"
      TextSize        =   0
      TextUnit        =   0
      Top             =   626
      Transparent     =   False
      Underline       =   ""
      Visible         =   True
      Width           =   894
   End
End
#tag EndWindow

#tag WindowCode
	#tag Method, Flags = &h21
		Private Sub LoadModels()
		  ModelList.DeleteAllRows()
		  ModelList.AddRow("Automatic")
		  For i As Integer = 0 To OpenAI.Model.Count - 1
		    Dim mdl As OpenAI.Model = OpenAI.Model.Lookup(i)
		    ModelList.AddRow(mdl.ID)
		    ModelList.RowTag(ModelList.LastIndex) = mdl
		  Next
		  ModelList.ListIndex = 0
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RunCreateImage(Sender As Thread)
		  #pragma Unused Sender
		  Dim request As New OpenAI.Request()
		  request.Prompt = mAPIPrompt
		  request.Size = "512x512"
		  request.ResultsAsURL = False
		  If mResultCount > 1 And mResultCount <= 10 Then request.NumberOfResults = mResultCount
		  mAPIReply = OpenAI.Image.Generate(request)
		  RefreshTimer.Mode = Timer.ModeSingle
		  
		Exception err As OpenAI.OpenAIException
		  mLastError = err
		  RefreshTimer.Mode = Timer.ModeSingle
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RunCreateImageURL(Sender As Thread)
		  #pragma Unused Sender
		  Dim request As New OpenAI.Request()
		  request.Prompt = mAPIPrompt
		  request.Size = "512x512"
		  request.ResultsAsURL = True
		  If mResultCount > 1 And mResultCount <= 10 Then request.NumberOfResults = mResultCount
		  mAPIReply = OpenAI.Image.Generate(request)
		  RefreshTimer.Mode = Timer.ModeSingle
		  
		Exception err As OpenAI.OpenAIException
		  mLastError = err
		  RefreshTimer.Mode = Timer.ModeSingle
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RunDoCompletion(Sender As Thread)
		  #pragma Unused Sender
		  Dim request As New OpenAI.Request()
		  request.Prompt = mAPIPrompt
		  request.MaxTokens = mMaxTokens
		  If mTemperature > 0.0000001 Then request.Temperature = mTemperature
		  If mModel = Nil Then
		    request.Model = OpenAI.Model.Lookup("text-davinci-003")
		  Else
		    request.Model = mModel
		  End If
		  If mResultCount > 1 Then request.NumberOfResults = mResultCount
		  mAPIReply = OpenAI.Completion.Create(request)
		  RefreshTimer.Mode = Timer.ModeSingle
		  
		Exception err As OpenAI.OpenAIException
		  mLastError = err
		  RefreshTimer.Mode = Timer.ModeSingle
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RunDoModeration(Sender As Thread)
		  #pragma Unused Sender
		  Dim request As New OpenAI.Request()
		  request.Input = mAPIPrompt
		  If mModel = Nil Then
		    request.Model = OpenAI.Model.Lookup("text-moderation-stable")
		  Else
		    request.Model = mModel
		  End If
		  If mResultCount > 1 Then request.NumberOfResults = mResultCount
		  mAPIReply = OpenAI.Moderation.Create(request)
		  RefreshTimer.Mode = Timer.ModeSingle
		  
		Exception err As OpenAI.OpenAIException
		  mLastError = err
		  RefreshTimer.Mode = Timer.ModeSingle
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RunDoTranscription(Sender As Thread)
		  #pragma Unused Sender
		  Dim request As New OpenAI.Request()
		  Dim bs As BinaryStream = BinaryStream.Open(mAudioFile)
		  request.File = bs.Read(bs.Length)
		  bs.Close
		  request.FileName = mAudioFile.Name
		  If mTemperature > 0.0000001 Then request.Temperature = mTemperature
		  If mModel = Nil Then
		    request.Model = OpenAI.Model.Lookup("whisper-1")
		  Else
		    request.Model = mModel
		  End If
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
		  Dim request As New OpenAI.Request()
		  Dim bs As BinaryStream = BinaryStream.Open(mAudioFile)
		  request.File = bs.Read(bs.Length)
		  bs.Close
		  request.FileName = mAudioFile.Name
		  If mTemperature > 0.0000001 Then request.Temperature = mTemperature
		  If mModel = Nil Then
		    request.Model = OpenAI.Model.Lookup("whisper-1")
		  Else
		    request.Model = mModel
		  End If
		  mAPIReply = OpenAI.AudioTranslation.Create(request)
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
		Private Sub ToggleLockUI()
		  DoGenImageBtn.Enabled = Not DoGenImageBtn.Enabled
		  DoGenImageURLBtn.Enabled = Not DoGenImageURLBtn.Enabled
		  DoCompletionBtn.Enabled = Not DoCompletionBtn.Enabled
		  DoModerationBtn.Enabled = Not DoModerationBtn.Enabled
		  DoTranscriptionBtn.Enabled = Not DoTranscriptionBtn.Enabled
		  DoTranslationBtn.Enabled = Not DoTranslationBtn.Enabled
		  DoChatBtn.Enabled = Not DoChatBtn.Enabled
		  DoAbortBtn.Visible = Not DoAbortBtn.Visible
		  RequestProgressBar.Visible = Not RequestProgressBar.Visible
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mAPIImage As Picture
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mAPIPrompt As String
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
		Private mMaxTokens As Integer = 64
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mModel As OpenAI.Model
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mResultCount As Integer = 1
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mScale As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTemperature As Single
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
#tag Events DoCompletionBtn
	#tag Event
		Sub Action()
		  If PromptText.Text = "" Then Return
		  StatusBarLbl.Text = "Working..."
		  mAPIPrompt = PromptText.Text
		  ToggleLockUI()
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
		  StatusBarLbl.Text = "Working..."
		  mAPIPrompt = PromptText.Text
		  ToggleLockUI()
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
		  StatusBarLbl.Text = "Working..."
		  mAPIPrompt = PromptText.Text
		  ToggleLockUI()
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
		  StatusBarLbl.Text = "Working..."
		  mAPIPrompt = PromptText.Text
		  ToggleLockUI()
		  mWorker = New Thread
		  AddHandler mWorker.Run, WeakAddressOf RunDoModeration
		  mWorker.Priority = 3
		  mWorker.Run()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ModelList
	#tag Event
		Sub Change()
		  If Me.ListIndex < 0 Then Return
		  mModel = Me.RowTag(Me.ListIndex)
		End Sub
	#tag EndEvent
	#tag Event
		Sub DoubleClick()
		  If Me.ListIndex > -1 Then
		    Dim mdl As OpenAI.Model = Me.RowTag(Me.ListIndex)
		    If mdl <> Nil Then ModelInfoWindow.ShowModel(mdl)
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Function KeyDown(Key As String) As Boolean
		  If Asc(Key) = &h0D And Me.ListIndex > -1 Then
		    Dim mdl As OpenAI.Model = Me.RowTag(Me.ListIndex)
		    If mdl <> Nil Then ModelInfoWindow.ShowModel(mdl)
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
#tag EndEvents
#tag Events MaxTokensSlider
	#tag Event
		Sub ValueChanged()
		  mMaxTokens = Me.Value
		  MaxTokensLbl.Text = Format(mMaxTokens, "#,##0")
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events TemperatureSlider
	#tag Event
		Sub ValueChanged()
		  If Me.Value > 0 Then mTemperature = Me.Value / 100 Else mTemperature = 0.0
		  TemperatureLbl.Text = Format(mTemperature, "0.00")
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ResultCountSlider
	#tag Event
		Sub ValueChanged()
		  mResultCount = Me.Value
		  ResultCountLbl.Text = Format(mResultCount, "##0")
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
		  DoGenImageBtn.Enabled = True
		  DoGenImageURLBtn.Enabled = True
		  DoCompletionBtn.Enabled = True
		  DoModerationBtn.Enabled = True
		  mWorker = Nil
		  ReplyText.Text = "Aborted by user."
		  Me.Visible = False
		  RequestProgressBar.Visible = False
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events DoTranscriptionBtn
	#tag Event
		Sub Action()
		  mAudioFile = GetOpenFolderItem(UploadabeFileTypes.All)
		  If mAudioFile = Nil Or Not mAudioFile.Exists Or mAudioFile.Directory Then Return
		  StatusBarLbl.Text = "Working..."
		  #If RBVersion > 2019 Then
		    PromptText.Text = mAudioFile.NativePath
		  #Else
		    PromptText.Text = mAudioFile.AbsolutePath
		  #endif
		  ToggleLockUI()
		  mWorker = New Thread
		  AddHandler mWorker.Run, WeakAddressOf RunDoTranscription
		  mWorker.Priority = 3
		  mWorker.Run()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events DoTranslationBtn
	#tag Event
		Sub Action()
		  mAudioFile = GetOpenFolderItem(UploadabeFileTypes.All)
		  If mAudioFile = Nil Or Not mAudioFile.Exists Or mAudioFile.Directory Then Return
		  StatusBarLbl.Text = "Working..."
		  PromptText.Text = mAudioFile.Name
		  ToggleLockUI()
		  mWorker = New Thread
		  AddHandler mWorker.Run, WeakAddressOf RunDoTranslation
		  mWorker.Priority = 3
		  mWorker.Run()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events DoChatBtn
	#tag Event
		Sub Action()
		  Dim chatwnd As New ChatWindow(mModel)
		  chatwnd.Show()
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
		  If mLastError <> Nil Then ' an error occurred
		    mAPIImage = Nil
		    mAPIReply = Nil
		    ReplyText.Text = mLastError.Message
		    Call MsgBox("OpenAI rejected the request.", 16, "API Error")
		    mLastError = Nil
		    StatusBarLbl.Text = "Error"
		  Else
		    Select Case mAPIReply.ResultType
		    Case OpenAI.ResultType.String, OpenAI.ResultType.PictureURL
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
		      ReplyText.Text = ""
		      mAPIImage = mAPIReply.GetResult
		    End Select
		    StatusBarLbl.Text = "Ready"
		  End If
		  
		  ReplyImageCanvas.Invalidate(True)
		  ToggleLockUI()
		  If mAPIReply <> Nil And mAPIReply.TokenCount > 0 Then
		    Dim ptc As String = Str(mAPIReply.PromptTokenCount)
		    Dim rtc As String = Str(mAPIReply.ReplyTokenCount)
		    Dim tc As String = Str(mAPIReply.TokenCount)
		    Dim finres As String = mAPIReply.FinishReason
		    If finres = "" Then
		      StatusBarLbl.Text = "Complete. Token usage: Prompt:" + ptc + " / Reply:" + rtc + " / Total:" + tc
		    Else
		      StatusBarLbl.Text = "Complete. Token usage: Prompt:" + ptc + " / Reply:" + rtc + " / Total:" + tc + " / Finish reason:" + mAPIReply.FinishReason
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
