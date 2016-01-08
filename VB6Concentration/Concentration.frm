VERSION 5.00
Begin VB.Form Concentration 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "VB6 Concentration"
   ClientHeight    =   4560
   ClientLeft      =   150
   ClientTop       =   795
   ClientWidth     =   3615
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   Picture         =   "Concentration.frx":0000
   ScaleHeight     =   4560
   ScaleWidth      =   3615
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton btnRestart 
      Caption         =   "Start New Game"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   180
      TabIndex        =   1
      Top             =   3960
      Width           =   3255
   End
   Begin VB.Image defImg 
      Height          =   720
      Left            =   2760
      Picture         =   "Concentration.frx":1111B
      Top             =   5760
      Visible         =   0   'False
      Width           =   720
   End
   Begin VB.Image Animals 
      Height          =   720
      Index           =   49
      Left            =   2280
      Picture         =   "Concentration.frx":116F0
      Top             =   5880
      Width           =   720
   End
   Begin VB.Image Animals 
      Height          =   720
      Index           =   48
      Left            =   120
      Picture         =   "Concentration.frx":11B7C
      Top             =   6120
      Width           =   720
   End
   Begin VB.Image Animals 
      Height          =   720
      Index           =   47
      Left            =   2520
      Picture         =   "Concentration.frx":1209E
      Top             =   5760
      Width           =   720
   End
   Begin VB.Image Animals 
      Height          =   720
      Index           =   46
      Left            =   2040
      Picture         =   "Concentration.frx":1255D
      Top             =   5760
      Visible         =   0   'False
      Width           =   720
   End
   Begin VB.Image Animals 
      Height          =   720
      Index           =   45
      Left            =   1680
      Picture         =   "Concentration.frx":12AC3
      Top             =   5760
      Width           =   720
   End
   Begin VB.Image Animals 
      Height          =   720
      Index           =   44
      Left            =   1200
      Picture         =   "Concentration.frx":12F7F
      Top             =   5880
      Width           =   720
   End
   Begin VB.Image Animals 
      Height          =   720
      Index           =   43
      Left            =   840
      Picture         =   "Concentration.frx":134B1
      Top             =   5880
      Width           =   720
   End
   Begin VB.Image Animals 
      Height          =   720
      Index           =   42
      Left            =   600
      Picture         =   "Concentration.frx":13B6C
      Top             =   5880
      Width           =   720
   End
   Begin VB.Image Animals 
      Height          =   720
      Index           =   41
      Left            =   120
      Picture         =   "Concentration.frx":13F79
      Top             =   5880
      Width           =   720
   End
   Begin VB.Image Animals 
      Height          =   720
      Index           =   40
      Left            =   2880
      Picture         =   "Concentration.frx":145F4
      Top             =   5520
      Width           =   720
   End
   Begin VB.Image Animals 
      Height          =   720
      Index           =   39
      Left            =   2160
      Picture         =   "Concentration.frx":14C39
      Top             =   5640
      Width           =   720
   End
   Begin VB.Image Animals 
      Height          =   720
      Index           =   38
      Left            =   1800
      Picture         =   "Concentration.frx":1510A
      Top             =   5520
      Width           =   720
   End
   Begin VB.Image Animals 
      Height          =   720
      Index           =   37
      Left            =   1080
      Picture         =   "Concentration.frx":15662
      Top             =   5520
      Width           =   720
   End
   Begin VB.Image Animals 
      Height          =   720
      Index           =   36
      Left            =   600
      Picture         =   "Concentration.frx":15C83
      Top             =   5520
      Width           =   720
   End
   Begin VB.Image Animals 
      Height          =   720
      Index           =   35
      Left            =   120
      Picture         =   "Concentration.frx":16258
      Top             =   5640
      Width           =   720
   End
   Begin VB.Image Animals 
      Height          =   720
      Index           =   34
      Left            =   3000
      Picture         =   "Concentration.frx":1685F
      Top             =   5520
      Width           =   720
   End
   Begin VB.Image Animals 
      Height          =   720
      Index           =   33
      Left            =   2640
      Picture         =   "Concentration.frx":16DE3
      Top             =   5640
      Width           =   720
   End
   Begin VB.Image Animals 
      Height          =   720
      Index           =   32
      Left            =   2160
      Picture         =   "Concentration.frx":173E1
      Top             =   5400
      Width           =   720
   End
   Begin VB.Image Animals 
      Height          =   720
      Index           =   31
      Left            =   1560
      Picture         =   "Concentration.frx":179CB
      Top             =   5520
      Width           =   720
   End
   Begin VB.Image Animals 
      Height          =   720
      Index           =   30
      Left            =   840
      Picture         =   "Concentration.frx":17E18
      Top             =   5400
      Width           =   720
   End
   Begin VB.Image Animals 
      Height          =   720
      Index           =   29
      Left            =   480
      Picture         =   "Concentration.frx":18402
      Top             =   5400
      Width           =   720
   End
   Begin VB.Image Animals 
      Height          =   720
      Index           =   28
      Left            =   120
      Picture         =   "Concentration.frx":18A39
      Top             =   5400
      Width           =   720
   End
   Begin VB.Image Animals 
      Height          =   720
      Index           =   27
      Left            =   2880
      Picture         =   "Concentration.frx":1905A
      Top             =   5400
      Width           =   720
   End
   Begin VB.Image Animals 
      Height          =   720
      Index           =   26
      Left            =   2640
      Picture         =   "Concentration.frx":195DF
      Top             =   5400
      Width           =   720
   End
   Begin VB.Image Animals 
      Height          =   720
      Index           =   25
      Left            =   2280
      Picture         =   "Concentration.frx":19A7C
      Top             =   5400
      Width           =   720
   End
   Begin VB.Image Animals 
      Height          =   720
      Index           =   24
      Left            =   1920
      Picture         =   "Concentration.frx":1A116
      Top             =   5520
      Width           =   720
   End
   Begin VB.Image Animals 
      Height          =   720
      Index           =   23
      Left            =   1680
      Picture         =   "Concentration.frx":1A7F3
      Top             =   5400
      Width           =   720
   End
   Begin VB.Image Animals 
      Height          =   720
      Index           =   22
      Left            =   1440
      Picture         =   "Concentration.frx":1AD9D
      Top             =   5400
      Width           =   720
   End
   Begin VB.Image Animals 
      Height          =   720
      Index           =   21
      Left            =   960
      Picture         =   "Concentration.frx":1B20A
      Top             =   5520
      Width           =   720
   End
   Begin VB.Image Animals 
      Height          =   720
      Index           =   20
      Left            =   360
      Picture         =   "Concentration.frx":1B85A
      Top             =   5280
      Width           =   720
   End
   Begin VB.Image Animals 
      Height          =   720
      Index           =   19
      Left            =   0
      Picture         =   "Concentration.frx":1BF68
      Top             =   5280
      Width           =   720
   End
   Begin VB.Image Animals 
      Height          =   720
      Index           =   18
      Left            =   3000
      Picture         =   "Concentration.frx":1C584
      Top             =   5160
      Width           =   720
   End
   Begin VB.Image Animals 
      Height          =   720
      Index           =   17
      Left            =   2640
      Picture         =   "Concentration.frx":1C9BD
      Top             =   5280
      Width           =   720
   End
   Begin VB.Image Animals 
      Height          =   720
      Index           =   16
      Left            =   2160
      Picture         =   "Concentration.frx":1D074
      Top             =   5040
      Width           =   720
   End
   Begin VB.Image Animals 
      Height          =   720
      Index           =   15
      Left            =   1800
      Picture         =   "Concentration.frx":1D4DF
      Top             =   5160
      Width           =   720
   End
   Begin VB.Image Animals 
      Height          =   720
      Index           =   14
      Left            =   1320
      Picture         =   "Concentration.frx":1DB1A
      Top             =   5160
      Width           =   720
   End
   Begin VB.Image Animals 
      Height          =   720
      Index           =   13
      Left            =   840
      Picture         =   "Concentration.frx":1E0C9
      Top             =   5160
      Width           =   720
   End
   Begin VB.Image Animals 
      Height          =   720
      Index           =   12
      Left            =   480
      Picture         =   "Concentration.frx":1E669
      Top             =   5160
      Width           =   720
   End
   Begin VB.Image Animals 
      Height          =   720
      Index           =   11
      Left            =   120
      Picture         =   "Concentration.frx":1EB7B
      Top             =   5040
      Width           =   720
   End
   Begin VB.Image Animals 
      Height          =   720
      Index           =   10
      Left            =   2880
      Picture         =   "Concentration.frx":1EFB0
      Top             =   4920
      Width           =   720
   End
   Begin VB.Image Animals 
      Height          =   720
      Index           =   9
      Left            =   2640
      Picture         =   "Concentration.frx":1F5AA
      Top             =   4920
      Width           =   720
   End
   Begin VB.Image Animals 
      Height          =   720
      Index           =   8
      Left            =   2400
      Picture         =   "Concentration.frx":1FA30
      Top             =   4680
      Width           =   720
   End
   Begin VB.Image Animals 
      Height          =   720
      Index           =   7
      Left            =   2160
      Picture         =   "Concentration.frx":2005D
      Top             =   4800
      Width           =   720
   End
   Begin VB.Image Animals 
      Height          =   720
      Index           =   6
      Left            =   1800
      Picture         =   "Concentration.frx":206E7
      Top             =   4920
      Width           =   720
   End
   Begin VB.Image Animals 
      Height          =   720
      Index           =   5
      Left            =   1560
      Picture         =   "Concentration.frx":20AE9
      Top             =   4800
      Width           =   720
   End
   Begin VB.Image Animals 
      Height          =   720
      Index           =   4
      Left            =   1200
      Picture         =   "Concentration.frx":210FB
      Top             =   4800
      Visible         =   0   'False
      Width           =   720
   End
   Begin VB.Image Animals 
      Height          =   720
      Index           =   3
      Left            =   960
      Picture         =   "Concentration.frx":2178B
      Top             =   4800
      Width           =   720
   End
   Begin VB.Image Animals 
      Height          =   720
      Index           =   2
      Left            =   720
      Picture         =   "Concentration.frx":21CEE
      Top             =   4680
      Width           =   720
   End
   Begin VB.Image Animals 
      Height          =   720
      Index           =   1
      Left            =   360
      Picture         =   "Concentration.frx":2237C
      Top             =   4800
      Visible         =   0   'False
      Width           =   720
   End
   Begin VB.Image Animals 
      Height          =   720
      Index           =   0
      Left            =   120
      Picture         =   "Concentration.frx":22A14
      Top             =   4680
      Width           =   720
   End
   Begin VB.Image Images 
      Height          =   720
      Index           =   0
      Left            =   180
      Picture         =   "Concentration.frx":22DD7
      Top             =   480
      Width           =   720
   End
   Begin VB.Label lblMoves 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "0 Moves"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Left            =   180
      TabIndex        =   0
      Top             =   165
      Width           =   885
   End
   Begin VB.Menu mnuFile 
      Caption         =   "&File"
      Begin VB.Menu mnuExit 
         Caption         =   "E&xit"
      End
   End
