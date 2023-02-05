#tag Window
Begin Window ModelInfoWindow
   BackColor       =   &hFFFFFF
   Backdrop        =   ""
   CloseButton     =   True
   Composite       =   False
   Frame           =   1
   FullScreen      =   False
   HasBackColor    =   False
   Height          =   1.75e+2
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
      Height          =   175
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
End
#tag EndWindow

#tag WindowCode
	#tag Method, Flags = &h0
		Sub ShowModel(Model As OpenAI.Model)
		  ModelInfoList.DeleteAllRows()
		  Dim props() As Introspection.PropertyInfo = Introspection.GetType(Model).GetProperties()
		  For i As Integer = 0 To UBound(props)
		    If props(i).IsPublic Then
		      Try
		        Dim vle As Variant = props(i).Value(Model)
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


#tag EndWindowCode

