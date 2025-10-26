program main
  use iso_fortran_env, only: int32, real32, real64, output_unit
  use progress, only: display_progress
  implicit none
  
  ! lest integrate a progress bar in the main code
  integer(int32):: i
  real(real64):: x, start, end, p

  x = huge(x)
  print *, x
  call cpu_time(start)
  do i = 1, huge(i), 1000
    x = x/1.00000001d0
    p = real(i, kind = real64)/real(huge(i), kind = real64)*100
    call display_progress(real(p, kind = real32), 100)
  end do
  write(output_unit, *) ""
  call cpu_time(end)

  print *, end-start

end program main