End
Attribute VB_Name = "Concentration"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

'Constants
Const defTag = 51
Const totalImages = 16
Const totalPics = 50
'Global variables
Private names() As Variant
Private scrambled() As Variant
Private NameIndexes As Variant
Private prevIndex As Integer
Private uncovered As Integer
Private showing As Integer
Private imgPath As String
'int to count the moves
Private moves As Integer
Private initMoves As String
Private myMove As String
Private myMoves As String
'delay to close message box (milliseconds)
Private DELAY As Integer
'for delay
Private Declare Sub Sleep Lib "kernel32" (ByVal dwMilliseconds As Long)
'function to create the image array
Private Sub CreateImageArray()
    Dim x As Integer
    
    For x = 1 To 15
        Load Images(x)
        If x Mod 4 <> 0 Then
            Images(x).Left = Images(x - 1).Left + Images(x - 1).Width + 100
            Images(x).Top = Images(x - 1).Top
        Else
            Images(x).Top = Images(x - 1).Top + Images(x - 1).Height + 100
            Images(x).Left = Images(0).Left
        End If
        Images(x).Visible = True
        Images(x).Picture = defImg.Picture
        Images(x).Tag = defTag
    Next
End Sub

'function to select 8 names from the picset array
Private Sub SelectNames()
    Dim usedIndices(8) As Integer
    Dim i As Integer
    Dim j As Integer
    Dim k As Integer
    Dim Found As Boolean
    
    i = 0
    Do
        Call Randomize
        j = Int(totalPics * Rnd())
        Found = False
        For k = LBound(usedIndices) To UBound(usedIndices)
          If usedIndices(k) = j Then
            Found = True
            Exit For
          End If
        Next
        If (names(i) = -1 And Not Found) Then
            usedIndices(i) = j
            names(i) = NameIndexes(j)
            names(i + 8) = NameIndexes(j)
            i = i + 1
        End If
    Loop While (i <= 7)
