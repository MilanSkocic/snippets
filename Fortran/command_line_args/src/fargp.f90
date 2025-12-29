module fargp
    !! Argp-like for Fortran.
    !! Mimic argp available for C but adapted to Fortran OOP.
    use stdlib_string_type
    use stdlib_str2num
    implicit none
    private

    abstract interface
        function myparser(key, arg, state)result(res)
            integer, intent(in) :: key 
            character(len=*)    :: arg
            type(fargp_state)   :: state
            integer             :: res
        end function    
    end interface

    type fargp_metadata
        !! It specifies how to document the program
        type(string_type) :: name
        type(string_type) :: version
        type(string_type) :: author
        type(string_type) :: bug_address
        type(string_type) :: short_description
        type(string_type) :: long_description
        type(string_type) :: license
        contains
            procedure :: get
    end type

    type fargp_option
        !! It specifies a single option that an argp parser understands, 
        !! as well as how to parse and document that option
        type(string_type) :: name 
        integer           :: key 
        type(string_type) :: args
        integer           :: flags
        type(string_type) :: doc
        integer    :: group
    end type

    type fargp_state
    
    end type

    type fargp
        !! It specifies how to parse a given set of options and arguments. 
        type(fargp_option) :: options(:)
        procedure(myparser), pointer, nopass :: parser 
        type(string_type) :: args_doc !! Inline documentation for ARGS. Only used in Usage:...
        type(string_type) :: doc !! Additional doc to be printed.
    interface
        module subroutine print_version(m)
            type(fargp_metadata) :: m
        end subroutine
        module subroutine print_help(m, options)
            type(fargp_metadata), intent(in) :: m
            type(fargp_option), optional :: options(:)
        end subroutine
    end interface

    public :: fargp_metadata, fargp_option, fargp_state
    public :: print_version, print_help

contains

function get(this, prop)result(res)
    class(fargp_metadata) :: this
    character(len=*), intent(in) :: prop
    character(len=:), allocatable :: res
    select case (prop)
        case ("name")
            res = char(this%name)
        case ("version")
            res = char(this%version)
        case ("author")
            res = char(this%author)
        case ("bug_address")
            res = char(this%bug_address)
        case ("short_description")
            res = char(this%short_description)
        case ("long_description")
            res = char(this%long_description)
        case ("license")
            res = char(this%license)
        case default
            res = ''
    end select
    return
end function


end module
