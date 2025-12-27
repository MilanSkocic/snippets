program main
    use stdlib_ansi, only : fg_color_blue, style_bold, style_reset, ansi_code, &
    & operator(//), operator(+)
    use stdlib_string_type
    use stdlib_strings
    use stdlib_stringlist_type
    use stdlib_str2num, only: to_num
    use stdlib_kinds, only: sp, dp
    implicit none
    
    ! Parameters
    integer, parameter :: buffer_size = 256
    character(len=*), parameter :: VERSION = "0.1"
    character(len=*), parameter :: PROGRAM_NAME = "fapp"
    character(len=*), parameter :: AUTHOR = "M. Skocic"
    character(len=*), parameter :: SHORT_DESCRIPTION = PROGRAM_NAME//' - '//'Test program in Fortran.'
    character(len=*), parameter :: DESCRIPTION = 'This text goes under the options.'
    character(len=*), parameter :: EMAIL = '<milan.skocic@gmail.com>'
   
    ! variables
    type(ansi_code) :: highlight 
    integer :: iostat
    character(len=buffer_size) :: arg
    integer :: i
    real(dp) :: r
    character(len=64) :: s

    type(string_type) :: myarg
    type(stringlist_type)       :: options
    type(stringlist_type)       :: args
    type(stringlist_index_type) :: index
    
    highlight = fg_color_blue + style_bold


    do i=1, command_argument_count()
        call get_command_argument(i, arg)
        myarg=strip(string_type(arg))
        if(starts_with(myarg, "-") .eqv. .true.) then 
            call options%insert_at(bidx(1), myarg) 
        else
            call args%insert_at(bidx(1), myarg)
        end if
        select case(arg)
            case ("-V", "--version")
                call print_version()
            case ("-?", "--help")
                call print_help()
            case default
                r = to_num(arg, r)
                print *, r
        end select
    end do

    call display_string_list(options)
    call display_string_list(args)


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


subroutine display_string_list(strlist)
    type(stringlist_type), intent(in) :: strlist

    integer :: i
    do i=1, strlist%len(), 1
        print '(I2, 4X, A)', i, char(strlist%get(fidx(i)))
    end do
end subroutine
    
end program main