End Sub

'function to scramble the names array
Private Sub ScrambleNames()
    Dim i As Integer
    Dim j As Integer
    
    i = 0
    Do
        j = Int(totalImages * Rnd())
        If (scrambled(j) = -1) Then
            scrambled(j) = names(i)
            i = i + 1
        End If
    Loop While (i <= 15)
End Sub

Public Sub ShowImage(index As Integer)
    Dim i As Integer
    
    Images(index).Picture = Animals(scrambled(index)).Picture
    Images(index).Tag = index

    'check for images that aren't the default
    'to prevent double clicking
    showing = 0
    For i = 0 To Images.Count - 1
        Dim intToAdd As Integer
        If Images(i).Tag = defTag Then
            intToAdd = 1
        Else
            intToAdd = 0
        End If
        showing = showing + intToAdd
    Next
    DoEvents 'this ensures that the pic opens when the DoPause is called
End Sub

Private Sub ResetButtons()
    Dim i As Integer
    'reset the default image
    For i = 0 To Images.Count - 1
        Images(i).Picture = defImg.Picture
        Images(i).Tag = defTag
    Next
End Sub

'function to pause when 2 tiles are uncovered
Private Sub DoPause(Duration)
    Sleep Duration
End Sub

Private Sub btnRestart_Click()
    Dim i As Integer
    For i = 0 To totalImages - 1
        names(i) = -1
        scrambled(i) = -1
    Next
    SelectNames
    ScrambleNames
    ResetButtons

    moves = 0
    prevIndex = -1
    uncovered = 0
    showing = 0
    lblMoves.Caption = initMoves
