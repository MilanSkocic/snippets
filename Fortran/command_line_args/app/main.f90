program main
    use iso_fortran_env, only: output_unit
    use stdlib_ansi, only : fg_color_blue, style_bold, style_reset, ansi_code, &
    & operator(//), operator(+)
    use stdlib_string_type
    use stdlib_strings
    use stdlib_stringlist_type
    use stdlib_str2num, only: to_num
    use stdlib_kinds, only: sp, dp
    use stdlib_math, only: linspace
    use fargparser
    implicit none
    
    ! Parameters
    integer, parameter :: buffer_size = 256
    character(len=*), parameter :: VERSION = "0.1"
    character(len=*), parameter :: PROGRAM_NAME = "fapp"
    character(len=*), parameter :: AUTHOR = "M. Skocic"
    character(len=*), parameter :: SHORT_DESCRIPTION = PROGRAM_NAME//' - '//'Test program in Fortran.'
    character(len=*), parameter :: DESCRIPTION = 'This text goes under the options.'
    character(len=*), parameter :: EMAIL = '<milan.skocic@gmail.com>'
  
    type(program_type) :: m

    ! variables
    type(ansi_code) :: highlight 
    integer :: iostat, errstat
    character(len=buffer_size) :: arg
    integer :: i, j, k, l, start, end, n
    real(dp) :: r
    character(len=64) :: s

    type(string_type) :: myarg
    type(stringlist_type)       :: options
    type(stringlist_type)       :: args
    type(stringlist_index_type) :: index

    type(fargp_option) :: myoptions(1) 
    
    myoptions(1)%name = "--print"

    highlight = fg_color_blue + style_bold

    errstat = m%init(name="fapp", version="1.0", &
               SHORT_DESCRIPTION="Short description of the program can do.",&
           author="M. Skocic", bug_address="<milan.skocic@gmail.com>")

    call m%list_args
    call m%list_options

!    do i=1, command_argument_count()
!        call get_command_argument(i, arg)
!        myarg=strip(string_type(arg))
!        if(starts_with(myarg, "-") .eqv. .true.) then 
!            call options%insert_at(bidx(1), myarg) 
!        else
!            call args%insert_at(bidx(1), myarg)
!        end if
!        select case(arg)
!            case ("-V", "--version")
!                call print_version(m)
!            case ("-?", "--help")
!                call print_help(m)
!            case default
!                r = to_num(arg, r)
!                print *, r
!        end select
!    end do
!
!    call list_args()

contains



function parse_opt(key, arg, state)result(res)
    integer, intent(in) :: key 
    character(len=*)    :: arg
    type(fargp_state)   :: state
    integer             :: res
end function
    
end program main
