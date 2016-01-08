package require Tk

wm title . {TCL Concentration}

# global constants
set ::totalButtons 16
set ::totalPics 49
set ::pause 700 ;# pause in milliseconds
set ::wait 0
set ::widthHeight 48
set ::numRows 4
set ::leftOffset 20
# default image
set fp [open "default.txt" r]
set defData [read $fp]
image create photo .defIcon -format GIF -data $defData
# array for image binary info
set fpPics [open "images.txt" r]
set picData [read $fpPics]
set picsetDataTmp $picData
set ::picsetData [split $picsetDataTmp " "]

# global variables
set ::strMoves ""
set ::prevIndex -1
set ::uncovered 0
set ::showing 0
set ::moves 0
set ::clicks 0
set ::names {-1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1}
set ::scrambled {-1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1}
set ::imageSize 48

proc Main { } {
	frame .fr
	pack .fr -fill both -expand 1

	# background image
	set fBg [open "background.txt" r]
	set bgData [read $fBg]
	image create photo .bg -format GIF -data $bgData
	button .fr.bgbtn -image .bg
	place .fr.bgbtn -x 0 -y 0
	# moves label
	label .fr.lb -text "0 moves"
	place .fr.lb -x 95 -y 5
	# create and position all the game buttons
	set myTop 0
	set myRow 0
	set buttonOffset 52
	set offset 28
	for { set i 0 } { $i < $::totalButtons } { incr i } {
		button .fr.$i -image .defIcon -width $::widthHeight -height $::widthHeight -command "GameButtonClick $i .fr.$i"
		set rem [ expr $i % $::numRows ]
		if { [expr { $rem == 0 } ] } {
			set myTop [ expr $buttonOffset * $myRow + $offset ]
			incr myRow 1
		}
		set myLeft [ expr $rem * $buttonOffset + $::leftOffset ]
		place .fr.$i -x $myLeft -y $myTop
	}
	# start new game button
	button .fr.btn -text "Start New Game" -command "RestartGame"
	place .fr.btn -x 72 -y 246

	wm geometry . 250x280+300+300
	
	# call SelectPics function
	SelectPics
}

# function to start a new game
proc RestartGame {} {
	for { set i 0 } { $i < 16 } { incr i } {
		.fr.$i configure -image .defIcon
	}
	set ::names {-1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1}
	set ::scrambled {-1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1}
	set ::moves 0
	set ::clicks 0
	set ::prevIndex -1
	set ::uncovered 0
	.fr.lb configure -text "0 moves"
	SelectPics
}

# Game button click event
proc GameButtonClick { index btn } {
	incr ::clicks
	set img [lindex $::scrambled $index]
	set imgData [lindex $::picsetData $img]
	set testData [lindex $::picsetData 0]
	image create photo .imgToShow.$index -format GIF -data $imgData -width 48 -height 48
	ShowImage $btn .imgToShow.$index
	
	# check for matches
	set rem [ expr $::showing % 2 ]
	if { [ expr { $rem == 0 && $::showing != $::uncovered } ] } {
		incr ::moves
		#update moves
		if { $::moves == 1 } {
			set ::strMoves [concat $::moves " move"]
		} else {
			set ::strMoves [concat $::moves " moves"]
		}
		.fr.lb configure -text $::strMoves
				
		#check for a match
		set prevImg [lindex $::scrambled $::prevIndex]
		set thisImg [lindex $::scrambled $index]
		if { [string compare $prevImg $thisImg] == 0 } {
			set ::uncovered [ expr $::uncovered + 2 ]
		} else {
			DoPause
			.fr.$::prevIndex configure -image .defIcon
			.fr.$index configure -image .defIcon
		}
	}
	# update indices
	set ::prevIndex $index
}

# function to reveal the hidden image
proc ShowImage { btn img } {
	$btn configure -image $img
	
	# check for images that aren't the default
    # to prevent double clicking
	set ::showing 0
	for { set i 0 } { $i < 16 } { incr i } {
		set tmpImg [.fr.$i cget -image]
		if { [ $tmpImg cget -data ] == [ .defIcon cget -data ] } {
			incr ::showing
		}
	}
}

# function to select names from the pic set for game
proc SelectPics { } {
	set strIndices ""
	set i 0
	set tmpIndices {}
	while { $i <= 7 } {
		set j [ expr {int(rand()*$::totalPics)} ]
		set isNameUsed [string first "_$j" $strIndices 0]
		set nameToChk [lindex $::names $i]
		if { $nameToChk eq -1 && $isNameUsed == -1} {
			lappend tmpIndices $j
			set nextI [ expr $i + 8 ]
			set name $j
			set ::names [lreplace $::names $i $i $name]
			set ::names [lreplace $::names $nextI $nextI $name]
			set strIndices [concat $strIndices "_$j"]
			incr i
		}
	}
	ScramblePics
}

# function to scramble the names of the pictures in game
proc ScramblePics { } {
	set i 0
	while { $i <= 15 } {
		set j [ expr {int(rand()*$::totalButtons)} ]
		set nameToChk [lindex $::scrambled $j]
		if { $nameToChk eq -1 } {
			set name [lindex $::names $i] 
			set ::scrambled [lreplace $::scrambled $j $j $name]
			incr i
		}
	}
}

# function to pause after 2 images are selected
proc DoPause { } {
    after [expr {int($::pause)}] {set a $::wait}
	vwait a ;# need this so both pics are shown before pause takes place
}

Main
