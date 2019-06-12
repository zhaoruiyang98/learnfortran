program main
  implicit none
  real, parameter :: weight=45.0
  real, parameter :: e=0.001
  real :: guess=0.0
  integer :: counter
  integer :: flag=0

  do counter=1, 5, 1
    write(*,*) "Weight:"
    read(*,*) guess
    if (abs(guess-weight)<=e) then
      flag=1
      exit
    end if
  end do

  if (flag==1) then
    write(*,*) "You're right"
  else
    write(*,*) "Sorry you're wrong"
  end if
end program
