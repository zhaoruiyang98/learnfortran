program main
  implicit none
  integer :: n=100
  integer, external :: add
  write(*,*) add(100)
end program

recursive integer function add(n) result(ans)
  implicit none
  integer :: n
  if (n==1) then
    ans=1
  else
    ans=n+add(n-1)
  end if
  return
end function
