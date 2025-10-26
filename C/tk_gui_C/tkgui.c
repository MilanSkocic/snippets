/**
 * @file tkgui.c
 * Example of how implement a GUI with TK in a C application.
 * The principle is to send command to the Tcl interpreter to generate the GUI
 * and connect with the widgets with the corresponding callbacks.
 * The callbacks are implemented using the standard method for creating Tcl
 * commands in C.
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <tk.h>
#include <tcl.h>
#define TK_SILENCE_DEPRECATION 1 /**< Define silence TK */

static char *labelvar = "label_var"; /**< Tcl var for the main label. */
static char *invar = "entry_var";
static char *format_var = "format_var";
static char *gasvar = "gas_var";
static char *color = "col";
static char *fpath = "fpath";
static char *oval_radius = "oval_radius";

/**
 * @brief print out the tcl interp status.
 * @param interp Tcl interpreter
 */
void print_tcl_eval_msg(Tcl_Interp *interp){
    printf("Tcl_Eval msg: %s\n", Tcl_GetStringResult(interp));
}

/**
 * @brief C implementation of the tk wrapper
 */
double add(double a, double b){
    return a+b;
}

/**
 * @brief Tcl wrapper
 * Tcl vars must be converted to C types using thr Tcl C API
 * Tcl_GetVar(interp, varname, errorcode)
 * Tcl_GetDouble(interp , varname, *c_variable)
 */
int func(ClientData data, Tcl_Interp *interp, int argc, const char **argv){

    int i;
    double value=0.0;
    double entry=0.0;
    int suff = 0;
    char label_buffer[80];
    char format[] = "%.1f";

    if (Tcl_GetVar(interp, format_var, 4) == NULL){
        print_tcl_eval_msg(interp);
    }else
    {
        if (strlen(Tcl_GetVar(interp, format_var, 4)) > 0){
            format[2] = *(char *) Tcl_GetVar(interp, format_var, 4);
        }
        // printf("GAS = %s", (char *) Tcl_GetVar(interp, gasvar, 4));
    }

    // pass arguments in Tcl script through argv variable
    /*for (i=0; i<argc; i++){
        if (Tcl_GetDouble(interp, argv[i], &value) == TCL_OK){
            Tcl_GetDouble(interp, Tcl_GetVar(interp, invar, 0), &entry);
            sprintf(label_buffer, format, add(value, entry));
            Tcl_SetVar(interp, labelvar, label_buffer, 0);
        };*/

    if(Tcl_GetDouble(interp, Tcl_GetVar(interp, invar, 4), &value) == TCL_OK){
        sprintf(label_buffer, format, add(value, value));
        Tcl_SetVar(interp, labelvar, label_buffer, 0);
        print_tcl_eval_msg(interp);
    }
    else{
        print_tcl_eval_msg(interp);
        return TCL_ERROR;
    }
    return TCL_OK;
}

int about_call(ClientData data, Tcl_Interp *interp, int argc, const char **argv){

    Tcl_Eval(interp, "set fpath [tk_getOpenFile -parent .];");
    printf("Tcl_Eval msg: %s\n", Tcl_GetStringResult(interp));

    char *file_path = (char *)Tcl_GetVar(interp, fpath, 4);

    Tcl_SetVar(interp, labelvar, file_path, 0);
    printf("Tcl_Eval msg: %s\n", Tcl_GetStringResult(interp));

    return TCL_OK;

}

int draw_tk_cb(ClientData data, Tcl_Interp *interp, int argc, const char **argv){

    char *cmd = "toplevel .top;"
                "wm geometry .top \"1000x600+400+400\";"
                "canvas .top.can -bg white;"
                "pack .top.can -fill both -expand true;"
                "bind .top.can <Button-1> {draw_line_tk_cb %x %y};"
                ".top.can create line 0 0 400 400 -fill blue -width 1 -arrow last;";

    Tcl_Eval(interp, cmd );
    print_tcl_eval_msg(interp);

    return TCL_OK;

}

