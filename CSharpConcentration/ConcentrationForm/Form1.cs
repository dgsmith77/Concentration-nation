using System;
using System.Drawing;
using System.Windows.Forms;
using System.Configuration;
using System.Threading;
using System.Resources;
using ConcentrationForm.Properties;
using System.Collections.Generic;

namespace ConcentrationForm
{
    public partial class Form1 : Form
    {
        private string defIcon = "face3";
        private static int totalButtons = 16;
        public Button[] buttons = new Button[totalButtons];
        private string[] picset = {"alligator","ant","bat","bear",
		    "deer","elephant","lion","shark",
		    "bee","bird","bull","bulldog",
		    "butterfly","wolf","cat","chicken",
		    "cow","crab","crocodile","dog",
		    "donkey","duck","eagle","fish",
		    "fox","frog","giraffe","gorilla",
		    "hippo","horse","insect","monkey",
		    "moose","owl","panda","penguin",
		    "pig","rabbit","rhino","rooster",
		    "sheep","snake","tiger","turkey","turtle","mouse"};
        private int totalPics = 46;
        private string[] names = new string[totalButtons];
        private string[] scrambled = new string[totalButtons];
        private int index = 0;
        private int prevIndex = -1;
        private int uncovered = 0;
        private int showing = 0;
        // int to count the moves
        private int moves = 0;
        private string initMoves = "0 Moves";
        private string MOVE = " move";
        private string MOVES = " moves";
        // delay
        private int DELAY = 800;
        // resource manager
        private ResourceManager rm = Resources.ResourceManager;

        public Form1()
        {
            InitializeComponent();

            CreateButtons();
            ClearArray(names);
            ClearArray(scrambled);
            SelectNames();
            ScrambleNames();
        }

        // function to create the buttons
        private void CreateButtons()
        {
            int cx = BtnPanel.ClientRectangle.Width / 4;
            int cy = BtnPanel.ClientRectangle.Height / 4;
            for (int row = 0; row < 4; row++)
            {
                for (int col = 0; col < 4; col++)
                {
                    int index = col * 4 + row;
                    Image img = (Image)rm.GetObject(defIcon);
                    img.Tag = defIcon;
                    buttons[index] = new Button();
                    buttons[index].Image = img;
                    buttons[index].Click += new EventHandler(Button_OnClick);
                    buttons[index].Tag = index.ToString();
                    buttons[index].SetBounds(cx * row, cy * col, cx, cy);
                    BtnPanel.Controls.Add(buttons[index]);
                }
            }
        }

        // function to clear an array
        private void ClearArray(string[] anArray)
        {
            for (int i = 0; i < anArray.Length; i++)
                anArray[i] = string.Empty;
        }

        // function to select 8 names from the picset array
        private void SelectNames()
        {
            Random generator = new Random();
            List<int> usedIndices = new List<int>();
            int i = 0;
            int j;
            do
            {
                j = generator.Next(totalPics);
                if (names[i] == string.Empty && !usedIndices.Contains(j))
                {
                    usedIndices.Add(j);
                    names[i] = picset[j];
                    names[i + 8] = picset[j];
                    i++;
                }
            } while (i <= 7);
        }

        // function to populate the icon string array randomly
        private void ScrambleNames()
        {
            Random generator = new Random();
            int i = 0;
            int j;
            do
            {
                j = generator.Next(totalButtons);
                if (scrambled[j] == string.Empty)
                {
                    scrambled[j] = names[i];
                    i++;
                }
            } while (i <= 15);
        }

        // onclick event
        private void Button_OnClick(object sender, EventArgs e)
        {
            // start a new thread so the images will be uncovered when the DoPause kicks in
            Thread ShowImgThread = new Thread(new ParameterizedThreadStart(ShowImage));
            ShowImgThread.Start(sender);
            ShowImgThread.Join();

            // check for matches
            if (showing % 2 == 0 && showing != uncovered)
            {
                // update moves
                String strmoves = moves == 0 ? ++moves + MOVE : ++moves + MOVES;
                lblMoves.Text = strmoves;

                // check for a match
                if (scrambled[prevIndex] == scrambled[index])
                {
                    uncovered += 2;
                }
                else
                {
                    // pause for 1 second
                    DoPause();

                    // cover up the images with the default
                    Image defaultImage = (Image)rm.GetObject(defIcon);
                    defaultImage.Tag = defIcon;
                    buttons[prevIndex].Image = defaultImage;
                    buttons[index].Image = defaultImage;
                }
            }
            // update indices
            prevIndex = index;
        }

        // function to show hidden images
        public void ShowImage(object button)
        {
            // get the button that was clicked
            Button btn = (Button)button;
            // get image to show
            index = Convert.ToInt32(btn.Tag);

            Image img = (Image)rm.GetObject(scrambled[index]);
            img.Tag = scrambled[index];
            // change image on button to show image
            btn.Image = img;

            // check for images that aren't the default
            // to prevent double clicking
            showing = 0;
            for (int i = 0; i < buttons.Length; i++)
            {
                showing += buttons[i].Image.Tag.ToString() == defIcon ? 0 : 1;
            }
        }

        // function to pause when 2 tiles are uncovered
        public void DoPause()
        {
            AutoResetEvent are = new AutoResetEvent(false);
            are.WaitOne(DELAY, true);
        }

        // start new game button click event
        private void btnRestart_Click(object sender, EventArgs e)
        {
            ClearArray(names);
            ClearArray(scrambled);
            SelectNames();
            ScrambleNames();
            ResetButtons();

            moves = 0;
            index = 0;
            prevIndex = -1;
            uncovered = 0;
            showing = 0;
            lblMoves.Text = initMoves;
        }

        // function to reset the default image to all buttons
        private void ResetButtons()
        {
            // reset the default image
            Image defImg = (Image)rm.GetObject(defIcon);
            defImg.Tag = defIcon;
            for (int i = 0; i < buttons.Length; i++)
            {
                buttons[i].Image = defImg;
            }
        }
    }
}
