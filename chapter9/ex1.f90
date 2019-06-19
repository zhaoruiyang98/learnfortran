program main
  implicit none
  character(len=79) :: filename
  character(len=79) :: buffer
  character :: temp
  integer, parameter :: fileid=10
  integer :: status=0
  integer :: counter=0
  logical alive

  write(*,*) "Filename:"
  read(*,"(A79)") filename
  inquire(file=trim(filename), exist=alive)

  if(alive) then
    open(unit=fileid, file=filename, &
      access="sequential", status="old")
    do while(.true.)
      read(unit=fileid, fmt="(A79)", iostat=status) buffer
      if(status/=0) exit
      counter=counter+1
      if (counter==22) then
        write(*,*) "please enter anything to continue:"
        read(*,*) temp
        counter=0
      end if
      write(*,"(A79)") buffer
    end do
  else
    write(*,*) trim(filename), "doesn't exist."
  end if

  stop
end program
