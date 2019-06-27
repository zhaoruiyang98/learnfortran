# module和面向对象
## module的基本使用
module用来封装程序模块，写在文件的最前面。
### 包含变量
```fortran
module module_name
    implicit none
    integer a,b
    common a,b ! 等价但是不好的写法：integer, save :: a,b
end module
```
在使用时，只要在函数中包含`use module_name`，这些变量对函数就是可见的，而不需要在多个程序中反复声明。

封装的变量如果不声明为全局变量，这些变量被使用时，只会是函数中的局部变量，这就失去了设计的意义。
### 包含type类型
在module里包含自定义类型的好处是显而易见的，可以减少参数的传递，把所有数值封装在类型中，需要使用这种结构时`use`一下即可（注意要放在`implicit none`前面）。

包含方法就是寻常的`type`定义的方法。
#### 包含函数
```fortran
module module_name
    ... ! 声明的相关程序代码
contains
    subroutine sub_name
        ...        ! moudle中的子程序可以使用module中声明的变量
        ...
    end subroutine ! 和有些情况不同，subroutine不能省略

    function sub_name
        ...
        ...
    end function
end module
```

如果函数被封装在module中就等于写好了使用接口。
## 使用多文件
`include 'file.f90'`作用相当于单纯地插入"file.f90"文件的内容，可以使用在程序的任意地方。
## module的高级使用
在module的contains之前可以定义变量和函数是否为共有或者私有，只要使用`private`或者`public`接上变量/函数名即可。未定义的默认是共有的。

module中也可以use其他module，并且有一些方便的特性：

```fortran
use A, aa=>va ! 把module A中变量/函数va改名为aa来使用防止冲突
use A, only :: c=>vc ! 只使用module A 中的变量/函数vc，并且把vc改名为c来使用
```

在module A中use model B，相当于A继承了module B中所有公开的数据和函数。

note: 感觉fortran95提供的面向对象特性还是很不完善，看上去有点c with class的感觉。也似乎并没有对象，这就导致了只是模块化的去调用。
## interface
### 同名函数的重载(overload)
在module里使用interface，可以用来定义一个虚拟的函数名称，调用这个虚拟函数时程序会根据输入的参数来决定要调用interface中的哪个函数。范例如下：

```fortran
interface show
    module procedure show_int
    module procedure show_character
end interface
```
### 自定义操作符
fortran中的自定义类型不能像基本类型一样做加减乘除等各种运算，但是可以通过interface来实现。

```fortran
interface operator(+) ! 在程序代码中使用a+b时，根据a和b的参数类型调用下面的函数来执行
    module procedure add1 ! add1和add2编写的时候必须明确每一个参数的属性intent
    module procedure add2
end interface
```

同样的，可以类似上面定义非基本类型的逻辑判断关系（注意返回值）。而定义赋值关系时，候选函数都必须是子程序，不过一般情况下没有必要自定义，因为默认的等号会把等号右侧变量内容完全复制一份给等号左边的变量，但是当等号两边类型不一致时，这种定义是很有用的。当然也可以定义本来不存在的操作符`.new_operator.`

指定操作符共有/私有时命令类似为`public operator(.new_operator.)`