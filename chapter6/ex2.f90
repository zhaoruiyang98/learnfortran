program main
  integer counter, a
  a=0
  do counter=1, 99, 2
    a=a+counter
  end do
  write(*,"('Result:',I5)") a
end program
