program main
  real(kind=8) :: a=0.0
  integer :: counter, mul
  mul=1
  do counter=1, 10, 1
    mul=mul*counter
    a=a+1.0/mul
  end do
  write(*,*) "The result is:", a
end program
