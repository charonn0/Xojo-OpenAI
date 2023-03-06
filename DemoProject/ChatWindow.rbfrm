#tag Window
Begin Window ChatWindow
   BackColor       =   &hFFFFFF
   Backdrop        =   ""
   CloseButton     =   True
   Composite       =   False
   Frame           =   0
   FullScreen      =   False
   HasBackColor    =   False
   Height          =   4.15e+2
   ImplicitInstance=   False
   LiveResize      =   True
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   False
   MaxWidth        =   32000
   MenuBar         =   ""
   MenuBarVisible  =   True
   MinHeight       =   64
   MinimizeButton  =   True
   MinWidth        =   64
   Placement       =   0
   Resizeable      =   True
   Title           =   "AI Assistant Chat"
   Visible         =   True
   Width           =   6.48e+2
   Begin Listbox ChatMessagesList
      AutoDeactivate  =   True
      AutoHideScrollbars=   True
      Bold            =   ""
      Border          =   True
      ColumnCount     =   2
      ColumnsResizable=   ""
      ColumnWidths    =   "15%,100%"
      DataField       =   ""
      DataSource      =   ""
      DefaultRowHeight=   -1
      Enabled         =   True
      EnableDrag      =   ""
      EnableDragReorder=   ""
      GridLinesHorizontal=   2
      GridLinesVertical=   0
      HasHeading      =   True
      HeadingIndex    =   -1
      Height          =   389
      HelpTag         =   ""
      Hierarchical    =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   "Role	Content"
      Italic          =   ""
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      RequiresSelection=   ""
      Scope           =   0
      ScrollbarHorizontal=   True
      ScrollBarVertical=   True
      SelectionType   =   0
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0
      TextUnit        =   0
      Top             =   0
      Underline       =   ""
      UseFocusRing    =   True
      Visible         =   True
      Width           =   648
      _ScrollWidth    =   -1
   End
   Begin TextField ChatMessageField
      AcceptTabs      =   ""
      Alignment       =   0
      AutoDeactivate  =   True
      AutomaticallyCheckSpelling=   False
      BackColor       =   &hFFFFFF
      Bold            =   ""
      Border          =   True
      CueText         =   ""
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Format          =   ""
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      Italic          =   ""
      Left            =   61
      LimitText       =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   False
      Mask            =   ""
      Password        =   ""
      ReadOnly        =   ""
      Scope           =   0
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextColor       =   &h000000
      TextFont        =   "System"
      TextSize        =   0
      TextUnit        =   0
      Top             =   391
      Underline       =   ""
      UseFocusRing    =   True
      Visible         =   True
      Width           =   526
   End
   Begin PushButton SendMsgBtn
      AutoDeactivate  =   True
      Bold            =   ""
      ButtonStyle     =   0
      Cancel          =   ""
      Caption         =   "Send"
      Default         =   True
      Enabled         =   True
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   ""
      Left            =   591
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      Scope           =   0
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0
      TextUnit        =   0
      Top             =   391
      Underline       =   ""
      Visible         =   True
      Width           =   57
   End
   Begin PopupMenu RoleList
      AutoDeactivate  =   True
      Bold            =   ""
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   "User\r\nAssistant\r\nSystem"
      Italic          =   ""
      Left            =   6
      ListIndex       =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   ""
      LockTop         =   False
      Scope           =   0
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0
      TextUnit        =   0
      Top             =   391
      Underline       =   ""
      Visible         =   True
      Width           =   52
   End
   Begin Thread RequestThread
      Height          =   32
      Index           =   -2147483648
      Left            =   660
      LockedInPosition=   False
      Priority        =   3
      Scope           =   0
      StackSize       =   0
      TabPanelIndex   =   0
      Top             =   0
      Width           =   32
   End
   Begin Timer ResponseTimer
      Height          =   32
      Index           =   -2147483648
      Left            =   660
      LockedInPosition=   False
      Mode            =   0
      Period          =   1
      Scope           =   0
      TabPanelIndex   =   0
      Top             =   37
      Width           =   32
   End
End
#tag EndWindow

#tag WindowCode
	#tag Property, Flags = &h21
		Private mContent As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastResponse As OpenAI.ChatCompletion
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRole As String
	#tag EndProperty


#tag EndWindowCode

#tag Events SendMsgBtn
	#tag Event
		Sub Action()
		  If ChatMessageField.Text.Trim <> "" Then
		    Me.Enabled = False
		    mRole = RoleList.Text
		    mContent = ChatMessageField.Text
		    ChatMessageField.Text = ""
		    RequestThread.Run()
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events RequestThread
	#tag Event
		Sub Run()
		  If mLastResponse = Nil Then
		    mLastResponse = OpenAI.ChatCompletion.Create(Lowercase(mRole), mContent)
		  Else
		    mLastResponse = mLastResponse.GenerateNext(Lowercase(mRole), mContent)
		  End If
		  ResponseTimer.Mode = Timer.ModeSingle
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ResponseTimer
	#tag Event
		Sub Action()
		  If mLastResponse = Nil Then Return
		  If mLastResponse.ChatLog.MessageCount > 0 Then
		    Dim m1, m2 As JSONItem
		    m1 = mLastResponse.ChatLog.GetMessage(mLastResponse.ChatLog.MessageCount - 1)
		    If mLastResponse.ChatLog.MessageCount > 1 Then
		      m2 = mLastResponse.ChatLog.GetMessage(mLastResponse.ChatLog.MessageCount - 2)
		    End If
		    If m2 <> Nil Then
		      Dim r, c As String
		      r = m2.Value("role")
		      c = m2.Value("content")
		      ChatMessagesList.AddRow(r.Trim, c.Trim)
		      ChatMessagesList.RowTag(ChatMessagesList.LastIndex) = m2
		    End If
		    If m1 <> Nil Then
		      Dim r, c As String
		      r = m1.Value("role")
		      c = m1.Value("content")
		      ChatMessagesList.AddRow(r.Trim, c.Trim)
		      ChatMessagesList.RowTag(ChatMessagesList.LastIndex) = m1
		    End If
		  End If
		  SendMsgBtn.Enabled = True
		End Sub
	#tag EndEvent
#tag EndEvents