End Sub

Private Sub Form_Load()
    Dim i As Integer
    
    Call CreateImageArray
    
    names = Array(-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1)
    scrambled = Array(-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1)
    NameIndexes = Array(0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49)
    prevIndex = -1
    uncovered = 0
    showing = 0
    For i = 0 To Images.Count - 1
        Images(i).Tag = defTag
    Next
    
    'int to count the moves
    moves = 0
    initMoves = "0 Moves"
    myMove = " move"
    myMoves = " moves"
    
    'delay to close message box (milliseconds)
    DELAY = 800

    'select and mix up the names for this game
    SelectNames
    ScrambleNames
End Sub

Private Sub Images_Click(index As Integer)
    
    Call ShowImage(index)
    
    'check for matches
    If (showing Mod 2 = 0 And showing <> uncovered) Then
        'update moves
        moves = moves + 1
        Dim strMoves As String '
        If moves = 1 Then
            strMoves = moves & myMove
        Else
            strMoves = moves & myMoves
        End If
        lblMoves.Caption = strMoves
        'check for a match
        If (scrambled(prevIndex) = scrambled(index)) Then
            uncovered = uncovered + 2
        Else
            'pause for 1 second
            DoPause (DELAY)
            
            'cover up the images with the default
            Images(prevIndex).Picture = defImg.Picture
            Images(prevIndex).Tag = defTag
            Images(index).Picture = defImg.Picture
            Images(index).Tag = defTag
        End If
    End If
    'update indices
    prevIndex = index
End Sub

Private Sub mnuExit_Click()
    If MsgBox("Are you sure you want to exit?", vbYesNo) = vbYes Then
        End
    End If
End Sub
