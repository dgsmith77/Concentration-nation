package require base64 ; # in tcllib, part of ActiveTcl

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

set fpBg [open "background.txt" w+]
set gifImg "zoo_light.gif"
set bgInfo [inlineGIF $gifImg]
puts $fpBg $bgInfo

set fpD [open "default.txt" w+]
set gifImg "face3.gif"
set bgInfo [inlineGIF $gifImg]
puts $fpD $bgInfo
