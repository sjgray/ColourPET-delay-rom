VERSION 5.00
Begin VB.Form frmMain 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "ColourPET delay EPROM generator"
   ClientHeight    =   1590
   ClientLeft      =   45
   ClientTop       =   390
   ClientWidth     =   6795
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   1590
   ScaleWidth      =   6795
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton cmdAbout 
      Caption         =   "&About"
      Height          =   525
      Left            =   3420
      TabIndex        =   7
      Top             =   150
      Width           =   1365
   End
   Begin VB.CommandButton cmdStart 
      Caption         =   "&START"
      Height          =   1335
      Left            =   4920
      TabIndex        =   6
      Top             =   150
      Width           =   1785
   End
   Begin VB.TextBox txtOutput 
      Height          =   315
      Left            =   2670
      TabIndex        =   5
      Text            =   "eprom.bin"
      Top             =   1140
      Width           =   1965
   End
   Begin VB.TextBox txtData 
      Height          =   315
      Left            =   2700
      TabIndex        =   3
      Text            =   "8"
      Top             =   600
      Width           =   405
   End
   Begin VB.TextBox txtRows 
      Height          =   315
      Left            =   2700
      TabIndex        =   1
      Text            =   "3"
      Top             =   180
      Width           =   405
   End
   Begin VB.Label Label3 
      AutoSize        =   -1  'True
      Caption         =   "Name of output file (cur directory):"
      Height          =   195
      Left            =   120
      TabIndex        =   4
      Top             =   1200
      Width           =   2385
   End
   Begin VB.Label Label2 
      AutoSize        =   -1  'True
      Caption         =   "How many DATA lines (usually 8)?"
      Height          =   195
      Left            =   120
      TabIndex        =   2
      Top             =   660
      Width           =   2430
   End
   Begin VB.Label Label1 
      AutoSize        =   -1  'True
      Caption         =   "How many ROW lines (3-4)?"
      Height          =   195
      Left            =   120
      TabIndex        =   0
      Top             =   210
      Width           =   2010
   End
End
Attribute VB_Name = "frmMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
' ColourPET Delay EPROM Generator V1.0 (C)2016 Steve J. Gray
' =============================== Jun 25, 2016. Last update Jun 25, 2016
'
' Ok, not exactly a work of art, but it saves creating it by hand
' This program prompts for the number of row and data values and makes a binary file that can be used on ColourPET+ boards.
' The eprom is used for delay as well as a secondary video option, which is why the ROW option is needed. When used for delay only
' the ROW lines will normally be ignored but need to be accounted for.
'
' ROW  - normally 3 for 8-pixel tall character but could be 4 for 16-pixel tall option (ie: CBM-II format)
' DATA - normally 8 for 256 possible values. For ColourPET this is 4-bit foreground plus 4-bit background colour mode.

Private Sub cmdStart_Click()
    Dim R As Integer, D As Integer
    Dim i As Integer, j As Integer
    
    Open txtOutput For Output As 1
    
    R = 2 ^ (Val(txtRows.Text)) - 1 'How many rows, normally 3=2^3=8 pixel tall characters
    D = 2 ^ (Val(txtData.Text)) - 1 'How many data lines, normaly 8=2^8=256 characters or colors
    
    For i = 0 To D
        For j = 0 To R
            Print #1, Chr$(i);
        Next j
    Next i
    
    Close 1
    MsgBox "File sucessfully created!"
    
End Sub
