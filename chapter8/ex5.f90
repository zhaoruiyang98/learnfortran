program main
  implicit none
  integer :: a, b
  integer, external :: gcd
  write(*,*) "please enter two integer:"
  read(*,*) a, b
  write(*,*) "The greatest common divisor is:", gcd(a,b)
  stop
end program

recursive integer function gcd(a,b) result(ans)
  integer :: a, b
  integer :: c, d
  c=max(abs(a),abs(b))
  d=min(abs(a),abs(b))
  if (mod(c,d)==0) then
    ans=d
    return
  else
    ans=gcd(d,mod(c,d))
   return
  end if
end function
