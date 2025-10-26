program fmain
    use fobject_simple
    use fobject_cmpl
    implicit none

    type(objcmpl), pointer :: obj_cmpl

    ! SIMPLE FORTRAN DERIVED TYPE
    print *, obj_simple%name
    print *, obj_simple%n
    print *, obj_simple%array

    ! COMPLEXE FORTRAN TYPE
    obj_cmpl => objcmpl_init(3, 6.2)
    call obj_cmpl%print()
    call objcmpl_del(obj_cmpl)


end program