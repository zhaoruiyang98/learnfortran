program main
  implicit none
  type :: distance
    real :: m
    real :: cm
    real :: inch
  end type distance
  type(distance) :: a
  write(*,*) "Please enter distance(m):"
  read(*,*) a%m
  a%cm = a%m*100.0
  a%inch = a%cm*0.3937
  write(*,*) "distance(m):", a%m
  write(*,*) "distance(cm):", a%cm
  write(*,*) "distance(inch):", a%inch
end program
