VERSION 5.00
Object = "{248DD890-BB45-11CF-9ABC-0080C7E7B78D}#1.0#0"; "MSWINSCK.OCX"
Object = "{6B7E6392-850A-101B-AFC0-4210102A8DA7}#1.3#0"; "COMCTL32.OCX"
Begin VB.Form Form1 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "PC Software for Ethernet Relay - V1.1"
   ClientHeight    =   4815
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   5655
   Icon            =   "MainForm.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   ScaleHeight     =   4815
   ScaleWidth      =   5655
   StartUpPosition =   3  'Windows Default
   Begin VB.CheckBox Check2 
      Caption         =   "Simulate key press"
      Height          =   435
      Left            =   2520
      TabIndex        =   21
      Top             =   2080
      Width           =   2535
   End
   Begin VB.CheckBox Check1 
      Caption         =   "Jog"
      Height          =   435
      Left            =   1440
      TabIndex        =   7
      Top             =   2080
      Width           =   855
   End
   Begin VB.TextBox edtReceive 
      BackColor       =   &H80000018&
      Enabled         =   0   'False
      Height          =   375
      Left            =   1800
      TabIndex        =   18
      Top             =   3120
      Width           =   3375
   End
   Begin MSWinsockLib.Winsock sckTCP 
      Left            =   4560
      Top             =   0
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   393216
      RemotePort      =   6722
   End
   Begin ComctlLib.StatusBar StatusBar1 
      Align           =   2  'Align Bottom
      Height          =   375
      Left            =   0
      TabIndex        =   17
      Top             =   4440
      Width           =   5655
      _ExtentX        =   9975
      _ExtentY        =   661
      Style           =   1
      SimpleText      =   ""
      _Version        =   327682
      BeginProperty Panels {0713E89E-850A-101B-AFC0-4210102A8DA7} 
         NumPanels       =   1
         BeginProperty Panel1 {0713E89F-850A-101B-AFC0-4210102A8DA7} 
            Object.Tag             =   ""
         EndProperty
      EndProperty
   End
   Begin VB.CommandButton btnExit 
      Caption         =   "Exit"
      Height          =   375
      Left            =   3600
      TabIndex        =   11
      Top             =   3840
      Width           =   1215
   End
   Begin VB.CommandButton btnSendData 
      Caption         =   "Send"
      Height          =   375
      Left            =   2160
      TabIndex        =   10
      Top             =   3840
      Width           =   1215
   End
   Begin VB.CommandButton btnConnect 
      Caption         =   "Connect"
      Height          =   375
      Left            =   720
      TabIndex        =   9
      Top             =   3840
      Width           =   1215
   End
   Begin VB.TextBox edtSendText 
      BackColor       =   &H80000018&
      Enabled         =   0   'False
      Height          =   375
      Left            =   1800
      TabIndex        =   8
      Top             =   2640
      Width           =   3375
   End
   Begin VB.TextBox edtDelay 
      Height          =   375
      Left            =   1440
      TabIndex        =   6
      Text            =   "0"
      Top             =   1620
      Width           =   855
   End
   Begin VB.ComboBox cbOperation 
      Height          =   315
      ItemData        =   "MainForm.frx":2CFA
      Left            =   1440
      List            =   "MainForm.frx":2D37
      Style           =   2  'Dropdown List
      TabIndex        =   5
      Top             =   1170
      Width           =   1935
   End
   Begin VB.TextBox edtPort 
      BackColor       =   &H80000018&
      Enabled         =   0   'False
      Height          =   375
      Left            =   4440
      TabIndex        =   4
      Top             =   600
      Width           =   975
   End
   Begin VB.TextBox edtServerAddr 
      Height          =   375
      Left            =   1440
      TabIndex        =   3
      Text            =   "192.168.1.100"
      Top             =   600
      Width           =   1935
   End
   Begin VB.OptionButton rbUDP 
      Caption         =   "UDP"
      Height          =   255
      Left            =   2400
      TabIndex        =   2
      Top             =   240
      Width           =   975
   End
   Begin VB.OptionButton rbTCP 
      Caption         =   "TCP"
      Height          =   255
      Left            =   1440
      TabIndex        =   1
      Top             =   240
      Value           =   -1  'True
      Width           =   855
   End
   Begin MSWinsockLib.Winsock sckUDP 
      Left            =   5040
      Top             =   0
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   393216
      Protocol        =   1
      RemotePort      =   6723
   End
   Begin VB.Label Label6 
      Caption         =   "second(s), keep state if 0"
      Height          =   255
      Left            =   2400
      TabIndex        =   20
      Top             =   1680
      Width           =   1935
   End
   Begin VB.Label Label8 
      Caption         =   "Text Received"
      Height          =   255
      Left            =   240
      TabIndex        =   19
      Top             =   3180
      Width           =   1455
   End
   Begin VB.Label Label7 
      Caption         =   "Text To Send"
      Height          =   255
      Left            =   240
      TabIndex        =   16
      Top             =   2700
      Width           =   1455
   End
   Begin VB.Label Label5 
      Caption         =   "Duration"
      Height          =   255
      Left            =   240
      TabIndex        =   15
      Top             =   1680
      Width           =   1095
   End
   Begin VB.Label Label4 
      Caption         =   "Operation"
      Height          =   255
      Left            =   240
      TabIndex        =   14
      Top             =   1200
      Width           =   975
   End
   Begin VB.Label Label3 
      Caption         =   "Port"
      Height          =   255
      Left            =   3600
      TabIndex        =   13
      Top             =   660
      Width           =   735
   End
   Begin VB.Label Label2 
      Caption         =   "IP Addr"
      Height          =   255
      Left            =   240
      TabIndex        =   12
      Top             =   660
      Width           =   1095
   End
   Begin VB.Label Label1 
      Caption         =   "Mode"
      Height          =   255
      Left            =   240
      TabIndex        =   0
      Top             =   240
      Width           =   975
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Function PrepareSendText(ShowMsg As Boolean)

