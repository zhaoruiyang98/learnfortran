module typedef
  implicit none
  type :: vector
    real x,y
  end type
  private add,minus,leftmul,rightmul,dot
  public show
  interface operator(+)
    module procedure add
  end interface
  interface operator(-)
    module procedure minus
  end interface
  interface operator(*)
    module procedure leftmul
    module procedure rightmul
  end interface
  interface operator(.dot.)
    module procedure dot
  end interface

contains
  function add(a,b)
    type(vector), intent(in) :: a,b
    type(vector) :: add
    add%x=a%x+b%x
    add%y=a%y+b%y
    return
  end function

  function minus(a,b)
    type(vector), intent(in) :: a,b
    type(vector) :: minus
    minus%x=a%x-b%x
    minus%y=a%y-b%y
    return
  end function

  function leftmul(a,b)
    real, intent(in) :: a
    type(vector),intent(in) :: b
    type(vector) :: leftmul
    leftmul%x=(b%x)*a
    leftmul%y=(b%y)*a
    return
  end function

  function rightmul(a,b)
    real,intent(in) :: b
    type(vector),intent(in) :: a
    type(vector) :: rightmul
    rightmul%x=(a%x)*b
    rightmul%y=(a%y)*b
    return
  end function

  function dot(a,b)
    type(vector), intent(in) :: a,b
    real :: dot
    dot=a%x*b%x+a%y*b%y
    return
  end function

  subroutine show(a)
    type(vector), intent(in) :: a
    write(*,"('(',F9.3,',',F9.3,')')") a%x, a%y
    return
  end subroutine

end module

program main
  use typedef
  implicit none
  type(vector) :: a,b,c
  a=vector(4.2,2.5)
  b=vector(3.7,3.3)
  call show(a+b)
  call show(a-b)
  call show(3.6*a)
  call show(b*3.7)
  write(*,"(F9.3)") a.dot.b
  stop 
end program
