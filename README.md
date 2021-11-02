## 起因

我手上有 x86_64 和 arm 架构的 linux 设备，以及 macOS，windows 设备，准备在这些平台上面安装 n2n，去 github 项目上只找到了源码，没看到作者发布编译好的多平台二进制文件，因此只能自己编译了，当前版本为 3.0

## 编译方法

#### linux, macOS

```sh
git clone https://github.com/ntop/n2n
cd n2n && mkdir build && cd build
cmake ..
make
```

编译完成后会在当前目录下生成`edge`和`supernode`这两个二进制文件

#### windows

windows 版找到了一个别人编译的版本，还是一个带图形界面的版本，因此我就没自己编译了，[windows 版 n2n 地址](https://bugxia.com/357.html)

## 直接下载

我把我编译好的的文件放到了 github 上:

https://github.com/LomotHo/n2n-releases/releases

## 使用方式

### 服务端

此处只以 linux 2.8 为例

- 安装

```sh
# 解压并放置文件
tar -zxvf https://github.com/LomotHo/n2n-releases/releases/download/2.8/n2n_v2.8_linux_x64.tar.gz
cd n2n_v2.8_linux_x64
mv n2n_v2.8_linux_x64 /opt/n2n
cd /opt/n2n

# 往/etc/n2n/中添加配置文件
mkdir -p /etc/n2n
cp conf/supernode.conf /etc/n2n/supernode.conf

# 修改配置文件
vim /etc/n2n/supernode.conf

# 设为守护进程并开机启动
cp service/n2n-supernode.service /etc/systemd/system/n2n-supernode.service
systemctl daemon-reload
systemctl enable --now n2n-supernode.service
```

- 配置文件 `supernode.conf`

```sh
# supernode.conf
-l=7700
```

服务端配置文件比较简单，只需要加上端口号就行

### linux 客户端

- 安装
  此处的安装方法与服务端相同，把 `supernode.conf` 替换为 `edge.conf`，`n2n-supernode.service` 替换为 `n2n-edge.service` 即可

- 配置文件 `edge.conf`

```ini
# edge.conf
-c=your-net-name
-k=secret
-m=xx:xx:xx:xx:xx:xx
-a=192.168.100.2
-l=n2n.xxxx.com:7700
-r
-E
```

### macos 客户端

- 安装

```sh
# 安装
brew install lomotho/taps/n2n
```

- 配置文件 lomotho.n2n-edge.plist, 用于 launchd 控制的开机自启（类似 systemd），路径为`/Library/LaunchDaemons/lomotho.n2n.edge.plist`

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
  <dict>
    <key>KeepAlive</key>
    <true/>
    <key>RunAtLoad</key>
    <true/>
    <key>Label</key>
    <string>lomotho.n2n.edge</string>
    <key>ProgramArguments</key>
    <array>
      <string>/usr/local/bin/edge</string>
      <string>/usr/local/etc/n2n/edge.conf</string>
    </array>
  </dict>
</plist>
```

- 服务管理

```sh
# 开启服务
launchctl load /Library/LaunchDaemons/lomotho.n2n.edge.plist

# 关闭服务
launchctl unload /Library/LaunchDaemons/lomotho.n2n.edge.plist
```
