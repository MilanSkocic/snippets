module progress
use, intrinsic :: iso_fortran_env, only: real32, int32, output_unit
implicit none(type, external)
private
public:: display_progress

contains

subroutine display_progress(x, n, c)
!! Display a progress bar.
real(real32), intent(in):: x    !! Percentage of progress.
integer(int32), intent(in):: n  !! Length of the progressbar.
character(len=1), intent(in),  optional :: c

character(len = n-5):: progressbar
character(len = n):: progress
integer(int32):: p
integer(int32):: prel
character(len = 5):: pstr
character(len=1) :: m

if(present(c)) then
    m = c
else
    m = '='
end if

p = nint(x, kind=int32)
prel = p*n / 100
write(pstr, "(1X, I3, A)") p, "%"
progressbar = repeat(m, prel)
progress = progressbar//adjustr(pstr)
write(output_unit, "(A1,A)", advance="NO") achar(13), progress
flush(output_unit)

end subroutine display_progress

end module progress
