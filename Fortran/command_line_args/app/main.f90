program main
    use stdlib_ansi, only : fg_color_blue, style_bold, style_reset, ansi_code, &
    & operator(//), operator(+)
    use stdlib_string_type
    use stdlib_strings
    use stdlib_stringlist_type
    use stdlib_str2num, only: to_num
    use stdlib_kinds, only: sp, dp
    use stdlib_math, only: linspace
    use fargp
    implicit none
    
    ! Parameters
    integer, parameter :: buffer_size = 256
    character(len=*), parameter :: VERSION = "0.1"
    character(len=*), parameter :: PROGRAM_NAME = "fapp"
    character(len=*), parameter :: AUTHOR = "M. Skocic"
    character(len=*), parameter :: SHORT_DESCRIPTION = PROGRAM_NAME//' - '//'Test program in Fortran.'
    character(len=*), parameter :: DESCRIPTION = 'This text goes under the options.'
    character(len=*), parameter :: EMAIL = '<milan.skocic@gmail.com>'
  
    type(fargp_metadata) :: m

    ! variables
    type(ansi_code) :: highlight 
    integer :: iostat
    character(len=buffer_size) :: arg
    integer :: i, j, k, l, start, end, n
    real(dp) :: r
    character(len=64) :: s

    type(string_type) :: myarg
    type(stringlist_type)       :: options
    type(stringlist_type)       :: args
    type(stringlist_index_type) :: index
    
    highlight = fg_color_blue + style_bold

    m%name = "fapp"
    m%author = "M. Skocic"
    m%version = "0.1"
    m%bug_address = "<milan.skocic@gmail.com>"
    m%short_description = "Test program in Fortran."
    m%long_description = 'This text goes under the options.'
    m%license = 'MIT License'

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
                call print_version(m)
            case ("-?", "--help")
                call print_help(m)
            case default
                r = to_num(arg, r)
                print *, r
        end select
    end do

    call display_string_list(options)
    call display_string_list(args)


contains


subroutine display_string_list(strlist)
    type(stringlist_type), intent(in) :: strlist

    integer :: i
    do i=1, strlist%len(), 1
        print '(I2, 4X, A)', i, char(strlist%get(fidx(i)))
    end do
end subroutine

function parse_opt(key, arg, state)result(res)
    integer, intent(in) :: key 
    character(len=*)    :: arg
    type(fargp_state)   :: state
    integer             :: res
end function
    
end program main
