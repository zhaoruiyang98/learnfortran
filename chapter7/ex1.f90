program main
  integer :: i
  real :: b=0
  integer :: a(10)=(/ (2*i,i=1,10) /)
  write(*,*) "The array is: "
  write(*,"(10I4)") (a(i),i=1,10)
  do i=1, 10
    b=b+a(i)
  end do
  b=b/10.0
  write(*,"('The average is:', F7.3)") b
end program
