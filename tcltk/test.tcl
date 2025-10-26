proc onOk { s } { 
    set s "Clicked"
}

proc msgok { answer } { 
    set answer "ok"
}

proc msgcancel { answer } { 
    set answer "cancel"
}

proc onQuit { answer } { 
    # tk_messageBox -parent .fr -message "Quit" -title "Ask" -type info
    toplevel .top
    grab .top
    wm transient .top .
    ttk::button .top.b1 -text "OK" -command "msgok answer"
    ttk::button .top.b2 -text "CANCEL" -command "msgcancel answer"
    pack .top.b1
    pack .top.b2
}

# Main Windows
wm title . Simple
set width 600
set height 250
set x [expr {([winfo vrootwidth .]-$width)/2}]
set y [expr {([winfo vrootheight .]-$height)/2}]
wm geometry . ${width}x${height}+${x}+${y}

ttk::style theme use aqua
ttk::frame .fr
pack .fr -expand 1 -fill both

grid columnconfigure .fr 0 -weight 1
grid columnconfigure .fr 1 -weight 1
grid rowconfigure .fr 0 -weight 1
grid rowconfigure .fr 1 -weight 0

set tk_s "gg"
ttk::label .fr.text -textvariable tk_s 
grid .fr.text -row 0 -column 0 -sticky nswe -columnspan 2


ttk::button .fr.ok -text "Ok" -command "onOk tk_s"
grid .fr.ok -row 1 -column 1 -sticky nswe

ttk::button .fr.quit -text "Quit" -command "onQuit tk_s"
grid .fr.quit -row 1 -column 0 -sticky nswe
