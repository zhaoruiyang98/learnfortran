program main
implicit none
  integer :: i
  integer :: fib(0:10)
  data(fib(i), i=0, 1) / 0,1 /
  do i=2, 10
    fib(i)=fib(i-1)+fib(i-2)
  end do
  ! if I use forall, there will be a problem
  ! forall (i=2:10)
  !   fib(i)=fib(i-1)+fib(i-2)
  ! end forall
  ! if anyone knows why, please tell me.
  write(*,"('results:',11I4)") (fib(i),i=0,10)
end program
