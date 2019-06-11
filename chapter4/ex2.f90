program main
  implicit none
  real(kind=4), parameter :: pi=3.1415
  real(kind=4) :: r
  write(*,*) "Please enter the circle's radius:"
  read(*,*) r
  write(*,"('Area:',F10.3)") pi*r**2
  stop 
end program
