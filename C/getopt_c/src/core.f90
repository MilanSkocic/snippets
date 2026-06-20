module core
use iso_fortran_env, only: dp=>real64
use iso_c_binding, only: c_ptr, c_int, c_double
implicit none(type, external)

real(dp), parameter :: kB = 1.38d-23
real(dp), parameter :: e = 1.61d-19

contains

elemental real(dp) function purekTe(T)
real(dp), intent(in):: T
purekTe = kB/e*(T+273.15) *1d3
end function

subroutine kTe(T, k)
real(dp), intent(in) :: T(:)
real(dp), intent(out) :: k(:)
k = purekTe(T)
end subroutine

subroutine kTe_capi(T, k, n)bind(C, name="kTe")
integer(c_int), intent(in), value :: n
real(c_double), intent(in) :: T(n)
real(c_double), intent(out) :: k(n)
call kTe(T, k)
end subroutine

end module