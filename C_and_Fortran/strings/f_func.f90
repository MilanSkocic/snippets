!>
!! @file
!! @author Milan Skocic
!! @brief Fortran module.

!>
!! @brief Fortran functions and interfaces to C code. 
module f_func
    use precision
    use, intrinsic :: ieee_arithmetic
    implicit none

    !> @brief C Interfaces
    interface
        
        !> @fn f_func::c_func::c_func(C, m, n)  
        !! @brief C function which prints a rank-2 array
        !! @param[in] C rank-2 array
        !! @param[in] m number of rows
        !! @param[in] n number of cols
        subroutine c_func(C, m, n) bind(C)
            use iso_c_binding
            integer(c_int), intent(in) :: m
            integer(c_int), intent(in) :: n
            real(c_double), intent(in), dimension(m, n) :: C
        end subroutine


        !> @fn f_func::colmajor_to_rowmajor::colmajor_to_rowmajor(C, m, n, R)
        !! @brief Transform a Fortran array to a C array
        !! @param[in] C rank-2 array stored as column major layout
        !! @param[in] m row number of rows
        !! @param[in] n col number of columns
        !! @param[out] R rank-2 array stored as row major layout.
        subroutine colmajor_to_rowmajor(C, m, n, R) bind(C)
            use iso_c_binding
            integer(c_int), intent(in) :: m
            integer(c_int), intent(in) :: n
            real(c_double), intent(in), dimension(m, n) :: C
            real(c_double), intent(out), dimension(m, n) :: R
        end subroutine

        !> @fn f_func::c_print_string::c_print_string(char_p)
        !! @brief Print a string
        !! @param[in] char_p String to be printed
        subroutine c_print_string(char_p) bind(c)
            use iso_c_binding, only : c_ptr
            type(c_ptr), intent(in), value :: char_p
        end subroutine

    end interface

contains
        
        !> @brief Return a C pointer of a Fortran string pointer
        !! @details The Fortran string is ensured to be null-terminated by
        !! adding a \0 character at the last position.
        !! @param[in] f_string Pointer to a Fortran string
        !! @return C pointer.
        !!
        function f2c_string(f_string)
            use iso_c_binding, only : c_char, c_ptr, c_loc, c_null_char
            implicit none
            character(len=:), intent(in), pointer  :: f_string
            type(c_ptr):: f2c_string
            integer :: n
            n = len(f_string)
            f_string(n:n) = c_null_char
            f2c_string = c_loc(f_string)
        end function

        !> @brief Return a C pointer of a Fortran array of char
        !! @details The Fortran string is ensured to be null-terminated by
        !! adding a \0 character at the last position.
        !! @param[in] f_str_array Fortran rank-1 array of char.
        !! @return C pointer.
        !!
        function f2c_string_array(f_str_array)
            use iso_c_binding, only : c_ptr, c_loc, c_null_char
            implicit none
            character, dimension(:), allocatable, intent(in), target :: f_str_array
            type(c_ptr) :: f2c_string_array
            f2c_string_array = c_loc(f_str_array)
        end function

        !> @brief Transform a C pointer to an Fortran pointer of char(:)
        !! @param[in] char_p C pointer to a string.
        !! @param[in] length Length of the string
        !! @return Fortran pointer to a string.
        !! 
        function c2f_string(char_p, length) 
            use iso_c_binding, only : c_int, c_ptr, c_f_pointer
            implicit none
            integer(c_int), intent(in), value :: length
            type(c_ptr), intent(in), value :: char_p
            character, pointer, dimension(:) :: c2f_string
            call c_f_pointer(char_p, c2f_string, shape=[length+1])
        end function

        !> @brief Check is a Fortran string is null-terminated
        !! @param[in] f_string Pointer to Fortran string.
        !! @return True or False
        pure function is_zero_terminated(f_string)
            use iso_c_binding, only : c_null_char
            implicit none
            character(len=:), intent(in), pointer :: f_string
            logical :: is_zero_terminated
            integer :: n, i
            n = len(f_string)
            is_zero_terminated = .false.
            do i=1, n
                if(f_string(i:i) == c_null_char)then
                    is_zero_terminated = .true.
                else
                    is_zero_terminated = .false.
                end if
            end do

        end function

        !> @brief Print a C string
        !! @param[in] char_p C pointer to char
        !! @param[in] length Length of the C string.
        subroutine f_print(char_p, length)bind(c)
            use iso_c_binding, only : c_int, c_ptr
            implicit none
            integer(c_int), intent(in), value :: length
            type(c_ptr), intent(in), value :: char_p
            print *, c2f_string(char_p, length)
        end subroutine

        !> @brief Copy a scalar string into an array string. 
        !! @param[in] f_string Pointer to a scalar string.
        !! @param[out] f_string_array rank-1 array string.
        subroutine str2array(f_string, f_string_array)
            implicit none
            character(len=:), intent(in), allocatable :: f_string
            character, intent(out), dimension(len(f_string)) :: f_string_array
            integer :: n, i
            n = len(f_string)
            do i=1, n
                f_string_array(i) = f_string(i:i)
            end do
        end subroutine

        function get_nan() bind(C)
            real(c_double) :: get_nan
            get_nan = ieee_value(1.0d0, ieee_quiet_nan)
        end function

end module f_func