module core
    use iso_fortran_env
    implicit none

    
contains

function f1(x,y)result(res) !! prototype
    integer, intent(in) :: x
    integer, intent(in) :: y
    integer :: res

    res = 0

end function

function f2(x,y)result(res) !! prototype
    integer, intent(in) :: x
    integer, intent(in) :: y
    integer :: res
    res = 0
end function

end module
