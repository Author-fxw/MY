# **<u>【c++静态成员变量和静态成员函数】</u>**：

1. 类的静态成员有两种：静态成员变量和静态成员函数。静态成员变量本质上是全局变量，静态成员函数本质也是全局函数，

2. 静态成员变量和静态成员函数都可以使用类名去调用。

   非静态成员的访问方式（对象名.成员名），需要指明被访问的成员变量是属于哪个对象的，或者是调用的成员函数作用于哪个对象的。静态成员的访问方式（类名::成员），不需要指明被访问的成员是属于哪个对象的或是作用于哪个对象的。

   两者的相同点：两者在定义的前面都有static关键字。

   ## **静态成员函数总结：**

   - 静态成员函数**<u>只能</u>**直接访问静态成员变量（函数），不能直接访问普通成员函数。

   - 静态成员函数是类中的特殊成员函数，

   - 静态成员函数**<u>没有隐藏的this指针</u>**：当调用一个对象的非静态成员函数时，系统会将该对象的起始地址赋给成员函数的this指针，静态函数不属于某一个对象所有，是该类的所有对象共享，所以静态成员函数没有隐藏的this指针。

     ## 静态成员变量总结：

     - 特性：使用static修饰，在类外部初始化，使其分配空间。举个例子：![1570861223341](C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\1570861223341.png)
     - 如果static成员变量使用const修饰，则可以直接在类内部初始化赋值。举个例子：![1570861343930](C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\1570861343930.png)

     ## C++之const类成员函数，成员变量。又称常成员函数和常成员变量。

     - 什么时候使用const常成员变量呢？在类中，如果你希望某些数据被改变，就可以加关键字const来加以限定。const可以修饰成员变量和成员函数。

     - const成员函数（常成员函数）：const成员函数可以使用类的所有成员变量，但是不能修改它们的值，仅仅只能获取值，这种措施主要是为了保护数据而设定的。

     - 需要强调的是**<u>const函数声明和定义需要同时在函数头部结尾处加上const关键字</u>**。举个例子：

       ```c++
       class Student{
       public:
           Student(char *name, int age, float score);
           void show();
           //声明常成员函数
           char *getname() const;
           int getage() const;
           float getscore() const;
       private:
           char *m_name;
           int m_age;
           float m_score;
       };
       
       Student::Student(char *name, int age, float score): m_name(name), m_age(age), m_score(score){ }
       void Student::show(){
           cout<<m_name<<"的年龄是"<<m_age<<"，成绩是"<<m_score<<endl;
       }
       //定义常成员函数
       char * Student::getname() const{
           return m_name;
       }
       int Student::getage() const{
           return m_age;
       }
       float Student::getscore() const{
           return m_score;
       }
       
       
       ```

       其中的getname（）、getage（）、getscore（）三个函数的功能都很简单，仅仅只是获取成员变量的值，所以我们加了const限制。

     **<u>最后来区分一下const的位置问题：</u>**

     -  函数开头的 const 用来修饰函数的返回值，表示返回值是 const 类型，也就是不能被修改，例如`const char * getname()`。
     -  函数头部的结尾加上 const 表示常成员函数，这种函数只能读取成员变量的值，而不能修改成员变量的值，例如`char * getname() const`。

   /////***********************************************************************************************************************************************************************//////
   
   # 一：C++虚函数基础

**<u>纯虚函数:</u>**

含有纯虚函数的类叫抽象类，抽象类是绝对不能是生成对象的

但是。重点来了，，，

可以定义指向抽象类的指针或引用，此指针可以指向他的派生类，进而实现多态。

继承抽象类的派生类必须全部实现抽象类中的**纯虚方法**(可以不实现其他成员函数但是纯虚函数一定要派生类实现)，否则，派生类也变成了抽象类。 

纯虚函数也可以有函数体但必须是在类的外部，例如：

![1570686702088](C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\1570686702088.png)



有函数体的纯虚函数仍然不能生成对象，但可以为派生类提供一个默认实现。

**<u>什么时候需要选用纯虚函数呢？</u>**

- 基类不需要实例化

- 子类基本都需要override重写父类的虚函数时

- 抽象类的析构函数必须是纯虚函数（在这里有个比较会被继承类的析构函数一定是虚析构，否则 会造成内存泄漏。因为在析构时先析构派生类再析构被继承的类）

  

# **二、【C++中的多态】**

**<u>c++支持两种多态性</u>**

**讲讲多态：**c++支持两种多态性，编译时多态性（也叫静态多态），运行时多态性（也加动态多态）。编译时多态性：通过重载函数和运算符重载实现。运行时多态性：通过虚函数和继承实现。

**C++实现多态的方式：**

c++中实现多态的方式共有三种：1.函数重载（函数重载有参数重载、运算符重载），2.模板函数  3.虚函数

下面是虚函数与多态之间的猫腻：hhhhh 想深入了解的童鞋，戳戳下面的链接：https://blog.csdn.net/weixin_43072157/article/details/82223492

# **三、【C++中的引用&指针】

- **<u>先介绍一下引用：</u>**C++引用：引用实质可以看做是数据的一个别名。
  引用的定义方式类似于指针，使用&取代了*，语法格式 type &name=data；引用在定义同时必须初始化。

