package require base64 ; # in tcllib, part of ActiveTcl

set ::picset "Bear_icon.gif Beaver_icon.gif Bee_icon.gif Bull_icon.gif Cat_icon.gif Chicken_icon.gif Cow_icon.gif Crab_icon.gif Crocodile_icon.gif Deer_icon.gif Dog_icon.gif Dolphin_icon.gif Duck_icon.gif Eagle_icon.gif Elephant_icon.gif Fish_icon.gif Frog_icon.gif Giraffe_icon.gif Goat_icon.gif Gorilla_icon.gif Hippo_icon.gif Horse_icon.gif Kangaroo_icon.gif Koala_icon.gif Lion_icon.gif Lizard_icon.gif Lobster_icon.gif Monkey_icon.gif Mouse_icon.gif Octopus_icon.gif Owl_icon.gif Penguin_icon.gif Pig_icon.gif Rabbit_icon.gif Raccoon_icon.gif Rat_icon.gif Rhino_icon.gif Seal_icon.gif Shark_icon.gif Sheep_icon.gif Snail_icon.gif Snake_icon.gif Squirrel_icon.gif Swan_icon.gif Tiger_icon.gif Tuna_icon.gif Turtle_icon.gif Whale_icon.gif Wolf_icon.gif"

proc inlineGIF { img { name "" } } {
    set f [open $img]
    fconfigure $f -translation binary
    set data [base64::encode [read $f]]
    close $f
    if {[llength [info level 0]] == 2} {
	# base name on root name of the image file
	set name [file root [file tail $img]]
    }
    return "$data"
}

set ::fp [open "images.txt" w+]
set gifImg "Bear_icon.gif"
set tmpInfo [inlineGIF $gifImg]
puts -nonewline $::fp "$tmpInfo"

for { set i 1 } { $i < 48 } { incr i } {
	set Img [lindex $::picset $i]
	set tmpImg [inlineGIF $Img]
	puts -nonewline $::fp " $tmpImg"
}

set finalImg "Wolf_icon.gif"
set tmp [inlineGIF $finalImg]
puts -nonewline $::fp " $tmp"
