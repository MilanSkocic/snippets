program main
    implicit none
    external dgemm

    integer(kind=4) :: i, j
    integer(kind=4), parameter :: m = 5
    integer(kind=4), parameter :: k = 5
    integer(kind=4), parameter :: n = 2

    real(kind=8), dimension(m, k) :: A
    real(kind=8), dimension(k, n) :: B
    real(kind=8), dimension(m, n) :: C

    CHARACTER :: TRANSA = 'N'
    CHARACTER :: TRANSB = 'N'

    integer(kind=4) :: LDA = m
    integer(kind=4) :: LDB = k
    integer(kind=4) :: LDC = m

    real(kind=8) :: alpha = 0.1
    real(kind=8) :: BETA = 2.21

    do i=1, m
        do j=1, k
            A(i,j) = i+j-2
        end do
    end do
    
    do i=1, k
        do j=1, n
            B(i,j) = i+j-2
        end do
    end do
    
    do i=1, m
        do j=1, n
            C(i,j) = i+j-2
        end do
    end do
    

    call dgemm(TRANSA, TRANSB, m, n, k, alpha, A, LDA, B, LDB, BETA, C, LDC)
    
    do i=1, m
           print "(2F10.5, A)", C(i,:)
    end do
    

end program main