module mandelbrot__core
       use iso_fortran_env
       implicit none
       private

public :: mandelbrot_core_mb, mandelbrot_core_jl

contains

pure elemental function mandelbrot_core_mb(z, n, d) result (r)
       !! Compute the convergence value according to Mandelbrot.
       implicit none

       ! Arguments
       complex(real64), intent(in) :: z
              !! Complex value.
       integer(int32), intent(in) :: n
              !! Iterations for the convergence.
       real(real64), intent(in) :: d
              !! Threshold value for the convergence

       ! Returns
       integer(int32) :: r 
       
       ! locals
       integer(int32) :: i 
       complex(real64) :: buffer
       buffer = (0.0d0, 0.0d0)

       do i=1, n
       buffer = buffer**2 + z
              if (abs(buffer)>d) then 
                     r = int(real(i, kind=real64) * 255.0d0/real(n, kind=real64), kind=int32)
                     return 
              end if 
       end do

       r = i * 255/n

end function 

pure elemental function mandelbrot_core_jl(z, c, n, d) result (r)
       !! Compute the convergence value according to Julia.
       implicit none

       ! Arguments
       complex(real64), intent(in) :: z
              !! Complex value.
       complex(real64), intent(in) :: c
              !! Complex value to add to z.
       integer(int32), intent(in) :: n
              !! Iterations for the convergence.
       real(real64), intent(in) :: d
              !! Threshold value for the convergence

       ! Returns
       integer(int32) :: r 
       
       ! locals
       integer(int32) :: i 
       complex(real64) :: buffer
       buffer = z

       do i=1, n
       buffer = buffer**2 + c
              if (abs(buffer)>d) then 
                     r = i * 255/n
                     return 
              end if 
       end do

       r = i * 255/n

end function 

end module