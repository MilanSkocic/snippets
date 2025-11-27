!===============================================================================
! 
! Current state of prep(1):(05:48 27 Nov 2025)
! Total lines read ............... 2
! Conditional nesting level....... 0
! G_WRITE (general processing).... T
! G_LLWRITE (write input lines)... T
! Arguments ...................... --comment doxygen core.FF 
! Open files:
!    unit ! line number ! filename
!      50 !           2 ! core.FF
! INCLUDE directories:
!    .
! Variables:(There are 10 variables defined)
!    $DEFINE WINDOWS  =  3
!    $DEFINE UNKNOWN  =  0
!    $DEFINE SYSTEMON  =  .FALSE.
!    $DEFINE SOLARIS  =  5
!    $DEFINE OS  =  1
!    $DEFINE OPENBSD  =  7
!    $DEFINE MACOS  =  2
!    $DEFINE LINUX  =  1
!    $DEFINE FREEBSD  =  6
!    $DEFINE CYGWIN  =  4
!-------------------------------------------------------------------------------
!>
!!##NAME
!!     core - Elementary module
!!##SYNOPSIS
!!
!!     core(3f)
!!##DESCRIPTION
!!     Compute the core physics of a nuclear power plant
!!     $ \alpha $
module core

    integer, parameter :: x = 1
    character(len=*), parameter="M. Skocic"

contains

!>
!!##NAME
!!     f(3f) - test function
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


