program main
    use iso_c_binding
    use iso_fortran_env
    implicit none

    real :: b(10)

    b = get()

    print *, b

    
contains

function get()result(res)

    real, allocatable :: res(:)
    allocate(res(10))
    res = 1.2

end function


function cget()result(res)
    
    real(c_float), allocatable :: res(:)
    
    integer(int32) :: n

    n = size(get())

    allocate(res(n))

    res = get()


end function

    
end program main
