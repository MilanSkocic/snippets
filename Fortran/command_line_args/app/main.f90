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
    
    type(fargparser_type) :: m

    ! variables
    type(ansi_code) :: highlight 
    integer :: iostat, errstat
    integer :: i, j, k, l, start, end, n

    highlight = fg_color_blue + style_bold

    errstat = m%init(name="fapp", version="1.0", &
                     SHORT_DESCRIPTION="Short description of the program can do.",&
                     author="M. Skocic", bug_address="<milan.skocic@gmail.com>")
    

    errstat = m%parse()
    

    

contains

end program main
