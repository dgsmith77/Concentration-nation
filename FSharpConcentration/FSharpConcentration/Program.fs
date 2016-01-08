open System
open System.Drawing
open System.Windows.Forms
open System.IO
open System.Threading
open System.Resources

// CONSTANTS
let DELAY = 1000
let SCRAMBLED_COUNT = 16
let MOVE = " move"
let MOVES = " moves"
let LBL_MOVES_LEFT = 10
let LEFT_EDGE = 20
let GAME_BTN_WIDTH = 50
let GAME_BTN_HEIGHT = 50
let GAME_BTN_TOP_OFFSET = 10
let MULTIPLIER = 50
let START_BTN_TOP = 245
let START_BTN_WIDTH = 200
let START_BTN_HEIGHT = 30
let START_GAME_TEXT = "Start New Game"
let INIT_MOVES_TXT = "0 Moves"
let FORM_TEXT = "F# Concentration"
let FORM_WIDTH = 260
let FORM_HEIGHT = 330
// images to pick from for game (in the Resources.resx file)
let PIC_SET = [| "Bat-icon"; "Bear-icon"; "Beaver-icon"; "Bee-icon"; 
    "Bull-icon"; "Cat-icon"; "Chicken-icon"; "Cow-icon"; "Crab-icon";
    "Crocodile-icon"; "Deer-icon"; "Dog-icon"; "Dolphin-icon"; "Duck-icon";
    "Eagle-icon"; "Elephant-icon"; "Fish-icon"; "Frog-icon"; "Giraffe-icon";
    "Goat-icon"; "Gorilla-icon"; "Hippo-icon"; "Horse-icon"; "Kangaroo-icon";
    "Koala-icon"; "Lion-icon"; "Lizard-icon"; "Lobster-icon"; "Monkey-icon";
    "Mouse-icon"; "Octopus-icon"; "Owl-icon"; "Penguin-icon"; "Pig-icon";
    "Rabbit-icon"; "Raccoon-icon"; "Rat-icon"; "Rhino-icon"; "Seal-icon";
    "Shark-icon"; "Sheep-icon"; "Snail-icon"; "Snake-icon"; "Squirrel-icon";
    "Swan-icon"; "Tiger-icon"; "Tuna-icon"; "Turtle-icon"; "Whale-icon"; "Wolf-icon" |]

// VARIABLES
let mutable strMoves = ""
let mutable index = 0
let mutable prevIndex = -1
let mutable uncovered = 0
let mutable showing = 0
let mutable moves = 0
// selected names to play
let names = Array.init 16 (fun x -> "")
// names to play, randomly mixed up
let scrambled = Array.init 16 (fun x -> "")

// use reflection to get assembly
let assembly = System.Reflection.Assembly.GetExecutingAssembly()
// create resource manager for Resources.resx
let rm = new ResourceManager("Resources", assembly)

// background image
let bkgrImage = rm.GetObject("zoo_light") :?> Image
// default image
let defaultImg = rm.GetObject("face3") :?> Image

// set up the form
let Concentration = new Form(Text=FORM_TEXT, TopMost=true, Width=FORM_WIDTH, Height=FORM_HEIGHT)
Concentration.Visible <- true
Concentration.BackgroundImage <- bkgrImage

// label to track moves
let lblMoves = new Label()
lblMoves.Text <- INIT_MOVES_TXT
lblMoves.AutoSize <- true
lblMoves.Left <- LEFT_EDGE
lblMoves.BackColor <- System.Drawing.Color.Transparent
lblMoves.Top <- LBL_MOVES_LEFT

// default size for game buttons
let defaultSize = new Size(GAME_BTN_WIDTH, GAME_BTN_HEIGHT)

// set up game buttons
let CreateGameButton tag x y = new Button(Tag=tag, Top=x+GAME_BTN_TOP_OFFSET, Left=y, Size=defaultSize, Image=defaultImg)
let gameButtonSeq = seq{ for x in 0..3 do for y in 0..3 -> (CreateGameButton (x*4+y) ((x*MULTIPLIER)+LEFT_EDGE) ((y*MULTIPLIER)+LEFT_EDGE)) } 
let gameButtons = Seq.toArray(gameButtonSeq)

