!===============================================================================
! 
! Current state of prep(1):(21:59 28 Nov 2025)
! Total lines read ............... 2
! Conditional nesting level....... 0
! G_WRITE (general processing).... T
! G_LLWRITE (write input lines)... T
! Arguments ...................... -i test.tex 
! Open files:
!    unit ! line number ! filename
!      50 !           2 ! test.tex
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
! NAME
!     ftest(3f) - Test this feature.
function ftest(x)result(r)
    integer, intent(in) :: x
    integer :: r
    r  = x+2
end function
