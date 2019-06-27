module overload
  implicit none
  real, parameter :: pi=3.1415
  interface area
    module procedure area_circle
    module procedure area_rectangle
  end interface

  contains
    real function area_circle(r)
      real :: r
      area_circle=pi*r**2
      return
    end function

    real function area_rectangle(a,b)
      real :: a, b
      area_rectangle=a*b
      return
    end function
end module

program test
  use overload
  implicit none
  real :: r, a, b
  write(*,*) "Please enter one parameter to &
    compute circle's area:"
  read(*,*) r
  write(*,"('Area:',F9.3)") area(r)
  write(*,*) "Please enter two parameter to &
    compute rectangle's area:"
  read(*,*) a,b
  write(*,"('Area:',F9.3)") area(a,b)
  stop
end program
