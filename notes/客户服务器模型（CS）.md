C/S模式与B/S模式区别与联系：

## 客户/服务器模型（C/S）

- 特点：非对等相互作用，客户与服务器处于不平等地位。具体表现在服务器拥有客户所不具备的的软件资源和硬件以及运算能力。服务器提供服务，客户请求服务。

- 循环服务器和并发服务器

  循环服务器：通过在单线程内设置循环控制实现对多个客户请求的逐一响应。 
  并发服务器：通过使请求处理（多线程）和I/O部分重叠达到高性能。

  ```lua
  循环服务器和并发服务器的选择取决于对单个客户请求的处理时延。
  客户较少、时延较长时考虑并发服务；客户量大、时延较短、请求频繁优先考虑循环服务。
  ```

- 有状态和无状态服务器

  判断依据：服务器或本地客户是否保存状态信息

  有状态服务器举例：网络游戏服务器

  无状态服务器举例：禁用cookie功能的web服务器

- 客户与服务器的位置关系：

  1. 客户与服务器运行在同一台机器上----应用于网络应用程序开发测试。
  2. 客户与服务器运行在同一个局域网的不同机器上-----局域网文件共享、局域网打印机。
  3. 客户与服务器运行在广域网不同网络内的机器上-----最常见的网络应用程序。

- 客户与服务器的数量关系：

  1. 对个客户进程可同时访问一个服务器进程（n：1）
  2. 一个客户进程可同时访问多个服务器提供的服务（1：n）

1. C/S又称Client/Server或客户/服务器模式。服务器需要高性能的PC机、工作站、小型机。并采用大型数据库，如：Oracdle、Sybase、Informix或SQLServer。客户端需要安装客户端软件。

## 浏览器/服务器模型（B/S）

### 浏览器/服务器模型（B/S）

用户通过www浏览器实现，一部分事务逻辑在前端（浏览器）实现，主要事务逻辑在服务端实现。通常以三层架构（表现层、事务逻辑层、数据处理层）部署实施。
B/S模型是特殊的客户/服务器模型，特殊之处在于，客户端软件特质浏览器，使用HTTP协议通信。用同用浏览器实现原来需要复杂专用软件才能实现的客户功能，节约了开发成本。

三层架构：表示层、逻辑层、数据层

```lua
客户端表示层。由Web浏览器组成，不存放任何应用程序。
应用服务器层(事务逻辑层)。由一台或多台服务器组成，具有良好的可扩展性。
数据中心层（数据处理层）。有数据库系统组成，用于存放业务数据。
```
---

联系

    浏览器/服务器（B/S）模型是一种特殊的、具体化的客户/服务器（C/S）模型，其特殊之处是B/S模型的客户端软件特指浏览器，服务器一般是Web服务器，使用HTTP协议通信。其工作过程是C/S模型的具体化、实例化。
    二者的本质思想均是基于计算机网络中，不同主机之间软硬件资源、运算能力和信息不均等，为实现资源信息共享，必然形成不对等的通信地位和交互方式。
    两种结构对应的软件系统均为分布式网络应用程序系统。
------

模型组成

1. 客户端程序+服务器程序，如微信客户端版、PC版的网络游戏

2. Web浏览器+服务器，如微信网页版、网页在线游戏。

   工作过程

   C/S模型：

       打开一个通信通道，告知服务器进程所在主机将在某一端口上接受客户请求。
       等待客户的请求到达该端口。
       服务器接收到服务请求，处理该请求并发送应答。
       返回至第2步，等待并处理另一个客户的请求。
       关闭服务器。

   B/S模型：
   这里写图片描述
   1. 用户通过浏览器向Web服务器提出HTTP请求。
   2. Web服务器根据浏览器请求调出相应文件，对相应文件不做处理或加以解释执行后，将纯客户端HTML代码结果返回给浏览器。
   3. 浏览器接收到Web服务器发回的页面内容（纯HTML代码），显示给用户。
   优缺点

   C/S模型：
   优点：

       结构简单。
       支持分布式、并发环境。有效提高资源的利用率和共享程度。
       服务器集中管理资源，有利于权限控制和系统安全。
       可扩展性较好。客户和服务器均可单独地升级

   传统C/S相比较B/S的局限：
   1.不易部署（客户端逐一安装、挑平台）
   2.维护困难（客户端需注意更新）

   B/S
   优点：分布式、易扩展、共享性强
   相比较传统的C/S的优势：
   1.易部署（各平台自带通用浏览器）
   2.容易维护（服务器端改变网页内容可实现所有用户同步更新）
   3.页面动态刷新，响应速度明显降低。

原文链接：https://blog.csdn.net/hhhanpan/article/details/79592594

