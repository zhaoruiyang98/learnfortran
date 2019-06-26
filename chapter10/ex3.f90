module typedef
  type student
    integer :: num
    integer :: Chinese, English, Math, Science, Social
  end type
end module

program main
  use typedef
  implicit none
  character(len=20) :: filename
  character(len=80) :: tempstr
  integer i, error, line, temp
  type(student), allocatable :: a(:)

  write(*,*) "filename:"
  read(*,*) filename
  open(10, file=filename, status="old", iostat=error)
  if(error/=0) then
    write(*,*) "Open file fail!"
    stop
  end if
  
  read(10,"(A80)") tempstr
  line=0
  do while(.true.)
    read(10,"(A80)",iostat=error) tempstr
    if(error/=0) exit
    line=line+1
  end do
  write(*,*) "We have",line,"students"

  allocate(a(1:line),stat=error)
  if(error/=0) then
    write(*,*) "Out of memory!"
    stop
  end if

  rewind(10)
  read(10,"(A80)") tempstr
  do i=1, line
    read(10,*) a(i)
  end do
  close(10)

  write(*,*) "Which number?"
  read(*,*) temp
  if(temp<1 .or. temp>line) stop
  do i=1, line
    if(a(i)%num==temp) then
      write(*,"(5(A10,I3))") "Chinese", a(i)%Chinese, &
                               "English", a(i)%English, &
                               "Math", a(i)%Math, &
                               "Science", a(i)%Science, &
                               "Social", a(i)%Social
      stop
    else
      exit
    end if
  end do
  write(*,"('number',I3,' does not exist')") temp

  stop
end program