Dim txtDelay As String

    PrepareSendText = False

    txtDelay = Trim(edtDelay.Text)
    If ShowMsg Then
        If txtDelay = "" Then
            txtDelay = "0"
        End If
        
        If Not IsNumeric(txtDelay) Then
            MsgBox "Duration should be an integer between 1 and 65535"
            edtDelay.SetFocus
            Exit Function
        End If
        
        If CLng(txtDelay) > 65535 Then
            MsgBox "Duration should be an integer between 1 and 65535"
            edtDelay.SetFocus
            Exit Function
        End If
        
        edtDelay.Text = CStr(CLng(txtDelay))
    End If
      
    Select Case cbOperation.ListIndex
        Case 0
            edtSendText.Text = "00"
        Case 1
            edtSendText.Text = "11"
        Case 2
            edtSendText.Text = "21"
        Case 3
            edtSendText.Text = "12"
        Case 4
            edtSendText.Text = "22"
        Case 5
            edtSendText.Text = "13"
        Case 6
            edtSendText.Text = "23"
        Case 7
            edtSendText.Text = "14"
        Case 8
            edtSendText.Text = "24"
        Case 9
            edtSendText.Text = "15"
        Case 10
            edtSendText.Text = "25"
        Case 11
            edtSendText.Text = "16"
        Case 12
            edtSendText.Text = "26"
        Case 13
            edtSendText.Text = "17"
        Case 14
            edtSendText.Text = "27"
        Case 15
            edtSendText.Text = "18"
        Case 16
            edtSendText.Text = "28"
        Case 17
            edtSendText.Text = "1X"
        Case 18
            edtSendText.Text = "2X"
    End Select
  
    If Check1.Value Then
        If cbOperation.ListIndex Mod 2 <> 0 Then
            edtSendText.Text = edtSendText.Text + "*"
        End If
    Else
        If Check2.Value Then
            If cbOperation.ListIndex Mod 2 <> 0 Then
                edtSendText.Text = edtSendText.Text + "K"
            End If
        Else
            If txtDelay <> "" Then
                If IsNumeric(txtDelay) Then
                    If (CLng(txtDelay) > 0) And (CLng(txtDelay) < 65536) Then
                        If cbOperation.ListIndex <> 0 Then
                            edtSendText.Text = edtSendText.Text + ":" + CStr(CLng(txtDelay))
                        End If
                    End If
                End If
            End If
        End If
    End If
    
    PrepareSendText = True
End Function

Private Sub btnConnect_Click()

