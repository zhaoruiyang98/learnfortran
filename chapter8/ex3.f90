program main
  implicit none
  integer :: a
  write(*,*) "Enter:"
  read(*,*) a
  call plot(a)
end program

subroutine plot(a)
  implicit none
  integer :: a, i
  do i=1, a, 1
    write(*,"(a1,$)") '*' ! $ set no newline
  end do
  write(*,*) ' '
end subroutine
