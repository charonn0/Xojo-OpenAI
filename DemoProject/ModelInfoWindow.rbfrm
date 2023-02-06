#tag Window
Begin Window ModelInfoWindow
   BackColor       =   &hFFFFFF
   Backdrop        =   ""
   CloseButton     =   True
   Composite       =   False
   Frame           =   1
   FullScreen      =   False
   HasBackColor    =   False
   Height          =   2.66e+2
   ImplicitInstance=   True
   LiveResize      =   True
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   False
   MaxWidth        =   32000
   MenuBar         =   ""
   MenuBarVisible  =   True
   MinHeight       =   64
   MinimizeButton  =   False
   MinWidth        =   64
   Placement       =   1
   Resizeable      =   False
   Title           =   "Xojo-OpenAI - Model Detail"
   Visible         =   True
   Width           =   3.62e+2
   Begin Listbox ModelInfoList
      AutoDeactivate  =   True
      AutoHideScrollbars=   True
      Bold            =   ""
      Border          =   True
      ColumnCount     =   2
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
      Height          =   266
      HelpTag         =   ""
      Hierarchical    =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   "Key	Value"
      Italic          =   ""
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      RequiresSelection=   ""
      Scope           =   0
      ScrollbarHorizontal=   ""
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
      Width           =   362
      _ScrollWidth    =   -1
   End
   Begin PushButton CloseBtn
      AutoDeactivate  =   True
      Bold            =   ""
      ButtonStyle     =   0
      Cancel          =   True
      Caption         =   "Close"
      Default         =   True
      Enabled         =   True
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   ""
      Left            =   141
      LockBottom      =   ""
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   ""
      LockTop         =   True
      Scope           =   0
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0
      TextUnit        =   0
      Top             =   -57
      Underline       =   ""
      Visible         =   True
      Width           =   80
   End
End
#tag EndWindow

#tag WindowCode
	#tag Method, Flags = &h0
		Sub ShowModel(Model As OpenAI.Model)
		  ModelInfoList.DeleteAllRows()
		  mModel = Model
		  Dim props() As Introspection.PropertyInfo = Introspection.GetType(mModel).GetProperties()
		  For i As Integer = 0 To UBound(props)
		    If props(i).IsPublic Then
		      Try
		        Dim vle As Variant = props(i).Value(mModel)
		        Select Case vle
		        Case IsA OpenAI.Model
		          Dim mdl As OpenAI.Model = vle
		          ModelInfoList.AddRow(props(i).Name, mdl.ID)
		        Else
		          ModelInfoList.AddRow(props(i).Name, vle.StringValue)
		        End Select
		      Catch
		      End Try
		    End If
		  Next
		  Me.ShowModal()
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mModel As OpenAI.Model
	#tag EndProperty


#tag EndWindowCode

#tag Events ModelInfoList
	#tag Event
		Function ConstructContextualMenu(base as MenuItem, x as Integer, y as Integer) As Boolean
		  #pragma Unused x
		  #pragma Unused y
		  base.Append(New MenuItem("Save to disk..."))
		  Return True
		End Function
	#tag EndEvent
	#tag Event
		Function ContextualMenuAction(hitItem as MenuItem) As Boolean
		  Select Case hitItem.Text
		  Case "Save to disk..."
		    Dim file As FolderItem = GetSaveFolderItem("", mModel.ID + ".json")
		    If file <> Nil Then
		      Dim bs As BinaryStream = BinaryStream.Create(file)
		      Dim data As String = mModel.ToString()
		      bs.Write(data)
		      bs.Close()
		      Return True
		    End If
		  End Select
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events CloseBtn
	#tag Event
		Sub Action()
		  Self.Close()
		End Sub
	#tag EndEvent
#tag EndEvents
