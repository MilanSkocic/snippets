!>
!! @file


!>
!! @brief Precision module
module precision
    use iso_c_binding
    implicit none

    integer, parameter :: dp = kind(c_double) !< Double precision.
    integer, parameter :: sp = kind(c_float)  !< Simple precision

    real(kind=dp), protected :: pi = 4*atan(1.0_dp)

    !> @brief Point type
    type, bind(c) :: t_point
        real(c_double) :: x !< x coordinates
        real(c_double) :: y !< y coordinates
    end type

end module precision