- **<u>引用&指针两者的区别：</u>**指针和引用的定义和性质区别：（1）指针：指针是一个变量，只不过这个变量存储的是一个地址，指向内存的一个存储单元；而引用跟原来

  的变量实质上是同一个东西，只不过是原变量的一个别名而已。如：

  int a=1;int *p=&a;

  int a=1;int &b=a;

  上面定义了一个整形变量和一个指针变量p，该指针变量指向a的存储单元，即p的值是a存储单元的地址。

  而下面2句定义了一个整形变量a和这个整形a的引用b，事实上a和b是同一个东西，在内存占有同一个存储单

  元。

  (2)引用不可以为空，当被创建的时候，必须初始化，而指针可以是空值，可以在任何时候被初始化。

  (3)可以有const指针，但是没有const引用；

  (4)指针可以有多级，但是引用只能是一级（int **p；合法 而 int &&a是不合法的）

  (5)指针的值可以为空，但是引用的值不能为NULL，并且引用在定义的时候必须初始化；

  (6)指针的值在初始化后可以改变，即指向其它的存储单元，而引用在进行初始化后就不会再改变了。

  (7)”sizeof引用”得到的是所指向的变量(对象)的大小，而”sizeof指针”得到的是指针本身的大小；

  (8)指针和引用的自增(++)运算意义不一样；

  (9)如果返回动态内存分配的对象或者内存，必须使用指针，引用可能引起内存泄漏；

  [C++中指针（或引用）类型间转换](https://blog.csdn.net/qq_41915323/article/details/94411818)

  连接地址：https://blog.csdn.net/qq_41915323/article/details/94411818
  
  
  
  # 四、C/C++ STL常用容器用法总结
  
  1. ## 容器：
  
  c++中的vector容器是一个能够动态增长的动态数组，能够增加和压缩数据。
  
  vector的基本操作：
  
  ```c++
  1 、基本操作
  
  (1)头文件#include<vector>.
  
  (2)创建vector对象，vector<int> vec;
  
  (3)尾部插入数字：vec.push_back(a);
  
  (4)使用下标访问元素，cout<<vec[0]<<endl;记住下标是从0开始的。
  
  (5)使用迭代器访问元素.
  
  vector<int>::iterator it;
  
  for(it=vec.begin();it!=vec.end();it++)
  
      cout<<*it<<endl;
  
  (6)插入元素：    vec.insert(vec.begin()+i,a);在第i+1个元素前面插入a;
  
  (7)删除元素：    vec.erase(vec.begin()+2);删除第3个元素
  
  vec.erase(vec.begin()+i,vec.end()+j);删除区间[i,j-1];区间从0开始
  vec.erase(remove(vec.begin(),vec.end(),i);///删除指定位置第i个元素
  
  (8)向量大小:vec.size();
  
  (9)清空:vec.clear();
  
  ```
  
  [详细学习链接](https://blog.csdn.net/weixin_41162823/article/details/79759081)
  
  **C++中结构体使用**：结构体可以包含不同数据类型的结构、也可以使用类来代替结构体，在类中使用结构体实际像是内部类的问题，把结构体看作是一个没有成员函数的类。
  
  结构体和数组的区别：主要有两点不同第一：结构体合一包含不同的数据类型，数组不可以 ，数组是单一数据类型的数据集合。第二：相同类型的和结构体变量是可以赋值的，结构体本身就是一种**数据类型**，数组名称是**常量指针。**
  
  

====================OpenGL学习篇============================

【OpenGL学习篇】

OpenGL的着色器中的纹理单元的主要目的是 可以让我们使用多余一个的纹理。

OpenGL实现图像处理主要使用到了GLSL着色语言，具体到着色器就是片段着色器。OpenGL做通用计算的步骤主要如下：

读取数据->顶点着色器->片段着色器->渲染到纹理->从纹理读取数据。在OpenGL中，任何事物都是在3D空间中，而屏幕和窗口确实2D像素数组，这就导致OpenGL大部分工作都是在把3D坐标转变为适应屏幕的2D像素，这个转换过程就是OpenGL的图形渲染管线。

================cocos2dx--屏幕适配篇===========================

# 【cocos2dx3.2 ——屏幕适配】

2014-09-26 21:17:15 更多

版权声明：本文为博主原创文章，遵循[ CC 4.0 BY-SA ](http://creativecommons.org/licenses/by-sa/4.0/)版权协议，转载请附上原文出处链接和本声明。本文链接：https://blog.csdn.net/chinahaerbin/article/details/39586281

**cocos2dx3.2 ——屏幕适配**

本文出自 “[夏天的风](http://shahdza.blog.51cto.com/)” 博客，请务必保留此出处 http://shahdza.blog.51cto.com/2410787/1550089 



手机的屏幕大小千差万别，如现在流行的安卓手机屏幕大部分长宽比例为16:9。而iPhone 5S的长宽比例为71:40（接近16:9），也有预测说iPhone 6S的长宽比例也将会是主流的16:9。另外还有一些平板电脑为4:3、16:10、5:4等等。当然还有一些其他的牌子可能屏幕比例也不一样。

  要想让你的程序在各种手机上都能很好的呈现游戏画面，就需要进行屏幕适配。

【致谢】

  http://gl.paea.cn/contents/10adab2de4f4bf1c.html

【小知识】

  分辨率：是指屏幕图像的精密度，即显示器所能显示的像素有多少。

​      如：分辨率480×320的意思是水平方向含有像素数为480个，垂直方向像素数320个。

​      屏幕尺寸一样的情况下，分辨率越高，显示效果就越精细和细腻。

​      同时分辨率也反映了屏幕长宽比例（如15：10）。





【屏幕适配】



1、两个分辨率

  1.1、窗口分辨率

  在AppDelegate.cpp中有个设置窗口分辨率的函数。该函数是设置了我们预想设备的屏幕大小，也就是应用程序窗口的大小。

```cpp
//    glView->setFrameSize(480, 320);//
```



1.2、设计分辨率（可视区域）

  在AppDelegate.cpp中也有个设置设计分辨率的函数。该函数是设置了我们游戏设计时候的分辨率，也就是可视区域的大小，也就是说设计者初衷的游戏可视区域的分辨率屏幕大小。

  但是对于每个用户来说，他们使用的设备不一定是（480/320）的，比如手机有大有小。

  而后面的ResolutionPolicy::SHOW_ALL，意思是按照原比例（480/320）进行放缩以适配实际屏幕大小。

```cpp
//    glview->setDesignResolutionSize(480, 320, ResolutionPolicy::SHOW_ALL);//
```



以下贴了三张对比图，加深理解。

  （1）这是原图片大小，窗口大小为480 * 320。

![wKiom1QGyKzzrEiyAAEGcXbYaxQ985.jpg](http://s3.51cto.com/wyfs02/M00/48/4C/wKiom1QGyKzzrEiyAAEGcXbYaxQ985.jpg)



  （2）若设置窗口大小为setFrameSize(960, 640)，而不设置设计分辨率ResolutionPolicy::SHOW_ALL 的情况下，图片不放缩，原图还是480 * 320。

![wKioL1QGyLDDGT0EAAF1kC25cqU991.jpg](http://s3.51cto.com/wyfs02/M01/48/4E/wKioL1QGyLDDGT0EAAF1kC25cqU991.jpg)

  

  （3）设置了 ResolutionPolicy::SHOW_ALL 之后，图片放缩到适配整个屏幕960 * 640 了。

![wKiom1QGyK2hDNN0AAL4YpbsOus524.jpg](http://s3.51cto.com/wyfs02/M01/48/4C/wKiom1QGyK2hDNN0AAL4YpbsOus524.jpg)







2、五种适配模式

  从上面的讲解我们可以了解到，setFrameSize()是设置了窗口大小（即屏幕的实际大小），而这个参数只是为了我们开发时作为模拟参照，在实际手机上运行时，手机的屏幕大小是我们无法设置的。

  而屏幕适配的关键在于setDesignResolutionSize()，通过它来设置可视区域的分辨率以及屏幕适配模式。该函数的前两个参数为分辨率（即屏幕长宽比例），而最后一个参数则是适配的模式。



  2.1、适配模式

  （1）ResolutionPolicy::EXACT_FIT   ：拉伸变形，使铺满屏幕。

  （2）ResolutionPolicy::NO_BORDER   ：按比例放缩，全屏展示不留黑边。

​                       （长宽中小的铺满屏幕，大的超出屏幕）

  （3）ResolutionPolicy::SHOW_ALL   ：按比例放缩，全部展示不裁剪。

​                       （长宽中大的铺满屏幕，小的留有黑边）

  （4）ResolutionPolicy::FIXED_WIDTH  ：按比例放缩，宽度铺满屏幕。

  （5）ResolutionPolicy::FIXED_HEIGHT ：按比例放缩，高度铺满屏幕。



  2.2、计算方法

  假设：屏幕分辨率（fWidth，fHeight） ； 设计分辨率（dWidth，dHeight）。

​     放缩因子：k1 = fWidth/dWidth ； k2 = fHeight/dHeight。

  则适配后的分辨率大小如下：

  （1）EXACT_FIT   ：（ dWidth * k1     , dHeight * k2     ）

  （2）NO_BORDER   ：（ dWidth * max(k1,k2) , dHeight * max(k1,k2) ）

  （3）SHOW_ALL   ：（ dWidth * min(k1,k2) , dHeight * min(k1,k2) ）

  （4）FIXED_WIDTH  ：（ dWidth * k1     , dHeight * k1     ）

  （5）FIXED_HEIGHT ：（ dWidth * k2     , dHeight * k2     ）



  2.3、有图有真相

​    屏幕大小：400 X 400 。

​    可视区域大小：480 X 320 。

​    根据上面的计算方法，自己慢慢琢磨吧。![i_f32.gif](http://img.baidu.com/hi/face/i_f32.gif)

![wKioL1QG8-7hZS8WAADziEkMLFg490.jpg](http://s3.51cto.com/wyfs02/M00/48/57/wKioL1QG8-7hZS8WAADziEkMLFg490.jpg)    ![wKiom1QG8-zxDYe8AAEkbDd4bjs111.jpg](http://s3.51cto.com/wyfs02/M00/48/55/wKiom1QG8-zxDYe8AAEkbDd4bjs111.jpg)



![wKioL1QG8-_DqPM-AAEZ_8A6D34121.jpg](http://s3.51cto.com/wyfs02/M01/48/57/wKioL1QG8-_DqPM-AAEZ_8A6D34121.jpg)    ![wKiom1QG8-zBwDRiAAD00smIMss790.jpg](http://s3.51cto.com/wyfs02/M01/48/55/wKiom1QG8-zBwDRiAAD00smIMss790.jpg)



![wKioL1QG8-_TuGsLAAD39oAYrEo645.jpg](http://s3.51cto.com/wyfs02/M00/48/57/wKioL1QG8-_TuGsLAAD39oAYrEo645.jpg)    ![wKioL1QG8--giZa-AAEgbplGZdw587.jpg](http://s3.51cto.com/wyfs02/M02/48/57/wKioL1QG8--giZa-AAEgbplGZdw587.jpg)

3、横竖换屏

  cocos2dx开发的游戏，在手机上运行的时候，默认是横屏的。

3.1、Android

  AndroidManifest.xml文件中

  （1）android:screenOrientation = "landscape"  //横屏显示（默认）

  （2）android:screenOrientation = "portrait"   //竖屏显示

![wKioL1QG91fAaz39AACtvtKDipE264.jpg](http://s3.51cto.com/wyfs02/M01/48/58/wKioL1QG91fAaz39AACtvtKDipE264.jpg)



  3.2、IOS



```cpp
//    - (NSUInteger) supportedInterfaceOrientations{        //横屏显示        //return UIInterfaceOrientationMaskLandscape;                 //竖屏显示        return UIInterfaceOrientationMaskPortrait;    }//
```



4、屏幕大小及坐标

  （1）WinSize     ：屏幕大小

  （2）VisibleSize   ：可视区域大小

  （3）VisibleOrigin  ：可视区域的左下角坐标

```cpp
//    Director::getInstance()->getWinSize()    Director::getInstance()->getVisibleSize();    Director::getInstance()->getVisibleOrigin();//
```

图解： ![wKiom1QG-yKzBaDwAACvTwPsE8c748.jpg](http://s3.51cto.com/wyfs02/M02/48/57/wKiom1QG-yKzBaDwAACvTwPsE8c748.jpg) 



一个人至少有一个梦想 ，一个理由去坚强。

================Cosos2dx-LUA学习篇============================

### **一、【lua异常处理函数；】**

LUA内置中提供了异常处理函数assert（a,b）a是要检查是否有错误的一个参数，b是a错误时抛出的信息。第二个参数b是可选的，根据自己的需要来修改。简单讲就是输出错误信息的函数，作用和debug类似。

assert首先判断第一个参数是否返回错误，如果不返回错误，则assert简单返回，否则则以第二个参数抛出异常信息。

### **二、【Cocos2dx+lua注册事件函数详解】**

resgisterScriptTouchHander 注册触屏事件

registerScriptTapHander 注册点击事件

registerScriptHander 注册基本事件、包括触屏、层的进入、退出事件

registerScriptKeypandHandler 注册键盘事件

regidterScriptAccelerateHander 注册加速事件

Cocos2dx+Lua节点渲染顺序在添加sprit精灵时使用的是默认的场景图层渲染 LocalZOrder ，GlobalZOrder是用于 渲染器 中用来给“绘制命令”排序的其渲染优先级要高于LocalZOrder。 GlobalZOrder值越小越先被渲染，但是显示在后被渲染的下面。

总结：节点的渲染顺序跟节点的三个成员变量有关（_localZOrder、_globalZOrder、_orderOfArrival）分别对应三个设置函数setLocalZOrder、setGlobalZOrder、setOrderOfArrival。无论是_localZOrder、_globalZOrder、_orderOfArrival都是越大的越后渲染，越小的越先渲染，而且有_globalZOrder的优先级大于_localZOrder的优先级大于_orderOfArrival的优先级。
Lua取table函数rawget(table，index)不受元表的影响，根据参数table、index获取真正的值table[index]，也就不会调用到元表，其中table必须是一个表，参数index可以是任意值。

### **三、【Lua中父类与子类之间的ctor初始化函数的联系：】**

self.super:ctor(...)-------参数是：self.super，即Base

self.super.ctor(self,...)----参数是：self、即子类

======================c#语言篇================================

### 四【c#中继承关系：】

c#中子类调用父类的虚方法两种方式：重写和覆盖（没有重写就叫覆盖），重写的话父类中的方法不被执行，实际执行子类中方法。覆盖执行父类中的方法，实际就是直接调用父类中方法，

3d麻将的游戏入口和程序生命周期事件派发，使用F1键查看日志文件，（日志文件使用链表来存储）。麻将的任务界面分别有tasklayer层和taskitem层构成，在taskitem完成对应ui控件的赋值，在tasklayer层进行实例化taskitem对象，实例化的taskitem对象的父节点为canvsngroup。

1.程序生命周期在游戏运行不销毁，可以作为游戏逻辑的入口。

2.定时器函数封装类：c#使用timer事件来实现定时器机制。一般有相隔一段时间重复调用某个函数，相隔一段时间有限次调用次数，还有延迟调用某个函数。

====================Unity3d-shader学习篇======================

五【**shader篇**】

shader的渲染流水线，应用阶段（主要由cpu负责实现。是开发者拥有控制权，这个一阶段的主要准备要渲染状态具体包括使用的材质（漫反射颜色、高光反射颜色），使用的纹理、使用的哪种顶点着色器等等）-几何阶段（这阶段主要由GPU负责实现。主要任务是把顶点坐标变换到屏幕空间中，再交给光栈化阶段处理）-光栈化阶段（这阶段也是由GPU负责实现。把上一阶段产生的数据来产生屏幕上的像素）。

【untiy shader--准确认识SubShader语义块结构、渲染状态设定、Tags标签】

一【SubShader】
	　　每个UnityShader文件可以包含多个SubShader语义块，但至少要有一个。当Unity需要加载这个UnityShader时，
Unity会扫描所有的SubShader语义块，然后选择一个能够在目标平台上运行的SubShader。如果都不支持的话，Unity
就会使用FallBack语义指定的UnityShader。
	　　Unity提供这种语义的原因在于，不同的显卡具有不同的能力。例如，一些旧的显卡仅能支持一定数目的操作指令，
而一些高级的显卡可以支持更多的指令数，那么我希望在旧的显卡上使用计算复杂度较低的着色器，而在高级的显卡上
执行计算复杂度高的着色器，以便提供更出色的画面效果。

SubShader
{
	　　//可选的
	　　[Tags]
	　　//可选的
	　　[RenderSetup]


	　　Pass
	　　{
	
	　　}
	　　//或更多Pass
}
	　　SubShader中定义了一系列的Pass以及可选的标签[Tags]、状态[RenderSetup]。每个Pass定义一次完整的渲染流程
但是如果Pass数目过多会造成渲染性能的下降。因此，我们尽量使用数量最小的Pass。
补充说明：[Tags][RenderSetup]也可以在Pass中声明。不同的是，SubShader中的一些标签设置是特定的。也就是说，
这些标签和Pass中设置的标签是不一样的。而对于状态设置来说，其使用的语法是相同。不过在SubShader进行的设置
将会用于所用的Pass。

二【渲染状态】
	　　ShaderLab提供了一系列渲染状态的设定，这些指令可以设置显卡的各种状态，例如是否开启混合/深度测试等。
状态名称	　　    设置指令 　　　　　　　　　　 　　　　　　　　　　 　　　　  			解释
Cull 　　　　Cull Back|Front|Off 　　　　 　　　　　　　　　　　　　　　　设置剔除模式，剔除背面|正面|关闭剔除  默认CullBack
ZTest	　　　ZTest Less Greater|LEqual|GEqual|Equal|NotEqual|Always 　　 设置深度时使用的函数　　　　　　　　默认ZTest LEqual 小于或等于目标深度才能被渲染
ZWrite	　　  ZWrite On|Off	　　　　　　　　　　　　　　　　　　　　　　　开启和关闭深度写入　　　　　　　　  默认ZWrite On
Blend	　　　Blend SrcFactor DstFactor	　　　　　　　　　　　　　　　　　 开启并设置混合模式　　    　　　　　　　

​	　　**当在SubShader块中设置了上述状态，将会被应用于所有的Pass。如果不想这样（例如在双面渲染中，我们可以希望第一**
**个Pass剔除正面来对背面进行渲染，在第二个Pass中选择剔除背面来对正面进行渲染），可以在Pass内部来单独设置状态。**

三【Tags标签】
	　　UnityShader的Tags是一个键值对（Key/Value Pair），他的键和值都是字符串类型。这些键值是对SubShader和渲染引擎
之前沟通的桥梁。他们用于告诉渲染引擎：怎么样和什么时候调用这个SubShader。
	标签语法如下：Tags{"TagName1" = "Value1" "TagName2" = "Value2"}

SubShader标签类型：注意这些标签只能在SubShader中声明，不能再Pass中
	　　标签类型	　　　　　　　　　　　　　　　　						说明	　　　　　　　　	　　　　　　　　							列　　　　子
Queue	　　　　　　　　     控制渲染顺序，指定该物体属于哪一个渲染队列	　　　　 Tags{"Queue" = "Transparent"}
RenderType	　　　　　　    对着色器分类。例如：这是一个不透明着色器	　　　　　 Tags{"RenderType" = "Opaque"}
DisableBatching	　　　　    一些SubShader在使用Unity批处理时会出现问题。
						　　　　　　　　　　　　    可以用该标签直接表明是否使用批处理	　　　　　　　　 Tags{"DisableBatching" = "True"}
ForecNoShadowCasting	　　  控制该SubShader的物体是否会投射阴影	　　　　　　   Tags{"ForceNoShadowCasting" = "True"}
IgnoreProjector	　　　　　　 设置该SubShader的物体是否受Projector影响　　　　　  Tags{"IgnoreProjector" = "True"}
						　　　　　　　　　　　　　　True常用与半透明物体。
CanUseSpriteAtlas	　　　　　 当该SubShader用于“sprite”时，将该标签设为False 　　 Tags{"CanUseSpriteAtlas" = "False"}
PriviewType	　　　　　　　　			材质面板的预览类型，一般默认材质预览效果是球形　　	Tags{"PreviewType" = "Plane"}
						　　　　　　　　　　　　　　还可以该为"Plane" "SkyBox"。

 

四【Pass语义块】
Pass
{
	　　[Name]				
	　　[Tags]				
	　　[RenderSetup]
	　　//other code
}
1、[Name]Pass名称
	　　Pass的名称，可以使用ShaderLab的UsePass命令来使用其他Shader的Pass代码
例如：UsePass"MyShader/MYPASSNAME",这样提高代码复用性，
注意：UnityShader内部会自动把PassName转换成大写格式。
2、[RenderSetup]Pass渲染状态设置
	　　SubShader的渲染状态也适用于Pass，而且Pass还可以适用固定管线着色器的命令
3、[Tags]Pass的标签
	　　Pass的标签不同于SubShader标签，这些标签用于告诉渲染引擎我们希望如何来渲染物体
	　　标签类型	　　　　　　		说明　　　　　　　　　　　　　　　　                				例子
	LightModel　　　　		定义该Pass在渲染管线中的角色	　　　　	Tags{"LightModel"="ForwardBase"}
	RequireOption 　　 用于指定满足某些条件是才渲染该　　　　Pass	Tags{"RequireOption" = "SoftVegetation"}

ColorMask　       可以让我们制定渲染结果的输出通道，而不是通常情况下的RGBA这4个通道全部写入。可选参数是 RGBA 的任意组合以及 0， 这将意味着不会写入到任何通道。

shader对于一些形状复杂的物体（或物体之间有缠绕遮挡）渲染时，使用两个pass，第一个开启深度写入，第二个关闭深度写入。

冯乐乐shader入门精要第七章：单张纹理，凹凸映射（法线纹理，高度纹理）

【CPU与GPU之间的通信】：

渲染流水线的起点是CPU，即应用阶段：（1）把数据加载到显存（2）设置渲染状态（3）调用DRAW CALL （draw call命令是由cpu发起的，接受方是GPU，GPU会根据渲染状态和所有顶点数据来进行渲染，最终把图元渲染到屏幕上）

======================Unity3d学习资源区=======================

untiy学习网址：游戏蛮牛 manew.com
unity圣典 http://www.ceeger.com/forum/
雨松MOMO http://www.xuanyusong.com/archives/category/unity
脱莫柔博客 https://blog.csdn.net/asd237241291?viewmode=contents
学无止境的专栏 https://blog.csdn.net/dingxiaowei2013
阿赵的日志 http://liweizhaolili.blog.163.com/blog/#m=0
博客 https://blog.csdn.net/ldghd/article/category/1145504
风宇冲 http://blog.sina.com.cn/lsy835375
四爷的专栏 https://blog.csdn.net/u012091672?viewmode=contents
年华2008 https://blog.csdn.net/nianhua2008
我的unity https://blog.csdn.net/mr_henry_love/article/details/80409028
siki学院 http://www.sikiedu.com/course/explore/unity?page=2

========================Unity中的数据处理======================

【unity中序列化与反序列化】（数据存储）:

序列化，反序列化：序列化就是把数据对象转成二进制流保存为本地文件的过程。反序列化就是把存储的数据信息的二进制文件还原成数据对象的过程。

android反编译apk（相关资料连接：记录U3D逆向Assembly-CSharp-firstpass.dll解密【 https://blog.csdn.net/qq_33369905/article/details/82081490 】android 加壳与破解--静态修改so，常用破解方法【 https://blog.csdn.net/q610098308/article/details/90674862 】在so文件中找到apk的加密算法）

untiy接第三方sdk（微信登录为例：参考资料连接:https://blog.csdn.net/qq_32169479/article/details/94014178）

=======================麻将demo的学习篇======================

【麻将demo】

界面的打开动画和关闭动画（缩放）在界面打开动画在对应层中的start方法中调用界面打开动画，在关闭动画时要添加一个tween动画执行完毕后的回调方法来销毁当前对象。

【正则表达式】：正则表达式是一个字符串（在代码中常简写为regex），常用来校验字符的合法性。

===================Socket、TCP/IP协议、UDP协议===============

- socket、TCP/IP协议、UDP协议
- http协议与tcp/ip协议的关系
- http协议的长连接与短连接
- tcp协议带来的粘包、分包问题的解决策略

【	Socket、TCP/IP协议、UDP协议（学习链接地址：https://www.cnblogs.com/xiaowenshu/p/9916755.html）。UDP&TCP协议相关学习链接地址：https://www.cnblogs.com/ywzbky/p/10731808.html】

1. TCP【传输控制协议】的作用（tcp属于运输层）：用来传输客户端与服务器数据报文，前提需要先建立tcp连接，tcp连接需要经过三次握手，断开连接时需要经过四次挥手。（这个连接会一直保持活动状态，知道超时、或客户端主动断开连接）TCP有长连接和短连接。短连接的优点，管理起来简单，存在的连接都是有用的连接。

- **【长连接：连接=》传输数据=》保持连接=》传输数据=》。。。。。。=》关闭连接】**

- **【短连接：连接=》传输数据=》关闭连接】**

2. IP协议属于网络层，   IP协议主要解决网络路由和寻址问题 。
3. Socket也称“套接字”用来描述IP地址，端口，它起源于unix，而unix/Linux基本哲学之一就是“一切皆文件对于文件的操作就是【打开】【读写】【关闭】 模式操作，socket就是该模式的一个实现，socket是一中特殊的文件。”Socket协议和http协议都属于应用层，socket套接字相当于是一组接口，socket连接建立之后不管是否使用都一直保持连接。
4. UDP【用户数据报协议】，面向无连接的，简单不可靠的传输层协议。 

 **1. HTTP协议与TCP/IP协议的关系** 

【HTTP协议介绍】

 　HTTP的长连接和短连接本质上是TCP长连接和短连接。HTTP【属于应用层协议】。HTTP也是超文本传输协议。在传输层使用TCP协议，在网络层使用IP协议。IP协议主要解决网络路由和寻址问题，TCP协议主要解决如何在IP层之上可靠的传递数据包，使在网络上的另一端收到发端发出的所有包，并且顺序与发出顺序一致。TCP有可靠，面向连接的特点。 

****【HTTP长连接和短连接的详细介绍连接】：https://www.cnblogs.com/0201zcr/p/4694945.html

【socket的长连接与短连接介绍连接】：https://www.cnblogs.com/ldy-blogs/p/9252388.html

![1575364693241](C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\1575364693241.png)

【TCP协议介绍】

TCP连接带来的问题：使用tcp长连接就会带来粘包的问题？？？？（粘包问题、如何解决这个问题呢）

什么是粘包？？？

TCP粘包就是指发送方发送的若干数据到达接收方粘成一包，从接受缓冲区来看，后一数据包的包头紧接着前一数据包的包尾。

【TCP粘包、分包的解决策略】：

1. 消息定长，比如100字节。
2. 在包尾部增加回车或空格符等特殊字符进行分割，典型的ftp协议。
3. 将消息分为消息头，消息尾。
4. 其他复杂的协议，如RTMP协议等。

2.Q：造成TCP粘包的原因
（1）发送方原因

TCP默认使用Nagle算法（主要作用：减少网络中报文段的数量），而Nagle算法主要做两件事：

只有上一个分组得到确认，才会发送下一个分组
收集多个小分组，在一个确认到来时一起发送
Nagle算法造成了发送方可能会出现粘包问题

（2）接收方原因

TCP接收到数据包时，并不会马上交到应用层进行处理，或者说应用层并不会立即处理。实际上，TCP将接收到的数据包保存在接收缓存里，然后应用程序主动从缓存读取收到的分组。这样一来，如果TCP接收数据包到缓存的速度大于应用程序从缓存中读取数据包的速度，多个包就会被缓存，应用程序就有可能读取到多个首尾相接粘到一起的包。

（3）解决措施：应用层的解决办法简单可行，不仅能解决接收方的粘包问题，还可以解决发送方的粘包问题。

解决办法：循环处理，应用程序从接收缓存中读取分组时，读完一条数据，就应该循环读取下一条数据，直到所有数据都被处理完成，但是如何判断每条数据的长度呢？

格式化数据：每条数据有固定的格式（开始符，结束符），这种方法简单易行，但是选择开始符和结束符时一定要确保每条数据的内部不包含开始符和结束符。
发送长度：发送每条数据时，将数据的长度一并发送，例如规定数据的前4位是数据的长度，应用层在处理时可以根据长度来判断每个分组的开始和结束位置。

UDP连接就不会产生粘包问题，这是因为TCP为了保证可靠传输并减少额外的开销，采用了基于流的传输，基于流的传输不认为消息是一条一条的，是无保护消息边界的。（保护消息边界：只传输协议吧数据当做一条独立的消息在网上传输，接受端一次只能接受一条独立的消息）。UDP是面向传输的，是有保护消息边界的，<u>**接收方一次只能接收一条独立的消息**，所以不存在粘包问题。</u>

=====================Git常用命令使用篇========================

1.（将本地项目上传到github 连接地址https://www.cnblogs.com/smfx1314/p/8426115.html）

 2.git命令：删除github 项目里面的文件夹，

3.git设置忽略某些文件或文件夹。【https://www.cnblogs.com/ayseeing/p/3580341.html】

```
$ git --help                                      # 帮助命令 
$ git pull origin master                    # 将远程仓库里面的项目拉下来
$ dir                                                # 查看有哪些文件夹
$ git rm -r --cached target              # 删除target文件夹
$ git commit -m '删除了target'        # 提交,添加操作说明

$ git push -u origin master               # 将本次更改更新到github项目上去

操作完成.

注:本地项目中的target文件夹不收操作影响,删除的只是远程仓库中的target, 可放心删除

每次增加文件或删除文件，都要commit 然后直接 git push -u origin master，就可以同步到github上了
```

=========================Socket篇===============================

- socket长连接与短连接
- 信号量和锁/队列 的概念
- 同步socket与异步socket
- 同步阻塞模式与异步非阻塞模式

Socket也称“套接字”用来描述IP地址，端口，它起源于unix，而unix/Linux基本哲学之一就是“一切皆文件对于文件的操作就是【打开】【读写】【关闭】 模式操作，socket就是该模式的一个实现，socket是一中特殊的文件。”Socket协议和http协议都属于应用层，socket套接字相当于是一组接口，socket连接建立之后不管是否使用都一直保持连接。

【socket的长连接与短连接介绍连接】：https://www.cnblogs.com/ldy-blogs/p/9252388.html

c#高性能大容量SOCKET并发（粘包、分包、解包。解读文章链接地址：https://blog.csdn.net/SQLDebug_Fan/article/details/20465455）

【Semaphore信号量】当多个线程并行运行时，难以避免对某些有限资源进行并发访问。信号量的作用就是可以让多个线程对有限资源进行并发访问。有关信号量的解释文档连接：https://blog.csdn.net/yangwohenmai1/article/details/90236036

1.关于信号量和锁/队列的概念。

信号量(Semaphore)是一种CLR中的内核同步对象。与标准的排他锁对象（Monitor，Mutex，SpinLock）不同的是，它不是一个排他的锁对象，它与SemaphoreSlim，ReaderWriteLock等一样允许多个有限的线程同时访问共享内存资源。Semaphore就好像一个栅栏，有一定的容量，当里面的线程数量到达设置的最大值时候，就没有线程可以进去。然后，如果一个线程工作完成以后出来了，那下一个线程就可以进去了。Semaphore的WaitOne或Release等操作分别将自动地递减或者递增信号量的当前计数值。当线程试图对计数值已经为0的信号量执行WaitOne操作时，线程将阻塞直到计数值大于0。

　　互斥量(Mutex) ，互斥量表现互斥现象的数据结构，也被当作二元信号灯。一个互斥基本上是一个多任务敏感的二元信号，它能用作同步多任务的行为，它常用作保护从中断来的临界段代码并且在共享同步使用的资源。
Mutex本质上说就是一把锁，提供对资源的独占访问，所以Mutex主要的作用是用于互斥。Mutex对象的值，只有0和1两个值。这两个值也分别代表了Mutex的两种状态。值为0,  表示锁定状态，当前对象被锁定，用户进程/线程如果试图Lock临界资源，则进入排队等待；值为1，表示空闲状态，当前对象为空闲，用户进程/线程可以Lock临界资源，之后Mutex值减1变为0。
　　Enqueue和Lock实际上是一个事物的两个名字。他们都支持队列(queue)和并发（concurrency）。他们在队列中的管理方式是“先进先出”(FIFO)的方式。



【异步socket&同步socket】学习帮助文档链接地址一：https://blog.csdn.net/u011555996/article/details/93378498

【关于异步同步socket的另一种解释。地址：https://blog.csdn.net/hguisu/article/details/7453390】

阻塞模式socket（当使用socket创建套接字，默认的套接字是阻塞模式。意思是当调用windows sockets API时不能立即返回，线程处于一直等待状态，直到操作完成。）

【异步非阻塞模式】又被称为长连接，相反，【同步阻塞模式】又被称为短连接。举个例子讲同步阻塞模式，假如需要测验100名学生400米成绩，如果你每次让一个学生起跑并等他回到终点你记下成绩然后让下一位学生起跑，知道所有学生跑完。那么现在你就掌握了同步阻塞模式，哈哈哈。在假如你换了一个方案，你一边每隔10秒让一位学生起跑，直达所有学生起跑完毕。另一边每有一个学生抵达终点就记录成绩，直到所有学生都跑完，现在恭喜你已经掌握异步非阻塞模式。这时你又想到一个方案，你带了很多怀表，让学生分组互相测验。现在的你已经学会了【多线程同步模式】。是不是效率大大提高了很多呢。（帮助文档连接https://blog.csdn.net/originpoint/article/details/84993476）

【补充资料===》关于socket阻塞与非阻塞、同步与异步的解释（连接地址https://www.cnblogs.com/msb-/articles/6042413.html）】

=======================扩展：多线程服务器=======================

【扩展：多线程服务器】

1.使用“线程池”或“连接池”。线程池主要目的减少创建销毁线程的频率，维持一定合理数量的线程。连接池是减少创建和关闭线程的频率，两种方式都可以降低系统的开销。被广泛应用到大型系统如apache，MySQL数据库。

======================Socket网络协议归纳========================

【Socket网络协议归纳】&&【信号量的作用】

socket（应用层）<< tcp/udp（传输层）<< IP（网络层）

A、<u>http</u>协议也就是超文本传输协议，是web联网的基础，也是手机联网常用协议之一，http协议是建立在tcp协议之上的一种应用。 

 HTTP连接最显著的特点就是每次客户端发送请求时都需要服务端会送响应，在请求结束后，会主动释放连接。从建立连接到关闭连接到过程称为"一次连接”。 

http 1.0，客户端的每次请求都要求建立一次单独的连接，在处理完本次请求后，就自动释放连接。 

 http 1.1，可以在一次连接中处理多个请求，且多个请求可以叠加进行，不需要等待请求结束后再发送下一个请求。 

B、socket连接： 建立Socket连接至少需要一对套接字，其中一个运行在客户端，称为ClientSocket，另外一个运行在服务端，称为ServerSocket。 

 套接字之间的过程分为：服务器监听、客户端请求、连接确认。 

1、服务器监听：服务端套接字并不定位具体的客户端套接字，而是处于等待连接的状态，实时监控网络状态，等待客户端的连接请求。

2、客户端请求：指客户端的套接字提出连接请求，要连接的目标是服务端的套接字。为此，客户端首先要描述他套连接的套接字，指出服务端的套接字的地址和端口号，然后就向服务端套接字提出连接请求。

3、连接确认：当服务端监听到或接收到客户端发送到套接字连接请求时，就响应客户端套接字的请求，建立一个新的线程，把服务端的套接字发送给客户端，一旦客户端确认了此描述，双方就正式建立连接。而服务端套接字处于肩痛状态，继续接受其他客户端套接字的连接请求。

<u>HTTP协议与socket之间形象化描述：http就是轿车，提供了封装或显示数据的具体形式。socket就是发动机，提供了网络通信的能力。</u>

1.信号量的作用。Semaphore、WaitOne、Release三者组成了一个互斥信号量的完整体系结构。Semaphore、WaitOne、Release究竟和AutoResetEvent/ManualResetEvent、WaitOne、Set、Reset有什么区别呢？我们往下看。（https://blog.csdn.net/yangwohenmai1/article/details/90236036）

=========================日常记录==============================

【【【

12.3（今天学习了c++与c#扑克牌发牌逻辑对比，tcp，socket，http协议，socket粘包分包问题待看）

12.4（学习扑克牌的发牌）

12.6（将本地项目上传到github 连接地址https://www.cnblogs.com/smfx1314/p/8426115.html）

2.客户端自身处理数据包机制。

3.socket 先建立连接，再处理连接的套接字请求，若请求成功再获取套接字字段传输 的数据。

12.11 将数据上传给应用层使用。接收套接字数据拷贝下来 。多吃 梨，猕猴桃

构造socketmsg类，客户端断开连接，发送数据】】】

=================多线程同步与互斥============================

【单例模式 多线程 加锁】，作用保证了第一次多个人同时访问，只能一个人进去创建对象 其余人都等待 第二次多个人访问时直接返回对象 。

多线程的同步与互斥锁（互斥锁、条件变量、读写锁、自旋锁、信号量）【https://blog.csdn.net/daaikuaichuan/article/details/82950711】互斥锁的出现就是为了控制对共享 资源的访问。你如在多线程访问共享资原就可以使用互斥锁来控制。

【多线程中的互斥锁与信号量的区别：】

信号量是一个完成了某一任务就通过信号量告诉别的线程，别的线程在进行某些动作。互斥锁是在多线程多任务互斥的，一个线程占用了某一资源，别的线程就无法访问，知道当前线程解锁（unlock），别的线程才可以访问利用这个资源。

总结归纳：信号量不一定锁定某个资源，而是流程上的概念，举个栗子 有AB两个线程，B要等A完成某一任务以后才可以进行自己的任务。而互斥原则是“锁住某一资源”，在锁定期间，其他线程是无法对该资源进行访问的。

================================================================

博客文章列表：1.https://blog.51cto.com/shahdza/p2 2.[https://icocos.github.io/2018/10/22/cocos2dx-lua-cc-ccs-ccui%E5%8C%BA%E5%88%AB%E5%92%8C%E4%BD%BF%E7%94%A8/](https://icocos.github.io/2018/10/22/cocos2dx-lua-cc-ccs-ccui区别和使用/)3.http://www.itjiaocheng.com/mianfei/（it教程网）4.智捷课堂 http://www.zhijieketang.com/course/explore?fliter=free&orderBy=studentNum

================================================================

youtube排名第一的励志英文演讲：https://mp.weixin.qq.com/s/O_D_FVRIIII1wqq4jGZqHA

==========================天干地支计算年分=======================

比如2019，2019-3=2016，2016/10余数为6，天干当中排在第六位的是己，2019-3=2016，2016/12余数为0，余数为0 在地支中倒数第一个就是亥。所以2019年是己亥年。

新浪博客博主（学习资料unity）：http://blog.sina.com.cn/s/blog_1322690230102xycl.html