# 文件IO和编译器高级使用
## 文件操作
保存文件有两种方式，一种是按照文本格式进行保存，一种是按照二进制保存。后者读取速度比较快，因为保存格式和在内存中的保存方法相同。譬如12345用文本格式保存会依次保存各位的数字。
### 基本命令和关键字
#### OPEN
最基本的open命令`open(unit=number, file='filename')`，其实支持不少参数。
- unit=*number*，number是一个正整数，需要避免1,5,2,6这几个数字，因为它们是默认的IO位置
- file=*'filename'*，指定打开的文件名称，windows下文件名不区分大小写，unix中会区分大小写
- form=  ， 指定保存方式，默认以文本格式保存
    - *'formatted'* 以文本格式保存
    - *'unformatted'* 以二进制文件格式保存
- status= ，说明要打开的是一个新文件还是已经存在的旧文件，默认'unknowed'
    - *'new'* 表示文件原本不存在，是第一次打开
    - *'old'* 表示文件原本就存在
    - *'replace'* 文件若已经存在，会重新创建一次并清空原本内容；若不存在，会创建新文件
    - *'scratch'* 表示打开一个暂存盘，这时可以不指定文件名称，因为程序本身会自动取一个文件名，程序结束后自动删除
    - *'unknowed'* 由编译器自定义，通常和'replace'效果相同
- access= ，设置读写文件的方式，默认顺序读写
    - *'sequential'* 读写文件以“顺序”方法读写
    - *'direct'* 读写文件的操作可以指定任意位置，“直接读取文件”
- recl=*length*
    - 直接读取时，用来设置文件中每一模块单元的分区长度
    - 顺序读取时，设置一次可以读写多大容量的数据
    - length单位在文本格式下是一个字符
    - 二进制格式下由编译器自行决定，在gfortran编译下单位应该指1byte
- err=*label* 如果打开文件时发生错误跳转到label所指的行代码处继续执行程序
- iostat=*var* 将文件打开的状态赋值给后面的整型变量
    - var>0 读取发生错误
    - var=0 读取操作正常
    - var<0 文件终了
- **iomsg=chart_var Fortran2003新特性，如果发生错误，字符变量chart_var包含错误信息，成功执行则不变**
- blanck=*'null'*或者*'zero'* 设置文件输入数字时，当所设置的格式字段中有空格存在时表示的意义，前者表示没有东西，后者表示空格部分会自动以0填入
- position= 设置文件打开时的读写位置，默认'asis'
    - *'asis' *不特别指定，通常在文件开头
    - *'rewind'* 表示文件打开时读取位置移动到文件的开头
    - *'append'* 表示文件打开时读取位置移动到文件的结尾
- action= 设置文件的读写权限，默认“读写”
    - *'readwrite'*
    - *'read'*
    - *'write'*
- pad= 默认yes
    - *'yes'* 格式化输入时，最前面的不足字段自动以空格填满
    - *'no'* 不自动以空格填满
- delim=
    - *'none'* 纯粹输出字符串内容
    - *'quote'* 输出字符串会在前后加上双引号
    - *'apostrophe'* 输出字符串会在前后加上单引号

open使用完文件后最好`close`
#### WRITE和READ的使用
- unit=*number* 指定read/write使用的输入/输出位置
- fmt=*format*
- nml=*namelist* 指定读写某个namelist的内容
- rec=*record* 直接读取文件时，设置所要读写的文件模块位置
- iostat=*stat*  设置一个整数值给后面的变量，说明文件的读写状态
    - stat>0 读取操作发生错误
    - stat=0 读取正常
    - stat<0 文件结束
    - 如果READ语句中不存在这个选项，任何超出文件结尾范围的读写都会使得程序的运行异常中断，所以设计时应该包含这个选项。
- **iomsg=chart_var Fortran2003新特性，如果返回的IO状态非0，字符变量chart_var包含错误信息**
- err=*label*  如果读写文件时发生错误跳转到label所指的行代码处继续执行程序
- end=*endlabel* 在读写到文件末尾时，会转移到某个行代码继续执行文件
- advance=*'yes'*或者*'no'* 设置每次read/write命令完成后，读写位置会不会自动向下移动一行。**注意使用该字段时一定要设置输出入的格式**
- size=*count*  **当advance='no'时才能使用这个字段**，它会把这一次输出入的字符数目设置给后面的整型变量
#### 查询文件的状态
在使用`open`命令打开文件的前后，都可以使用`inquire`命令查询文件目前的情况。
- unit=*number*  赋值所要查询的文件代号
- file=*filename*  赋值所要查询的文件名称
- iostat=*stat*  查询文件读取情况，会设置一个整数值给它后面的变量
    - stat>0 读取操作发生错误
    - stat=0 读取正常
    - stat<0 文件结束
