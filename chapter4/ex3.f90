program main
  real(kind=4) :: grade
  write(*,*) "Please enter the grade:"
  read(*,*) grade
  write(*,"('result:',F10.3)") sqrt(grade)*10.0
end program
