Imports System.Configuration
Imports System.Reflection
Imports System.IO
Imports System.Threading
Imports System.Resources
Imports VbConcentration.My.Resources

Public Class Concentration
    'Constants
    Private defIcon As String = ConfigurationManager.AppSettings("defIcon")
    Private defTag As String = ConfigurationManager.AppSettings("defTag")
    Private totalButtons As Integer = Convert.ToInt32(ConfigurationManager.AppSettings("totalButtons"))
    Public buttons(totalButtons) As Button
    Private picset As String() = {"Bat-icon", "Bear-icon", "Beaver-icon",
            "Bee-icon", "Bull-icon", "Cat-icon", "Chicken-icon", "Cow-icon", "Crab-icon",
            "Crocodile-icon", "Deer-icon", "Dog-icon", "Dolphin-icon", "Duck-icon",
            "Eagle-icon", "Elephant-icon", "Fish-icon", "Frog-icon", "Giraffe-icon",
            "Goat-icon", "Gorilla-icon", "Hippo-icon", "Horse-icon", "Kangaroo-icon",
            "Koala-icon", "Lion-icon", "Lizard-icon", "Lobster-icon", "Monkey-icon",
            "Mouse-icon", "Octopus-icon", "Owl-icon", "Penguin-icon", "Pig-icon",
            "Rabbit-icon", "Raccoon-icon", "Rat-icon", "Rhino-icon", "Seal-icon",
            "Shark-icon", "Sheep-icon", "Snail-icon", "Snake-icon", "Squirrel-icon",
            "Swan-icon", "Tiger-icon", "Tuna-icon", "Turtle-icon", "Whale-icon", "Wolf-icon"}
    Private totalPics As Integer = 50
    Private names(totalButtons) As String
    Private scrambled(totalButtons) As String
    Private index As Integer = 0
    Private prevIndex As Integer = -1
    Private uncovered As Integer = 0
    Private showing As Integer = 0
    Private imgPath As String = "VbConcentration.{0}.png"
    Private EmptyString As String = ""
    'int to count the moves
    Private moves As Integer = 0
    Private initMoves As String = "0 Moves"
    Private myMove As String = ConfigurationManager.AppSettings("move")
    Private myMoves As String = ConfigurationManager.AppSettings("moves")
    'delay to close message box (milliseconds)
    Private DELAY As Integer = Convert.ToInt32(ConfigurationManager.AppSettings("delay"))
    'reflection assembly
    Private myAssembly As System.Reflection.Assembly = System.Reflection.Assembly.GetExecutingAssembly()

    'Initialize the class
    Private Sub Concentration_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Load
        CreateButtons()
        ClearArray(names)
        ClearArray(scrambled)
        SelectNames()
        ScrambleNames()
    End Sub

    'function to clear an array
    Private Sub ClearArray(anArray() As String)
        For i As Integer = 0 To anArray.Length - 1
            anArray(i) = EmptyString
        Next
    End Sub

    'function to create the buttons
    Private Sub CreateButtons()
        Dim cx As Integer = btnPanel.Width / 4
        Dim cy As Integer = btnPanel.Height / 4
        For row As Integer = 0 To 3
            For col As Integer = 0 To 3
                Dim index As Integer = col * 4 + row
                Dim myStream As Stream = myAssembly.GetManifestResourceStream(defIcon)
                Dim img As New Bitmap(myStream)
                img.Tag = defTag
                buttons(index) = New Button
                buttons(index).Image = img
                AddHandler buttons(index).Click, AddressOf Button_OnClick
                buttons(index).Tag = index.ToString
                buttons(index).SetBounds(cx * row, cy * col, cx, cy)
                btnPanel.Controls.Add(buttons(index))
            Next
        Next
    End Sub

    'function to select 8 names from the picset array
    Private Sub SelectNames()
        Dim generator As Random = New Random()
        Dim usedIndices As List(Of Integer) = New List(Of Integer)
        Dim i As Integer = 0
        Dim j As Integer
        Do
            j = generator.Next(totalPics)
            If (names(i) = EmptyString And Not usedIndices.Contains(j)) Then
                usedIndices.Add(j)
                names(i) = picset(j)
                names(i + 8) = picset(j)
                i = i + 1
            End If
        Loop While (i <= 7)
    End Sub

    'function to scramble the names array
    Private Sub ScrambleNames()
        Dim generator As Random = New Random
        Dim i As Integer = 0
        Dim j As Integer
        Do
            j = generator.Next(16)
            If (scrambled(j) = EmptyString) Then
                scrambled(j) = names(i)
                i = i + 1
            End If
        Loop While (i <= 15)
    End Sub

    Private Sub Button_OnClick(sender As Object, e As EventArgs)
        'start a new thread so the images will be uncovered when the DoPause kicks in
        Dim ShowImgThread As Thread = New Thread(New ParameterizedThreadStart(AddressOf ShowImage))
        ShowImgThread.Start(sender)
        ShowImgThread.Join()

        'check for matches
        If (showing Mod 2 = 0 And showing <> uncovered) Then
            'update moves
            moves += 1
            Dim strMoves As String = If(moves = 1, String.Concat(moves, myMove), String.Concat(moves, myMoves))
            lblMoves.Text = strMoves
            'check for a match
            If (scrambled(prevIndex) = scrambled(index)) Then
                uncovered += 2
            Else
                'pause for 1 second
                DoPause()

                'cover up the images with the default
                Dim imgName As String = defIcon
                Dim myStream = myAssembly.GetManifestResourceStream(imgName)
                Dim defaultImage As New Bitmap(myStream)
                defaultImage.Tag = defTag
                buttons(prevIndex).Image = defaultImage
                buttons(index).Image = defaultImage
            End If
        End If
        'update indices
        prevIndex = index
    End Sub

    Public Sub ShowImage(button As Object)
        'get button that was clicked
        Dim btn As Button = CType(button, Button)
        'get image to show
        index = Convert.ToInt32(btn.Tag)
        Dim imgName As String = String.Format(imgPath, scrambled(index))
        Dim myStream As Stream = myAssembly.GetManifestResourceStream(imgName)
        Dim img As New Bitmap(myStream)
        img.Tag = scrambled(index)
        'change image on the button to the show image
        Dim temp As Bitmap = New Bitmap(img, btn.Width - 10, btn.Height - 10)
        temp.Tag = scrambled(index)
        btn.Image = temp

        'check for images that aren't the default
        'to prevent double clicking
        showing = 0
        For i As Integer = 0 To buttons.Length - 1
            Dim intToAdd As Integer = If(buttons(i).Image.Tag.ToString = defTag, 0, 1)
            showing += intToAdd
        Next
    End Sub

    Private Sub btnStart_Click(sender As Object, e As EventArgs) Handles btnStart.Click
        ClearArray(names)
        ClearArray(scrambled)
        SelectNames()
        ScrambleNames()
        ResetButtons()

        moves = 0
        index = 0
        prevIndex = -1
        uncovered = 0
        showing = 0
        lblMoves.Text = initMoves
    End Sub

    Private Sub ResetButtons()
        'reset the default image
        Dim myStream As Stream = myAssembly.GetManifestResourceStream(defIcon)
        Dim defImg As New Bitmap(myStream)
        defImg.Tag = defTag
        For i As Integer = 0 To buttons.Length - 1
            buttons(i).Image = defImg
        Next
    End Sub

    'function to pause when 2 tiles are uncovered
    Public Sub DoPause()
        Dim are As AutoResetEvent = New AutoResetEvent(False)
        are.WaitOne(DELAY, True)
    End Sub
End Class