- err=*errlabel*  查询发生错误时移动到赋值的行代码继续执行程序
- exist=*exist*  检查文件是否存在，返回一个布尔值给后面的逻辑变量，返回真表示文件存在，否则不存在
- opened=*opened* 检查文件是否已经使用`open`命令打开，如果打开返回真值到后面的逻辑变量，否则返回假
- number=*number* 由文件名查询这个文件所给定的代码
- named= *named* 查询文件是否是临时保存盘/取了名字，返回值为逻辑数
- access=*access* 检查文件的读取格式，返回一个字符串，值可以为'yes','no','unknowed'
- sequential=*sequential* 查看文件是否使用顺序格式，返回字符串，类似上条
- direct=*direct* 查看文件是否使用直接格式，返回一个字符串
- form=*form* 查看文件的保存方法，返回一个字符串：'formatted'/'unformatted'/'undefined'
- formatted=*fmt* 查看文件是否是文本文件，返回一个字符串
- unformatted= *fmt* 查看文件是否为二进制文件，返回一个字符串
- recl=*length* 返回open文件时recl栏的设置值
- nextrec= *nr* 返回下一次文件读写的位置
- blank= *blank* 返回字符串，查看`open`文件时的`blank`参数给定的字符串值
- position= *position* 返回打开文件时position字段给定的字符串
- action= *action* 返回打开文件时action字段赋值的字符串
- read=*read* 返回一个字符串检查文件是否只读
- write= *write* 返回一个字符串检查文件是否可以写入
- readwrite= *readwrite* 返回一个字符串检查文件是否可以读写
- delim= *delim* 返回打开文件时，delim字段设置的字符串
- pad= *pad* 返回打开文件时pad字段设置的字符串
#### 常用的文件运行命令
`rewind(unit=number, err=errlabel, iostat=iostat)`命令可以将文件的读写位置强制移回文件最前面  
`backspace(unit=number, err=errlabel, iostat=iostat)` 把文件的读写位置退回一步  
`endfile(unit=number, err=errlabel, iostat=iostat)` 使用这个命令会把目前文件的读写位置变为文件的末尾  
`close(unit=number, status=string, err=errlabel, iostat=iostat)`把文件关闭不再进行读写。`status='keep'`会在文件关闭后保留这个文件，这是默认设置，`status='delete'`会在关闭后消除这个文件
### 不同类型文件
#### 顺序文件操作
顺序读取意思是，读写是按照顺序的，每次读写后再读写是从上次结束的地方开始。

一般通过循环实现逐行读取，通过字段`iostat`判断是否到文件末尾。
#### 直接访问文件
直接访问的意思是：“把文件的空间、内容事先分区成好几个同样大小的小模块，这些模块会自动按顺序编号。读写文件时，要先赋值文件读写位置在第几个模块，再来进行读写的工作”。直接访问文件可以任意到文件的任何一个地方来读写。

示例的打开文件和读的操作：`open(unit=fileid, file=filename, access="direct", form="formatted", recl=6)`，`read(fileid, fmt="(f4.2)", rec=player, iostat=error) x`，`recl=6`设置了每个模块为6个字符大小，`rec=player`设置了在第`player`个模块读写。

特别是，在windows下，文本文件的行尾有2个字符(这个存疑，最后一行行尾可能只有一个字符)；在unix下每行行尾只需要一个结束符号。

直接访问文件的操作有时候用数组更快，但是数组会加载到内存中。

使用直接访问文件时，要小心使用`endfile`命令，使用这个命令时，会把目前所在的文件位置之后的数据都清除掉。

直接访问的时候使用`write`命令似乎不会加上换行？
#### 二进制文件
当使用二进制文件读写时，一般是直接读写，因为顺序读写时每条数据前后会被编译器补上一些额外的信息。
#### 内部文件
内部文件(internal file)更恰当的名字应该叫“字符串变量文件”，就是说在读写时，`unit`可以为一个字符串变量。

使用`read`命令从键盘读数据时，如果用户输入错误的数据，会导致程序死机，比较好的处理方法是，把数据当作字符串输入，检查字符串中是否含有不合理的字符，如果有，就请用户再输入一次。

internal file还可以实现动态确定数字长度输出，具体操作方法是把输出格式实现放在字符串中，运行时动态改变。
## NAMELIST
namelist可以把一组相关的变量封装在一起，输入/出这组变量时，只要在`write/read`中的`nml`字段赋值要使用哪一个namelist就行了，使用上类似于`common`的用法，但是namelist必须要取名字。

`namelist /na/ a,b,c`  名称为`na`的namelist

fortran90规定，输出namelist时不能赋值输出格式，输出的样式大致如下：
```fortran
&NA !符号&后接namelist的名字
A = 1, （输出变量名、等号、内容）
B = 2,
C = 3
/ !最后用除号来结束
```

同样，也可以输入数据到namelist中。注意，输入的格式必须和上面的格式一致，例如`&na a=1 b=2 c=3 /`。输入时，可以不填入所有变量的值，输入变量也可以不按照顺序。

<mark>c和fortran之间的调用待施工……</mark>