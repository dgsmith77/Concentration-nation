import javax.swing.*;
import javax.swing.Timer;

import java.awt.event.*;
import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Container;
import java.awt.Dimension;
import java.awt.Font;
import java.awt.GridLayout;
import java.awt.Toolkit;
import java.awt.Window;
import java.util.*;

public class Concentration extends JFrame
{
	private static final long serialVersionUID = 1L;
	private static final int TIMER_DELAY = 1000;
	private static final int TOTAL_NAMES = 16;
	private static final int TOTAL_PICS = 49;
	private static final String EMPTY_STRING = "";
	private static final String NOT_A_MATCH_TEXT = "That's not a match";
	private static final String INIT_MOVES_TEXT = "0 moves";
	private static final String IMG_EXT = ".png";
	private static final String GAME_NAME = "Concentration";
	private static final String START_GAME = "Start New Game";
	private JButton[] buttons = new JButton[TOTAL_NAMES];
	private String[] picset = {"Bear-icon", "Beaver-icon",
            "Bee-icon", "Bull-icon", "Cat-icon", "Chicken-icon", "Cow-icon", "Crab-icon",
            "Crocodile-icon", "Deer-icon", "Dog-icon", "Dolphin-icon", "Duck-icon",
            "Eagle-icon", "Elephant-icon", "Fish-icon", "Frog-icon", "Giraffe-icon",
            "Goat-icon", "Gorilla-icon", "Hippo-icon", "Horse-icon", "Kangaroo-icon",
            "Koala-icon", "Lion-icon", "Lizard-icon", "Lobster-icon", "Monkey-icon",
            "Mouse-icon", "Octopus-icon", "Owl-icon", "Penguin-icon", "Pig-icon",
            "Rabbit-icon", "Raccoon-icon", "Rat-icon", "Rhino-icon", "Seal-icon",
            "Shark-icon", "Sheep-icon", "Snail-icon", "Snake-icon", "Squirrel-icon",
            "Swan-icon", "Tiger-icon", "Tuna-icon", "Turtle-icon", "Whale-icon", "Wolf-icon"};
	private String[] names = new String[TOTAL_NAMES];
	private String[] scrambled = new String[TOTAL_NAMES];
	private int index = 0;
	private int prevIndex = -1;
	private int uncovered = 0;
	private int showing = 0;
	// reset button
	private JButton reset;
	// try counter Label
	private JLabel lblmoves;
	// int to count the moves
	private int moves = 0;
	private String MOVE = " move";
	private String MOVES = " moves";
	// default image
	ClassLoader cl= this.getClass().getClassLoader();
	java.net.URL imageURL = cl.getResource("face3.png");
	private ImageIcon defIcon = new ImageIcon(imageURL);
	JPanel GamePanel;

	public Concentration()
	{
	    GamePanel = new JPanel();
	    GamePanel.setLayout(new GridLayout(4,4,2,2));
	    JPanel ButtonPanel = new JPanel();
	    ButtonPanel.setLayout(new BorderLayout());
	    JPanel LabelPanel = new JPanel();
	    LabelPanel.setLayout(new BorderLayout());
	    // select random animal names
	    for(int k=0; k<names.length; k++)
	    	names[k] = "";
	    SelectPics();
	    // scramble the animal names
	    for(int i=0; i<scrambled.length; i++)
	    	scrambled[i] = "";
	    ScramblePics();

	    // create an instance of inner class ButtonHandler
	    // to use for button click event handling
	    ButtonHandler bh = new ButtonHandler();
	    
	    for(int j=0;j<buttons.length;j++)
	    {
	    	buttons[j] = new JButton(EMPTY_STRING, defIcon);
	    	buttons[j].setActionCommand(String.valueOf(j));
	    	GamePanel.add(buttons[j]);
	    	buttons[j].addActionListener(bh);
	    }
	    
	    // reset handler
	    Restart r = new Restart();
	    reset = new JButton(START_GAME);
	    reset.addActionListener(r);
	    ButtonPanel.add(reset, BorderLayout.CENTER);

	    // moves label
	    lblmoves = new JLabel(INIT_MOVES_TEXT);
	    lblmoves.setFont(new Font("Serif", Font.PLAIN, 14));
	    lblmoves.setForeground(Color.blue);
	    lblmoves.setHorizontalAlignment(SwingConstants.CENTER);
	    lblmoves.setVerticalAlignment(SwingConstants.CENTER);
	    LabelPanel.add(lblmoves, BorderLayout.CENTER);

	    Container c = getContentPane();
	    c.setLayout(new BorderLayout());
	    c.add(LabelPanel, BorderLayout.NORTH);
	    c.add(GamePanel, BorderLayout.CENTER);
	    c.add(ButtonPanel, BorderLayout.SOUTH);

	    setSize( 240, 316 );
		setTitle(GAME_NAME);
	    setVisible(true);
	    locateWindow(this);
	}
	
