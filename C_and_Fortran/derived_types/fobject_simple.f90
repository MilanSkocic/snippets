module fobject_simple
    use iso_fortran_env
    use iso_c_binding
    implicit none

    ! Simple case where the Fortran derived can be mapped to a C struct
    ! This is the case when everything is static in the derived type: no pointer, no bound-procedures
    
    ! First a pure Fortran derived type is defined
    type :: fobj_simple
        integer(int32) :: n
        real(real32) :: array(3)
        character(len=32) :: name
    end type

    ! A C compatible derived type is created
    type, bind(C) :: fobj_simple_capi
        integer(c_int) :: n
        real(c_float) :: array(3)
        character(kind=c_char) :: name(33)
    end type

    integer(int32) :: i

    ! define a new pure Fortran object
    type(fobj_simple), parameter :: obj_simple = fobj_simple(1, [(i,i=1,3)], "Fortran simple object")
    
    ! define the C object from the Fortran object
    type(fobj_simple_capi), protected, bind(C) :: obj_simple_capi = fobj_simple_capi(&
    obj_simple%n,&
    obj_simple%array,&
    ["F","o","r","t","r","a","n"," ","s","i","m","p","l","e"," ","o","b","j","e","c","t",c_null_char,&
    " "," "," "," "," "," "," "," "," "," "," "])

end module