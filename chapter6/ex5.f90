program main
  character(len=50) :: string, string2
  integer :: counter
  integer :: i=0
  write(*,*) "please enter a string with blank space(<=50 characters):"
  read(*,"(a50)") string  ! if you set fmt=*, it will not read all you input
  do counter=1, len_trim(string), 1
    if (ichar(string(counter:counter))==32) then
      cycle
    else
      i=i+1
      string2(i:i)=string(counter:counter)
    end if
  end do
  write(*,*) string2(1:i)
  ! cannot use string2(1:len_trim(string2)) here because
  ! string2 is not initialized as 50 blank spaces
end program