	// locate game window
	public static void locateWindow(Window frame) 
	{
	    Dimension dimension = Toolkit.getDefaultToolkit().getScreenSize();
	    int x = (int) ((dimension.getWidth() - frame.getWidth()) / 2) - 270;
	    int y = (int) ((dimension.getHeight() - frame.getHeight()) / 2);
	    frame.setLocation(x, y);
	}
	
	public static void main( String args[] )
	{ 
	   Concentration app = new Concentration();

	   app.addWindowListener(
	      new WindowAdapter() {
	         public void windowClosing( WindowEvent e )
	         {
	            System.exit( 0 );
	         }
	      }
	   );
	}
	
	// function to populate the scrambled picture array randomly
	private void ScramblePics()
	{
	    Random generator = new Random();
	    int i = 0;
	    int j;
	    do
	    {
	    	j = generator.nextInt(TOTAL_NAMES);
	    	if(scrambled[j] == EMPTY_STRING)
	    	{
	    		scrambled[j] = names[i];
	    		i++;
	    	}
	    } while (i <= 15);
	}
	
	// function to select 8 pictures from the picset array
	private void SelectPics()
	{
		Random generator = new Random();
		List<Integer> usedIndices = new ArrayList<Integer>();
		int i = 0;
		int j;
		do
	    {
	    	j = generator.nextInt(TOTAL_PICS);
	    	if(names[i] == EMPTY_STRING && !usedIndices.contains(j))
	    	{
	    		usedIndices.add(j);
	    		names[i] = picset[j];
	    		names[i + 8] = picset[j];
	    		i++;
	    	}
	    } while (i <= 7);
	}
	
	// inner class for button clicking event handling
	private class ButtonHandler implements ActionListener 
	{
		public void actionPerformed( ActionEvent e )
	    {
			index = Integer.parseInt(e.getActionCommand());
			showImage(index);

			// check for matches
			if(showing % 2 == 0 && showing != uncovered)
			{
				// update moves
				String strmoves = moves == 0 ? ++moves + MOVE : ++moves + MOVES;
				lblmoves.setText(strmoves);
				
				// check for a match
				if(scrambled[prevIndex] == scrambled[index])
				{
					uncovered += 2;
				}
				else
				{
					doPause();
					buttons[prevIndex].setIcon(defIcon);
					buttons[index].setIcon(defIcon);
				}
			}
			// update indices
			prevIndex = index;
	    }
	}
	
	private void showImage(int index)
	{
		// show hidden image
		java.net.URL imageURL = cl.getResource(scrambled[index] + IMG_EXT);
		ImageIcon temp = new ImageIcon(imageURL);

		buttons[index].setIcon(temp);
		
		// check for images that aren't the default
		// to prevent double clicking
		showing = 0;
		for(int i=0; i<buttons.length; i++)
		{
			showing += buttons[i].getIcon() == defIcon ? 0 : 1;
		}
	}
	
	@SuppressWarnings("serial")
	private void doPause()
	{
		final JLabel label = new JLabel();
	    new Timer(TIMER_DELAY, new ActionListener() 
	    {
	    	int timeLeft = 1;
	        @Override
	        public void actionPerformed(ActionEvent e) 
	        {
	           if (timeLeft > 0) 
	           {
	        	   label.setText(NOT_A_MATCH_TEXT);
	        	   timeLeft--;
	           } 
	           else 
	           {
	        	   ((Timer)e.getSource()).stop();
	               Window win = SwingUtilities.getWindowAncestor(label);
	               win.setVisible(false);
	           }
	         }
	      }){{setInitialDelay(0);}}.start();

	      JOptionPane.showOptionDialog(null, label, EMPTY_STRING, JOptionPane.DEFAULT_OPTION, JOptionPane.INFORMATION_MESSAGE, null, new Object[]{}, null);
	}

	// start a new game
	private class Restart implements ActionListener
	{
		public void actionPerformed( ActionEvent e )
		{
			for(int j=0; j<names.length; j++)
				names[j] = EMPTY_STRING;
			SelectPics();
			for(int i=0; i<scrambled.length; i++)
		    	scrambled[i] = EMPTY_STRING;
			ScramblePics();
			index = 0;
			prevIndex = -1;
			uncovered = 0;
			SetDefaultImage();
			showing = 0;
			moves = 0;
			lblmoves.setText(INIT_MOVES_TEXT);
		}
		
		// set default image for all buttons
		private void SetDefaultImage()
		{
			for(int i=0;i<buttons.length;i++)
				buttons[i].setIcon(defIcon);
		}
	}
}