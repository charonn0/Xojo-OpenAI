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
      Top             =   36
      Width           =   32
   End
   Begin ChatLogArea ChatMessages
      AcceptTabs      =   ""
      Alignment       =   0
      AutoDeactivate  =   True
      AutomaticallyCheckSpelling=   True
      BackColor       =   &hFFFFFF
      Bold            =   ""
      Border          =   True
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Format          =   ""
      Height          =   366
      HelpTag         =   ""
      HideSelection   =   True
      Index           =   -2147483648
      Italic          =   ""
      Left            =   0
      LimitText       =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Mask            =   ""
      Multiline       =   True
      ReadOnly        =   ""
      Scope           =   0
      ScrollbarHorizontal=   ""
      ScrollbarVertical=   True
      Styled          =   True
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextColor       =   &h000000
      TextFont        =   "System"
      TextSize        =   0
      TextUnit        =   0
      Top             =   0
      Underline       =   ""
      UseFocusRing    =   True
      Visible         =   True
      Width           =   648
   End
   Begin Label ImgLbl
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
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   ""
      LockTop         =   False
      Multiline       =   ""
      Scope           =   0
      Selectable      =   False
      TabIndex        =   5
      TabPanelIndex   =   0
      Text            =   "Image:"
      TextAlign       =   2
      TextColor       =   &h000000
      TextFont        =   "System"
      TextSize        =   0
      TextUnit        =   0
      Top             =   366
      Transparent     =   False
      Underline       =   ""
      Visible         =   False
      Width           =   49
   End
   Begin TextField ImageContent
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
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextColor       =   &h000000
      TextFont        =   "System"
      TextSize        =   0
      TextUnit        =   0
      Top             =   366
      Underline       =   ""
      UseFocusRing    =   True
      Visible         =   False
      Width           =   526
   End
   Begin Label ImageCountLbl
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
      Left            =   591
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      Multiline       =   ""
      Scope           =   0
      Selectable      =   False
      TabIndex        =   7
      TabPanelIndex   =   0
      Text            =   "0 image(s)"
      TextAlign       =   0
      TextColor       =   &h000000
      TextFont        =   "System"
      TextSize        =   9
      TextUnit        =   0
      Top             =   368
      Transparent     =   False
      Underline       =   ""
      Visible         =   False
      Width           =   57
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Open()
		  Self.Title = "AI Assistant Chat - " + mModel.ID
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Constructor(Model As OpenAI.Model, Backlog As OpenAI.ChatCompletionData = Nil)
		  If Model = Nil Then Model = OpenAI.Model.Lookup("gpt-4")
		  If InStr(Model.ID, "-vision-") > 0 Or Model.ID = "gpt-4o" Then
		    ChatMessages.Height = 366
		    ImgLbl.Visible = True
		    ImageContent.Visible = True
		    ImageCountLbl.Visible = True
		  Else
		    ChatMessages.Height = 389
		    ImgLbl.Visible = False
		    ImageContent.Visible = False
		    ImageCountLbl.Visible = False
		  End If
		  mModel = Model
		  mBacklog = Backlog
		  // Calling the overridden superclass constructor.
		  Super.Constructor()
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mBacklog As OpenAI.ChatCompletionData
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mContent As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mImageFiles() As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mImageURLs() As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastError As RuntimeException
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastResponse As OpenAI.ChatCompletion
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLockImageList As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mModel As OpenAI.Model
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRole As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTokenCount As Integer
	#tag EndProperty


#tag EndWindowCode

