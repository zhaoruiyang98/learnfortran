program main
  implicit none
  type :: person
    integer :: age
    real :: income
  end type
  type(person) :: a
  real :: tax

  write(*,*) "Please enter your age:"
  read(*,*) a%age
  write(*,*) "Please enter your income"
  read(*,*) a%income

  if (a%age<50) then
    if (a%income<1000) then
      tax=a%income*0.03
    else if (a%income>=1000 .and. a%income<=5000) then
      tax=a%income*0.1
    else
      tax=a%income*0.15
    end if
  else
    if (a%income<1000) then
      tax=a%income*0.05
    else if (a%income>=1000 .and. a%income<=5000) then
      tax=a%income*0.07
    else
      tax=a%income*0.1
    end if
  end if
  write(*,*) "tax:",tax 
end program
