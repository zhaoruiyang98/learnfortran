program main
  integer a
100  write(*,*) "Please enter the day of the week you want to look up"
  read(*,*) a
  select case(a)
  case(1,4)
    write(*,*) "news"
  case(2,5)
    write(*,*) "TV series"
  case(3,6)
    write(*,*) "cartoon"
  case(7)
    write(*,*) "movie"
  case default
    write(*,*) "input error: please input 1~7"
    goto 100
  end select
end program