// FUNCTIONS
// pause function
let DoPause args =
   let are = new AutoResetEvent(false)
   are.WaitOne(DELAY, true) |> ignore

// show image function
let ShowImage sender =
    gameButtons.[index].Image <- rm.GetObject(scrambled.[index]) :?> Image
    // check for images that aren't the default
    // to prevent double clicking
    showing <- 0
    let maxVal = gameButtons.Length - 1
    for i in 0 .. maxVal do
        if gameButtons.[i].Image = defaultImg then
            showing <- showing + 1

// button click event
let GameButtonClick sender = 
    let button = sender :> Button
    let tag = button.Tag.ToString()
    index <- System.Int32.Parse tag
    let ShowImgThread = new Thread(new ParameterizedThreadStart(ShowImage))
    ShowImgThread.Start(sender)
    ShowImgThread.Join()
    // check for matches
    if showing % 2 = 0 then
        if showing <> uncovered then
            // update moves
            moves <- moves + 1
            if moves = 1 then
                strMoves <- moves.ToString() + MOVE
            else
                strMoves <- moves.ToString() + MOVES
            lblMoves.Text <- strMoves
            // check for a match
            if scrambled.[prevIndex] = scrambled.[index] then
                uncovered <- uncovered + 2
            else
                // pause for 1 second
                DoPause()
                // cover up the images with the default
                gameButtons.[prevIndex].Image <- defaultImg
                gameButtons.[index].Image <- defaultImg
    // update indices
    prevIndex <- index

// add click event to all game buttons
for button in gameButtons do
   let tag = button.Tag.ToString()
   button.Click.Add(fun args -> GameButtonClick button)

// restart button
let restartButton = new Button(Text=START_GAME_TEXT, Top=START_BTN_TOP, Left=LEFT_EDGE, Size=new Size(START_BTN_WIDTH,START_BTN_HEIGHT))

// reset the buttons
let ResetButtons args = 
   for button in gameButtons do
      button.Image <- defaultImg

// function to clear an array of strings
let ClearArray array =
   let maxVal = Array.length array - 1
   for i in 0 .. maxVal do
      array.[i] <- ""

// set up the names array (selected pics to use)
let SelectNames args =
  let mutable i = 0
  let mutable usedIndices = Array.init 1 (fun x -> -1)
  let mutable continueLooping = true
  let rand = new Random()
  while continueLooping do
    // Generate a random number between 1 and available pics (total number of pics available).
    let count = Array.length PIC_SET
    let j = rand.Next(count)
    if names.[i] = "" then
       if not (usedIndices |> Array.exists (fun x -> x = j)) then
          usedIndices <- Array.append usedIndices [|j|]
          names.[i] <- PIC_SET.[j] 
          names.[i+8] <- PIC_SET.[j] 
          i <- i + 1 
          if i > 7 then 
             continueLooping <- false

// set up the scrambled names array
let ScrambleNames args =
  let mutable i = 0
  let mutable continueLooping = true
  let rand = new Random()
  while continueLooping do
    // Generate a random number between 1 and length of scrambled array.
    let j = rand.Next(SCRAMBLED_COUNT)
    if scrambled.[j] = "" then
          scrambled.[j] <- names.[i]
          i <- i + 1 
          if i > 15 then 
             continueLooping <- false

// restart game click event
let RestartGame args = 
    ClearArray(names)
    ClearArray(scrambled)
    ResetButtons()
    SelectNames()
    ScrambleNames()
    moves <- 0
    index <- 0
    prevIndex <- -1
    uncovered <- 0
    showing <- 0
    lblMoves.Text <- INIT_MOVES_TXT

// restart button click
restartButton.Click.Add(fun args -> RestartGame args)

// add controls to form
Concentration.Controls.Add(lblMoves)
for button in gameButtons do
    Concentration.Controls.Add(button)
Concentration.Controls.Add(restartButton)
// get pics for this game
SelectNames()
ScrambleNames()

[<STAThread>]
Application.Run(Concentration)