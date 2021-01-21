Type=Activity
Version=3
@EndOfDesignText@
#Region  Activity Attributes 
	#FullScreen: False
	#IncludeTitle: True
#End Region

Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.

End Sub

Sub Globals
	'These global variables will be redeclared each time the activity is created.
	'These variables can only be accessed from this module.
	Dim EditText1 As EditText
	Dim CheckBox1 As CheckBox
End Sub

Sub Activity_Create(FirstTime As Boolean)
	'Do not forget to load the layout file created with the visual designer. For example:
	Activity.LoadLayout("Settings")
	EditText1.Text = Main.HostName	
	CheckBox1.Checked = Main.ViewExtChs
End Sub

Sub Activity_Resume

End Sub

Sub Activity_Pause (UserClosed As Boolean)

End Sub

Sub Button2_Click
	Activity.Finish
End Sub

Sub Button1_Click
	Dim s As List

	Main.HostName = EditText1.Text
	Main.ViewExtChs = CheckBox1.Checked

	s.Initialize
	s.Add(Main.HostName)
	If Main.ViewExtChs Then
		s.Add("Y")
	Else
		s.Add("N")
	End If
	File.WriteList(File.DirInternal, "AppSettings", s)
	
	Activity.Finish
End Sub