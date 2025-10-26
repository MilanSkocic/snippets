program main
    use, intrinsic :: iso_c_binding, only: c_associated, c_ptr
    use :: tcl
    use :: tk
    implicit none (type, external)

    integer     :: rc
    type(c_ptr) :: interp
    character(len=*), parameter :: SCRIPT_FILE = 'gui.tcl'

    ! Create Tcl interpreter.
    interp = tcl_create_interp()
    if (.not. c_associated(interp)) stop 'Error: Tcl_CreateInterp() failed'

! Initialise Tcl.
    if (tcl_init(interp) /= TCL_OK) then
        call tcl_delete_interp(interp)
        stop 'Error: Tcl_Init() failed'
    end if

    ! Initialise Tk.
    if (tk_init(interp) /= TCL_OK) then
        call tcl_delete_interp(interp)
        stop 'Error: Tk_Init() failed'
    end if

    ! Evaluate string as Tcl command.
    rc = tcl_eval_ex(interp, 'puts "Hello, from Tcl!"')
    if (rc /= TCL_OK) print '("Error: Tcl_EvalEx() failed")'
    

    rc = tcl_eval_file(interp, SCRIPT_FILE)
    call tk_main_loop()
    call tcl_exit(0)
end program main