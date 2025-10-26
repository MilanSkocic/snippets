program main
    implicit none

    integer, parameter :: buffer_size = 256
    character(len=*), parameter :: VERSION = "0.1"
    character(len=*), parameter :: PROGRAM_NAME = "F PROGRAM"

    character(len=buffer_size) :: arg
    integer :: i
    real :: r


    do i=1, command_argument_count()
        call get_command_argument(i, arg)
        select case(arg)
            case ("-v", "--version")
                print ("(2A)"), "version ", VERSION
                stop
            case ("-h", "--help")
                call print_help()
                stop
            case default
                read (arg, "(F10.1)") r
        end select
    end do

    print *, r

contains
    subroutine print_help()
        print *, 'usage: ', PROGRAM_NAME, " [OPTIONS] args"
        print '(a)',    ''
        print '(a)',    '   -v, --version     print version information and exit'
        print '(a, /)', '   -h, --help        print usage information and exit'
    end subroutine print_help

    
end program main