module fobject_cmpl
    use iso_fortran_env
    use iso_c_binding
    implicit none

    ! Complex case where the Fortran derived can not be mapped directly
    ! This is the case when there are pointers and bound-procedures
    ! The trick is to pass the derived type to C as pointer (void *)
    ! wrap all bound procedures with procedures that will accept a C pointer void*

    type :: objcmpl
        integer(int32) :: n
        real(real32), pointer :: array(:)
        character(len=:), pointer :: name
    contains
        procedure :: print => objcmpl_print
    end type

contains

subroutine objcmpl_print(self)
    implicit none
    class(objcmpl), intent(in) :: self
    print *, self%name
    print *, self%n
    print *, self%array
end subroutine

subroutine objcmpl_del(o)
    implicit none
    type(objcmpl), intent(inout), pointer :: o
    deallocate(o%array)
    deallocate(o%name)
    deallocate(o)
end subroutine

pure function objcmpl_init(n, value)result(p)
    implicit none
    integer(int32), intent(in) :: n
    real(real32), intent(in) :: value
    type(objcmpl), pointer :: p
    
    allocate(p)
    allocate(p%array(n))
    allocate(p%name, source="F OBJECT"//c_null_char)
    
    p%n = n
    p%array = value
end function

function objcmpl_capi_getname(o)result(name)bind(c)
    implicit none
    type(c_ptr), intent(in), value :: o
    type(c_ptr) :: name
    type(objcmpl), pointer :: fp
    nullify(fp)
    call c_f_pointer(o, fp)

    name = c_loc(fp%name)

end function

subroutine objcmpl_capi_print(o)bind(c)
    implicit none
    type(c_ptr), intent(in), value :: o
    type(objcmpl), pointer :: fp
    nullify(fp)
    call c_f_pointer(o, fp)
    call fp%print()
end subroutine

subroutine objcmpl_capi_del(o)bind(c)
    implicit none
    type(c_ptr), intent(in), value :: o
    type(objcmpl), pointer :: fp
    nullify(fp)
    call c_f_pointer(o, fp)
    call objcmpl_del(fp)
end subroutine

pure function objcmpl_capi_init(n, value)result(p)bind(c)
    implicit none
    integer(c_int), intent(in), value :: n
    real(c_float), intent(in), value :: value

    type(c_ptr) :: p

    type(objcmpl), pointer :: fp
    fp => objcmpl_init(n, value)
    p = c_loc(fp)
end function

end module