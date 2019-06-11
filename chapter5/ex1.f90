program main
  real :: income, tax
  write(*,*) "Please enter your income:"
  read(*,*) income
  if (income <= 1000) then
    tax = income*0.03
  else if (income>1000 .and. income<=5000) then
    tax = income*0.1
  else
    tax = income*0.15
  end if
  write(*,*) "Tax:", tax
end program
