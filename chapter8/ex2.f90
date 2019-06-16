program main
  implicit none
  real :: a
  real, external :: sub
  write(*,*) "Please enter the radius:"
  read(*,*) a
  write(*,*) "Area:", sub(a)
end program

real function sub(a)
  implicit none
  real :: a
  real, parameter :: pi=3.1415
  sub=pi*a**2
end function
