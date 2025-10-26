wm title . "version"
wm geometry . "800x300+0+0"
ttk::frame .fr
pack .fr -fill both -expand TRUE

grid columnconfigure .fr 0 -weight 1
grid columnconfigure .fr 1 -weight 1
grid rowconfigure .fr 0 -weight 1
grid rowconfigure .fr 1 -weight 1
grid rowconfigure .fr 2 -weight 1

ttk::button .fr.but -text "test" -command "func"
grid .fr.but -row 0 -column 0 -columnspan 2 -sticky nswe

ttk::label .fr.value -text "LABEL" -textvariable label_var -anchor center
grid .fr.value -row 1 -column 0 -columnspan 2 -sticky nswe

ttk::entry .fr.in -textvariable entry_var
set entry_var 0
grid .fr.in -row 2
bind .fr.in <Return> "func"

ttk::entry .fr.suff -textvariable format_var
grid .fr.suff -row 2 -column 1
set format_var 1

ttk::combobox .fr.combo -values { "O2" "N2"} -textvariable gas_var
grid .fr.combo -row 3 -column 0 -columnspan 2 -sticky nsew
set gas_var "O2"

ttk::button .fr.ok_but -text "OK" -command "about_call"
grid .fr.ok_but -row 4 -column 0 -sticky nswe

ttk::button .fr.draw_but -text "draw" -command "draw_tk_cb"
grid .fr.draw_but -row 4 -column 1 -sticky nswe

ttk::button .fr.quit_but -text "quit" -command {destroy .}
grid .fr.quit_but -row 5 -column 0 -sticky nswe

set oval_radius 10
