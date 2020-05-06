# 编译了一份n2n 2.6.0(支持 linux x64, linux arm aarch64, macOS)

## 起因
我手上有x86_64和arm架构的linux设备，以及macOS，windows设备，准备在这些平台上面安装n2n，去github项目上只找到了源码，没看到作者发布编译好的多平台二进制文件，因此只能自己编译了，当前版本为2.6.0

## 编译方法
#### linux, macOS

```sh
./autogen.sh
./configure
make
```
编译完成后会在当前目录下生成```edge```和```supernode```这两个二进制文件

#### windows
windows版找到了一个别人编译的版本，还是一个带图形界面的版本，因此我就没自己编译了，[windows版n2n地址](https://bugxia.com/357.html)

## 使用brew安装
顺便做了一个macOS的homebrew版，执行下面的命令就能安装

```sh
brew install lomotho/taps/n2n
```

## 下载
https://github.com/LomotHo/n2n-releases/releases

## 用法
这里只做简单介绍，详细用法请参考 [官方文档](https://github.com/ntop/n2n)

 - edge节点
```sh
sudo ./edge -c mynetwork -k mysecretpass -a 192.168.100.10 -f -l supernode.ntop.org:7777
```

 - supernode节点
```sh
./supernode -l 7777
```

