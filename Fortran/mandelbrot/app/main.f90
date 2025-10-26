program main
    use iso_fortran_env
    use stdlib_math,  only: linspace
    use mandelbrot__core
implicit none

integer(int32) :: N
integer(int32) :: M

real(real64), allocatable :: x(:), y(:), xx(:, :), yy(:, :)
integer(int32), allocatable :: data(:, :)
complex(real64), allocatable :: zz(:,:)
logical :: exist

integer(int32)  :: unit
integer(int32) :: iter

complex(real64) :: c 
integer(int32) :: i, j, k

character(len=256) :: fpath, arg
n = 0
m = 0
iter = 0
do i=1, command_argument_count()
        select case(i)
                case(1)
                        call get_command_argument(i, arg)
                        read(arg, "(I5)") N
                case(2)
                        call get_command_argument(i, arg)
                        read(arg, "(I5)") M
                case(3)
                        call get_command_argument(i, arg)
                        read(arg, "(I5)") iter
        end select
end do

if (iter<10) then
        iter = 10
endif
if (n<100) then
        n = 100
endif
if (m<100) then
        m = 100
endif

print *, n, m, iter

allocate(x(N))
allocate(y(m))
allocate(xx(m, n))
allocate(yy(m, n))
allocate(data(m, n))
allocate(zz(m, n))

x = linspace(-2.0d0, 1.0d0, N)
y = linspace(-1.0d0, 1.0d0, M)

xx = spread(x, 1, M)
yy = spread(y, 2, N)

zz = cmplx(xx, yy)

data(:,:) = mandelbrot_core_mb(zz, iter, 2.0d0)
print *, "Mandelbrot computation done."

fpath = "./xx.txt"
inquire(file=fpath, exist=exist)
if(exist)then
        open(file=fpath, newunit=unit, status="old")
        close(unit, status="delete")
endif
open(file=fpath, newunit=unit, status="new")
do i=1, M
        write(unit, *) xx(i, :)
enddo

fpath = "./yy.txt"
inquire(file=fpath, exist=exist)
if(exist)then
        open(file=fpath, newunit=unit, status="old")
        close(unit, status="delete")
endif
open(file=fpath, newunit=unit, status="new")
do i=1, M
        write(unit, *) yy(i, :)
enddo

fpath = "./mb.txt"
inquire(file=fpath, exist=exist)
if(exist)then
        open(file=fpath, newunit=unit, status='old')
        close(unit, status="delete")
endif
open(file=fpath, newunit=unit, status="new")
do i=1, M
        write(unit, *) data(i, :)
enddo
print *, "Saving done."

c = cmplx(-0.8d0, 0.156d0)
data(:,:) = mandelbrot_core_jl(zz, c, iter, 2.0d0)
print *, "Julia computation done."

fpath = "./jl.txt"
inquire(file=fpath, exist=exist)
if(exist)then
        open(file=fpath, newunit=unit, status='old')
        close(unit, status="delete")
endif
open(file=fpath, newunit=unit, status="new")
do i=1, M
        write(unit, *) data(i, :)
enddo
print *, "Saving done."

end program