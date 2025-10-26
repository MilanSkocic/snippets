module progress
    use iso_fortran_env, only: real32, int32, output_unit
    implicit none
    private
    public:: display_progress
contains

subroutine display_progress(x, n)
    !! Display a progress bar.
    implicit none
    real(real32), intent(in):: x
        !! Percentage of progress.
    integer(int32), intent(in):: n
        !! Length of the progressbar.

    character(len = n):: progressbar
    character(len = n+4):: progress
    integer(int32):: p
    integer(int32):: prel
    character(len = 4):: pstr 

    p = nint(x, kind = int32)
    prel = p*n / 100
    write(pstr, "(I3, A)") p, "%"
    progressbar = repeat("=", prel)
    progress = progressbar//pstr 
    write(output_unit, "(A1, A)", advance="NO") achar(13), progress
    flush(output_unit)

end subroutine

end module
