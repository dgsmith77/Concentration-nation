VERSION 5.00
Begin VB.Form frmTest 
   Caption         =   "Control array test"
   ClientHeight    =   3555
   ClientLeft      =   120
   ClientTop       =   465
   ClientWidth     =   4560
   LinkTopic       =   "Form1"
   ScaleHeight     =   3555
   ScaleWidth      =   4560
   StartUpPosition =   3  'Windows Default
   Begin VB.Image defImg 
      Height          =   720
      Left            =   240
      Picture         =   "frmTest.frx":0000
      Top             =   3720
      Width           =   720
   End
   Begin VB.Image MyImages 
      Height          =   720
      Index           =   0
      Left            =   240
      Picture         =   "frmTest.frx":05D5
      Top             =   240
      Width           =   720
   End
End
Attribute VB_Name = "frmTest"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Const defTag = 51

Private Sub Form_Load()
    Call CreateImageArray
End Sub

'function to create the image array
Private Sub CreateImageArray()
    Dim x As Integer
    
    For x = 1 To 15
        Load MyImages(x)
        If x Mod 4 <> 0 Then
            MyImages(x).Left = MyImages(x - 1).Left + MyImages(x - 1).Width + 100
            MyImages(x).Top = MyImages(x - 1).Top
        Else
            MyImages(x).Top = MyImages(x - 1).Top + MyImages(x - 1).Height + 100
            MyImages(x).Left = MyImages(0).Left
        End If
        MyImages(x).Visible = True
        MyImages(x).Picture = defImg.Picture
        MyImages(x).Tag = defTag
    Next
End Sub
