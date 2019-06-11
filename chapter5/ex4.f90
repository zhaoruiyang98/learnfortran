program main
  implicit none
  integer :: year
  integer :: flag=0
  write(*,*) "year:"
  read(*,*) year
  if (mod(year,400)==0) then
    flag=1
  else if (mod(year,100)==0) then
    flag=0
  else if (mod(year,4)==0) then
    flag=1
  end if

  if (flag==1) then
    write(*,*) "366 days in",year
  else
    write(*,*) "365 days in",year
  end if
end program
