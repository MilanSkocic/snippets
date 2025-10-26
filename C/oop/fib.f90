!!
!> @file fib.f90
!!

!> @brief Compute the Fibonacci serie.
!! @param A Pointer to the array to perform the computation on
!! @param N Array size
SUBROUTINE FIBF90(A,N)

    INTEGER, intent(in) :: N
    REAL(8), dimension(N), intent(out) :: A

    DO I=1,N
     IF (I==1) THEN
        A(I) = 0.0D0
     ELSEIF (I==2) THEN
        A(I) = 1.0D0
     ELSE 
        A(I) = A(I-1) + A(I-2)
     ENDIF
    ENDDO
END

!> @brief Scale an array.
!! @param A Pointer to the array to perform the computation on
!! @param N Array size
subroutine dscal(a, X, N)
   integer, intent(in) :: N
   real(8), dimension(N), intent(out) :: X
   real(8), intent(in) :: a

   X = a*X

end 