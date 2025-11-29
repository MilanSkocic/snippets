! NAME
!     core - Elementary module
! SYNOPSIS
!     core(3f)
! DESCRIPTION
!     Compute the core physics of a nuclear power plant
!     $ \alpha $
module core

    integer, parameter :: x = 1
    character(len=*), parameter="M. Skocic"

contains

! NAME
!     f(3f) - test function
!> @brief f function
!! @param[in] x input
function f(x)result(r)
    integer, intent(in) :: x
    integer :: r

    r=x+1
end function

integer function g()
! ident_1="@(#) core g(3f) function to copy char array to string"
end function

end module


