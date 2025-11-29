! NAME
!     test(3f) - Dummy test module
module test
    use iso_fortran_env

contains
end module
! NAME
!     ftest(3f) - Test this feature.
function ftest(x)result(r)
    integer, intent(in) :: x
    integer :: r
    r  = x+2
end function
! NAME
!     tafel(3f) - Test this feature.
function tafel(x)result(r)
    integer, intent(in) :: x
    integer :: r
    r  = x+2
end function
end module
