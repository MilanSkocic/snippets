module fargparser
    !! Argp-like for Fortran.
    !! Mimic argp available for C but adapted to Fortran OOP.
    use iso_fortran_env, only: output_unit
    use stdlib_string_type
    use stdlib_strings
    use stdlib_stringlist_type
    use stdlib_str2num
    use stdlib_optval, only: optval
    use stdlib_ascii, only: is_alpha
    implicit none
    private
  
    type fargparser_type
        !! It specifies how to document the program
        type(string_type) :: name
        type(string_type) :: version
        type(string_type) :: author
        type(string_type) :: bug_address
        type(string_type) :: short_description
        type(string_type) :: long_description
        type(string_type) :: license
        type(stringlist_type), private :: largs
        contains
            procedure :: init => fargparser_type_initialize
            procedure :: get => fargparser_type_get
            procedure :: print_version => fargparser_type_print_version
            procedure :: print_help  => fargparser_type_print_help
            procedure :: print_usage => fargparser_type_print_usage
            procedure :: list_args => fargparser_type_print_largs 
            procedure :: add_argument => fargparser_type_add_arg
            procedure :: parse => fargparser_type_parse
    end type

    type fargp_option
        !! It specifies a single option that an argp parser understands, 
        !! as well as how to parse and document that option
        type(string_type) :: long
        integer           :: short 
        type(string_type) :: args
        integer           :: flags
        type(string_type) :: help
    end type


    public :: fargparser_type !! derived types

contains


! INIT -------------------------------------------------------------------------
function fargparser_type_initialize(this, name, version, &
                                       author, bug_address, &
                                       short_description, long_description, &
                                       license)&
                                       result(res) 
        !! Initialize the fargparser_type

        ! Parameters
        class(fargparser_type)                 :: this
        character(len=*), intent(in)           :: name              !! Name of the program.
        character(len=*), intent(in)           :: version           !! Version of the program.
        character(len=*), intent(in)           :: short_description !! One-line description of the program.
        character(len=*), intent(in), optional :: long_description  !! Long description of the program.
        character(len=*), intent(in), optional :: author            !! Author of the program.
        character(len=*), intent(in), optional :: bug_address       !! E-mail address for reporting bugs.
        character(len=*), intent(in), optional :: license           !! License

        ! Returns
        integer :: res                                              !! Returns 0 if initialization succeeded otherwise returns > 0.
        
        ! Variables
        integer :: i
        character(len=256) :: arg
        type(string_type) :: sarg

        this%name = string_type(name)
        this%version = string_type(version)
        this%short_description = string_type(short_description)

        this%long_description = string_type(optval(long_description, ""))
        this%author = string_type(optval(author, "unknown author"))
        this%bug_address = string_type(optval(bug_address, ""))
        this%license = string_type(optval(license, "Public Domain"))

        do i=1, command_argument_count()
            call get_command_argument(i, arg)
            sarg = string_type(arg)
            call this%largs%insert_at(bidx(1), strip(sarg))
        end do

        res = 0
        return
end function



! PRINT ------------------------------------------------------------------------
subroutine fargparser_type_print_version(this)
    class(fargparser_type) :: this
    write(output_unit, '(A)') this%get("name")//' '//this%get("version")
    write(output_unit, '(A)')    ''
    write(output_unit, '(a)', advance='no') 'Copyright (c) 2025 '
    if(len(this%author)>0)then
    write(output_unit, '(a)', advance='yes') this%get("author")//'.'
    end if
    write(output_unit, '(A)')    this%get("license")
    write(output_unit, '(A)')    ''
    write(output_unit, '(A)')    'Written by '//this%get("author")
    return
end subroutine

subroutine fargparser_type_print_usage(this)
    class(fargparser_type) :: this
    write(output_unit, '(A)') 'Usage: '//this%get("name")//' [OPTION...] ARGS'
end subroutine

subroutine fargparser_type_print_help(this)
    class(fargparser_type) :: this
    call this%print_usage()
    write(output_unit, '(A)') this%get("short_description")
    write(output_unit, '(A)')    ''
    write(output_unit, '(A)')    '   -?, --help        Give this help list'
    write(output_unit, '(A)')    '       --usage       Give a short usage message'
    write(output_unit, '(A)')    '   -V, --version     Print program version'
    write(output_unit, '(A)')    ''
    if(len(this%long_description) > 0) then
        write(output_unit, '(A)')    this%get("long_description")
    end if
    write(output_unit, '(A)')    ''
    if(len(this%bug_address)>0)then
    write(output_unit, '(A)')    'Report bugs to '//this%get("bug_address")
    else
    write(output_unit, '(A)')    'Reporting bugs is not possible.'
    end if
end subroutine 

subroutine fargparser_type_print_largs(this)
    class(fargparser_type) :: this
    integer :: i
    do i=1, this%largs%len(), 1
        write(output_unit, '(I2, 4X, A)') i, char(this%largs%get(fidx(i)))
    end do
end subroutine

! GETTERS ----------------------------------------------------------------------
function fargparser_type_get(this, prop)result(res)
    class(fargparser_type) :: this
    character(len=*), intent(in) :: prop
    character(len=:), allocatable :: res
    select case (prop)
        case ("name")
            res = char(this%name)
        case ("version")
            res = char(this%version)
        case ("author")
            res = char(this%author)
        case ("bug_address")
            res = char(this%bug_address)
        case ("short_description")
            res = char(this%short_description)
        case ("long_description")
            res = char(this%long_description)
        case ("license")
            res = char(this%license)
        case default
            res = ''
    end select
end function



! PARSER -----------------------------------------------------------------------
function fargparser_type_parse(this)result(res)
    !! Parse all arguments
    class(fargparser_type) :: this
    integer :: res
    
    integer :: i

    do i=1, this%largs%len(), 1
        select case( char( this%largs%get(fidx(i)) ) )
            case ("--version", "-V")
                call this%print_version()
                stop
            case ("--help", "-?")
                call this%print_version()
                stop 
            case ("--usage")
                call this%print_usage()
                stop 
            case default
        end select
                
    end do

    res = 0
end function

end module