int draw_line_tk_cb(ClientData data, Tcl_Interp *interp, int argc, const char **argv){

    int x, y;
    char tcl_cmd[256];


    Tcl_GetInt(interp, argv[1], &x);
    print_tcl_eval_msg(interp);
    
    Tcl_GetInt(interp, argv[2], &y);
    print_tcl_eval_msg(interp);

    sprintf(tcl_cmd, ".top.can create oval [expr %d-$oval_radius] [expr %d-$oval_radius] [expr %d+$oval_radius] [expr %d+$oval_radius];", x, y, x, y);

    Tcl_Eval(interp, tcl_cmd);
    print_tcl_eval_msg(interp);

    return TCL_OK;

}


int main(int argc, char **argv){

    char version[128];

    // prototype for the initialization function
    Tcl_Interp *interp = Tcl_CreateInterp();

    // Initialize Tcl and Tk
    Tcl_Init(interp);
    Tk_Init(interp);

    int major, minor, patch;
    Tcl_GetVersion(&major, &minor, &patch, NULL);
    printf("Tcl_Eval msg: %s\n", Tcl_GetStringResult(interp));

    sprintf(version, "Tcl/Tk %d.%d\n", major, minor);

    /* add sequentially the Tk commands for creating the GUI */
    char *pchFile =
    "wm title . \"version\"\n"
    "wm geometry . \"800x300+0+0\"\n"
    "ttk::frame .fr\n"
    "pack .fr -fill both -expand TRUE\n"
    "grid columnconfigure .fr 0 -weight 1\n"
    "grid columnconfigure .fr 1 -weight 1\n"
    "grid rowconfigure .fr 0 -weight 1\n"
    "grid rowconfigure .fr 1 -weight 1\n"
    "grid rowconfigure .fr 2 -weight 1\n"
    "ttk::button .fr.but -text \"test\" -command \"func\"\n"
    "grid .fr.but -row 0 -column 0 -columnspan 2 -sticky nswe\n"
    "ttk::label .fr.value -text \"LABEL\" -textvariable label_var -anchor center\n"
    "grid .fr.value -row 1 -column 0 -columnspan 2 -sticky nswe\n"
    "ttk::entry .fr.in -textvariable entry_var\n"
    "set entry_var 0\n"
    "grid .fr.in -row 2\n"
    "bind .fr.in <Return> \"func\"\n"
    "ttk::entry .fr.suff -textvariable format_var\n"
    "grid .fr.suff -row 2 -column 1\n"
    "set format_var 1\n"
    "ttk::combobox .fr.combo -values { \"O2\" \"N2\"} -textvariable gas_var\n"
    "grid .fr.combo -row 3 -column 0 -columnspan 2 -sticky nsew\n"
    "set gas_var \"O2\";"
    "ttk::button .fr.ok_but -text \"OK\" -command \"about_call\";"
    "grid .fr.ok_but -row 4 -column 0 -sticky nswe;"

    "ttk::button .fr.draw_but -text \"draw\" -command \"draw_tk_cb\"; grid .fr.draw_but -row 4 -column 1 -sticky nswe;"

    "ttk::button .fr.quit_but -text \"quit\" -command {destroy .}; grid .fr.quit_but -row 5 -column 0 -sticky nswe;"

    "set oval_radius 10;";

    // link the interfacing function to Tcl interpreter
    Tcl_CreateCommand(interp, "func", func, NULL, NULL);
    Tcl_CreateCommand(interp, "about_call", about_call, NULL, NULL);
    Tcl_CreateCommand(interp, "draw_tk_cb", draw_tk_cb, NULL, NULL);
    Tcl_CreateCommand(interp, "draw_line_tk_cb", draw_line_tk_cb, NULL, NULL);

    char *buffer = 0;
    int length;
    FILE *f = fopen("gui.tcl", "rb");
    fseek(f, 0, SEEK_END);
    length = ftell(f);
    fseek(f, 0, SEEK_SET);
    buffer = malloc(length);
    fread(buffer, 1, length, f);
    // Start GUI and check if any errors
    if (Tcl_Eval(interp, (char *)buffer) == TCL_OK){
        printf("Tcl_Eval msg: %s\n", Tcl_GetStringResult(interp));
        Tk_MainLoop();
    }
    else{
        printf("Tcl_Eval msg: %s\n", Tcl_GetStringResult(interp));
    };
    free(buffer);
}
