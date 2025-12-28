module fargp
    !! Argp-like for Fortran.
    !! Mimic argp available for C but adapted to Fortran OOP.
    use stdlib_string_type
    implicit none
    private

    type fargp_metadata
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

    interface
        module subroutine print_version(m)
            type(fargp_metadata) :: m
        end subroutine
        module subroutine print_help(m)
            type(fargp_metadata), intent(in) :: m
        end subroutine
    end interface

    public :: fargp_metadata
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
