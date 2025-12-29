submodule (fargparser) fargparser_s
    !! Implementations
    implicit none

contains

module procedure print_version
    print '(A)', m%get("name")//' '//m%get("version")
    print '(A)',    ''
    print '(A)',    'Copyright (c) 2025 '//m%get("author")
    print '(A)',    m%get("license")
    print '(A)',    ''
    print '(A)',    'Written by '//m%get("author")
end procedure

module procedure print_help
    print '(A)', 'Usage: '//m%get("name")//' [OPTION...] ARGS'
    print '(A)', m%get("short_description")
    print '(A)',    ''
    print '(a)',    '   -?, --help        Give this help list'
    print '(a)',    '       --usage       Give a short usage message'
    print '(a)',    '   -V, --version     Print program version'
    print '(a)',    ''
    print '(a)',    m%get("long_description")
    print '(a)',    ''
    print '(a)',    'Report bugs to '//m%get("bug_address")
end procedure

end submodule
