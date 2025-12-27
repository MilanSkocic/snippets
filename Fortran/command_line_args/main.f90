program main
    implicit none

    integer, parameter :: buffer_size = 256
    character(len=*), parameter :: VERSION = "0.1"
    character(len=*), parameter :: PROGRAM_NAME = "fapp"
    character(len=*), parameter :: AUTHOR = "M. Skocic"
    character(len=*), parameter :: SHORT_DESCRIPTION = PROGRAM_NAME//' - '//'Test program in Fortran.'
    character(len=*), parameter :: DESCRIPTION = 'This text goes under the options.'
    character(len=*), parameter :: EMAIL = '<milan.skocic@gmail.com>'
    
    integer :: iostat

    character(len=buffer_size) :: arg
    integer :: i
    real :: r
    character(len=64) :: s


    do i=1, command_argument_count()
        call get_command_argument(i, arg)
        select case(arg)
            case ("-V", "--version")
                call print_version()
                stop
            case ("-?", "--help")
                call print_help()
                stop
            case default
                read (arg, "(F10.1)", iostat=iostat) r
                if(iostat == 0)then 
                    print *, r
                    stop
                end if
                read (arg, "(A)", iostat=iostat) s
                if(iostat == 0)then 
                    print *, s
                    stop
                end if
        end select
    end do


contains

subroutine print_help()
    print '(A)', 'Usage: '//PROGRAM_NAME//' [OPTION...] ARGS'
    print '(A)', SHORT_DESCRIPTION
    print '(A)',    ''
    print '(a)',    '   -?, --help        Give this help list'
    print '(a)',    '       --usage       Give a short usage message'
    print '(a)',    '   -V, --version     Print program version'
    print '(a)',    ''
    print '(a)',    DESCRIPTION
    print '(a)',    ''
    print '(a)',    'Report bugs to '//EMAIL
end subroutine print_help

subroutine print_version()
    print '(A)', PROGRAM_NAME//' '//VERSION
    print '(A)',    ''
    print '(A)',    'Copyright (c) 2025 '//AUTHOR
    print '(A)',    'MIT License'
    print '(A)',    ''
    print '(A)',    'Written by '//AUTHOR
end subroutine
    
end program main
