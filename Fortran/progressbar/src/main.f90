program main
use, intrinsic :: iso_fortran_env, only: int32, real32, real64, output_unit
use progress, only: display_progress
implicit none(type, external)

! lest integrate a progress bar in the main code
integer(int32):: i, N
real(real64):: x, start, end, p

N = 20000000

call cpu_time(start)

do i = 1, N, 1
p = real(i, kind = real64) / real(N,kind=real64)*100
call display_progress(x=real(p, kind = real32), n=72)
end do

write(output_unit, *) ""

call cpu_time(end)

print *, end-start

end program main
