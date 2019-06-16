program main
  implicit none
  real :: a, b
  write(*,*) "Please enter the radius:"
  read(*,*) a
  call sub(a,b)
  write(*,*) "Area:", b
end program

subroutine sub(a,b)
  implicit none
  real :: a, b
  real, parameter :: pi=3.1415
  b=pi*a**2
end subroutine
