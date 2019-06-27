module time_util
  implicit none
  type :: time
    integer :: hour, minute, second
  end type
  interface operator(+)
    module procedure add
  end interface

contains
  function add(a,b)
    implicit none
    type(time), intent(in) :: a, b
    type(time) :: add
    add%second=mod(a%second+b%second,60)
    add%minute=mod(a%minute+b%minute+(a%second+b%second)/60,60)
    add%hour=(a%minute+b%minute+(a%second+b%second)/60)/60+a%hour+b%hour
    return
  end function

  subroutine output(t)
    type(time), intent(in) :: t
    write(*,"(I2,':',I2.2,':',I2.2)") t%hour, t%minute, t%second
    return
  end subroutine

end module

program main
  use time_util
  implicit none
  type(time) :: a, b, c

  a=time(1,45,36)
  b=time(2,18,45)
  c=a+b
  call output(c)

  stop
end program