On Error GoTo Except
  
    If rbTCP.Value Then
        If sckTCP.State <> 0 Then
            sckTCP.Close
            StatusBar1.SimpleText = "Not connected"
            btnConnect.Caption = "Connect"
            
            rbTCP.Enabled = True
            rbUDP.Enabled = True
            btnSendData.Enabled = False
        Else
            sckTCP.RemoteHost = edtServerAddr.Text
            sckTCP.Connect
            btnConnect.Caption = "Disconnect"
            
            rbTCP.Enabled = False
            rbUDP.Enabled = False
        End If
    Else
        btnConnect.Enabled = False
    End If

    Exit Sub

Except:
    MsgBox "Wrong parameters"
    On Error GoTo 0
End Sub

Private Sub btnExit_Click()
    Unload Me
End Sub

Private Sub btnSendData_Click()
    If Not PrepareSendText(True) Then
       Exit Sub
    End If
    
    If rbTCP.Value Then
        If sckTCP.State = 7 Then
            sckTCP.SendData edtSendText.Text
        Else
            MsgBox "Not connected"
        End If
    Else
        If cbOperation.ListIndex = 0 Then
            MsgBox "UDP mode does not support retrieving relay status"
            cbOperation.SetFocus
        Else
            sckUDP.RemoteHost = edtServerAddr.Text
            sckUDP.Bind
            sckUDP.SendData edtSendText.Text
            sckUDP.Close
        End If
    End If
End Sub

Private Sub cbOperation_Click()
    PrepareSendText False
End Sub

Private Sub Check1_Click()
    If Check1.Value Then
        Check2.Value = False
        edtDelay.Enabled = False
    Else
        edtDelay.Enabled = True
    End If

    PrepareSendText False
End Sub

Private Sub Check2_Click()
    If Check2.Value Then
        Check1.Value = False
        edtDelay.Enabled = False
    Else
        edtDelay.Enabled = True
    End If

    PrepareSendText False
End Sub

Private Sub edtDelay_Change()
    PrepareSendText False
End Sub

Private Sub Form_Load()

On Error Resume Next

Dim wss As Object
Dim codetest As String
    Set wss = CreateObject("WScript.Shell")
    codetest = wss.RegRead("HKCU\Software\Lee Software\SR-201\Remote Address")
    If codetest <> "" Then
        edtServerAddr.Text = codetest
    End If
    Set wss = Nothing

    rbTCP_Click
    cbOperation.ListIndex = 0
    cbOperation_Click
    
On Error GoTo 0

End Sub

Private Sub Form_Unload(Cancel As Integer)

Dim wss As Object

    sckTCP.Close
    
    Set wss = CreateObject("WScript.Shell")
    wss.RegWrite "HKCU\Software\Lee Software\SR-201\Remote Address", edtServerAddr.Text, "REG_SZ"
    Set wss = Nothing
End Sub

Private Sub rbTCP_Click()

    edtPort.Text = CStr(sckTCP.RemotePort)
    btnConnect.Enabled = True
    btnSendData.Enabled = False
    StatusBar1.SimpleText = "Not connected"
    Label8.Visible = True
    edtReceive.Visible = True
End Sub

Private Sub rbUDP_Click()

    edtPort.Text = CStr(sckUDP.RemotePort)
    btnConnect.Enabled = False
    btnSendData.Enabled = True
    StatusBar1.SimpleText = "Send command via UDP, no response will be received"
    Label8.Visible = False
    edtReceive.Visible = False
End Sub

Private Sub sckTCP_Close()

  If rbTCP.Value Then
  
    rbTCP.Enabled = True
    rbUDP.Enabled = True
    btnConnect.Caption = "Connect"
    btnSendData.Enabled = False
    StatusBar1.SimpleText = "Disconnected"
  End If
End Sub

Private Sub sckTCP_Connect()
    
    btnSendData.Enabled = True
    StatusBar1.SimpleText = "Connected"
End Sub

Private Sub sckTCP_DataArrival(ByVal bytesTotal As Long)

Dim ReceiveMsg() As Byte

    ReDim ReceiveMsg(bytesTotal)
    sckTCP.GetData ReceiveMsg
    
    edtReceive.Text = ""
    For i = 0 To bytesTotal - 1
        edtReceive.Text = edtReceive.Text + Chr(ReceiveMsg(i))
    Next
End Sub