#tag Events SendMsgBtn
	#tag Event
		Sub Action()
		  If ChatMessageField.Text.Trim <> "" Then
		    If RoleList.Text = "User" Then
		      Me.Enabled = False
		      mRole = RoleList.Text
		      mContent = ChatMessageField.Text
		      RequestThread.Run()
		    Else
		      If mBacklog = Nil Then mBacklog = New OpenAI.ChatCompletionData()
		      mBacklog.AddMessage(RoleList.Text, ChatMessageField.Text)
		      ChatMessages.AppendMessage(RoleList.Text, ChatMessageField.Text, mLastResponse)
		    End If
		  End If
		  ChatMessageField.Text = ""
		  ImageContent.Text = ""
		  ImageCountLbl.Text = "0 image(s)"
		  Me.Caption = "Waiting"
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events RoleList
	#tag Event
		Sub Change()
		  If Me.Text = "User" Then
		    SendMsgBtn.Caption = "Send"
		  Else
		    SendMsgBtn.Caption = "Insert"
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events RequestThread
	#tag Event
		Sub Run()
		  If mLastResponse = Nil Then
		    Select Case True
		    Case UBound(mImageURLs) = 0
		      mLastResponse = OpenAI.ImageRecognition.Create(mContent, mImageURLs(0), 300, mModel)
		    Case UBound(mImageFiles) = 0
		      mLastResponse = OpenAI.ImageRecognition.Create(mContent, mImageFiles(0), 300, mModel)
		    Case UBound(mImageURLs) > -1
		      mLastResponse = OpenAI.ImageRecognition.Create(mContent, mImageURLs, 300, mModel)
		    Case UBound(mImageFiles) > -1
		      mLastResponse = OpenAI.ImageRecognition.Create(mContent, mImageFiles, 300, mModel)
		    Else
		      mLastResponse = OpenAI.ChatCompletion.Create(mBacklog, Lowercase(mRole), mContent, mModel)
		    End Select
		  Else
		    Select Case True
		    Case UBound(mImageURLs) = 0
		      Dim ir As OpenAI.ImageRecognition = OpenAI.ImageRecognition(mLastResponse)
		      mLastResponse = ir.GenerateNext(Lowercase(mRole), mContent, mImageURLs(0), 300, mModel)
		    Case UBound(mImageFiles) = 0
		      Dim ir As OpenAI.ImageRecognition = OpenAI.ImageRecognition(mLastResponse)
		      mLastResponse = ir.GenerateNext(Lowercase(mRole), mContent, mImageFiles(0), 300, mModel)
		    Case UBound(mImageURLs) > -1
		      Dim ir As OpenAI.ImageRecognition = OpenAI.ImageRecognition(mLastResponse)
		      mLastResponse = ir.GenerateNext(Lowercase(mRole), mContent, mImageURLs, 300, mModel)
		    Case UBound(mImageFiles) > -1
		      Dim ir As OpenAI.ImageRecognition = OpenAI.ImageRecognition(mLastResponse)
		      mLastResponse = ir.GenerateNext(Lowercase(mRole), mContent, mImageFiles, 300, mModel)
		    Else
		      mLastResponse = mLastResponse.GenerateNext(Lowercase(mRole), mContent, mModel)
		    End Select
		  End If
		  ResponseTimer.Mode = Timer.ModeSingle
		  
		Exception err As OpenAI.OpenAIException
		  mLastError = err
		  ResponseTimer.Mode = Timer.ModeSingle
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ResponseTimer
	#tag Event
		Sub Action()
		  If mLastError <> Nil Then
		    Call MsgBox(mLastError.Message, 16, "API Error")
		    mLastError = Nil
		  Else
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
		        If UBound(mImageFiles) > -1 Then
		          m2 = m2.Value("content")
		          m2 = m2.Child(0)
		          c = m2.Value("text")
		          ChatMessages.AppendMessage(r.Trim, c.Trim, mLastResponse, mImageFiles)
		        ElseIf UBound(mImageURLs) > -1 Then
		          m2 = m2.Value("content")
		          m2 = m2.Child(0)
		          c = m2.Value("text")
		          ChatMessages.AppendMessage(r.Trim, c.Trim, mLastResponse, mImageURLs)
		        Else
		          c = m2.Value("content")
		          ChatMessages.AppendMessage(r.Trim, c.Trim, mLastResponse)
		        End If
		      End If
		      If m1 <> Nil Then
		        Dim r, c As String
		        r = m1.Value("role")
		        c = m1.Value("content")
		        ChatMessages.AppendMessage(r.Trim, c.Trim, mLastResponse)
		      End If
		    End If
		    mTokenCount = mTokenCount + mLastResponse.TotalTokenCount
		    Self.Title = "AI Assistant Chat - " + mModel.ID + " (" + Format(mTokenCount, "###,##0") + " tokens consumed)"
		  End If
		  SendMsgBtn.Enabled = True
		  SendMsgBtn.Caption = "Send"
		  ReDim mImageFiles(-1)
		  ReDim mImageURLs(-1)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ChatMessages
	#tag Event
		Sub ClickLink(URL As String)
		  ShowURL(URL)
		End Sub
	#tag EndEvent
	#tag Event
		Sub ClickFileLink(File As FolderItem)
		  File.Parent.Launch()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ImageContent
	#tag Event
		Sub Open()
		  Me.AcceptFileDrop(UploadabeFileTypes.AllImageTypes)
		  Me.AcceptTextDrop()
		End Sub
	#tag EndEvent
	#tag Event
		Sub DropObject(obj As DragItem, action As Integer)
		  #pragma Unused action
		  Do
		    If obj.FolderItemAvailable Then
		      ReDim mImageURLs(-1)
		      Dim f As FolderItem = obj.FolderItem
		      If f.Exists Then mImageFiles.Append(f)
		    ElseIf obj.TextAvailable Then
		      ReDim mImageFiles(-1)
		      Dim s As String = obj.Text
		      If NthField(s, "://", 1).Lowercase = "https" Then mImageURLs.Append(s)
		    End If
		  Loop Until Not obj.NextItem()
		  
		  Dim txt As String
		  If UBound(mImageURLs) > -1 Then
		    txt = Join(mImageURLs, "; ")
		    ImageCountLbl.Text = Str(UBound(mImageURLs) + 1) + " image(s)"
		  ElseIf UBound(mImageFiles) > -1 Then
		    Dim s() As String
		    For i As Integer = 0 To UBound(mImageFiles)
		      s.Append(mImageFiles(i).Name)
		    Next
		    txt = Join(s, "; ")
		    ImageCountLbl.Text = Str(UBound(mImageFiles) + 1) + " image(s)"
		  End If
		  mLockImageList = True
		  Try
		    ImageContent.Text = txt
		  Finally
		    mLockImageList = False
		  End Try
		End Sub
	#tag EndEvent
	#tag Event
		Sub TextChange()
		  If mLockImageList Then Return
		  Dim urls() As String = Split(Me.Text, ";")
		  For i As Integer = UBound(urls) DownTo 0
		    urls(i) = urls(i).Trim
		    If urls(i).Left(4) <> "http" Then urls.Remove(i)
		  Next
		  If UBound(urls) > -1 Then
		    mImageURLs = urls
		    ReDim mImageFiles(-1)
		    ImageCountLbl.Text = Str(UBound(urls) + 1) + " image(s)"
		  End If
		  
		End Sub
	#tag EndEvent
#tag EndEvents
