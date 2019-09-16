# 越狱环境

**arm64架构**

- iPhone 5s 及以后机型
- iPad Air，iPad mini2 及以后机型
- iOS 8 ～ iOS 10 完美越狱

> 检查手机及对应版本是否可以越狱：[http://jailbreak.25pp.com/ios](http://jailbreak.25pp.com/ios)

### Cydia 安装

#### 软件源

- apt.25pp.com
- apt.saurik.com
- Bigboss

#### 插件

- Apple File Conduit
- AppSync Unified
- iFile
- pp助手
- openssh
- Cycript
- adv-cmds
- reveal loader
- Vi IMproved

### Mac 上软件安装

- [PP 助手](https://pro.25pp.com/)
- [iFunBox]([http://www.i-funbox.com/](http://www.i-funbox.com/))
- [MachOView](https://github.com/gdbinit/MachOView)
- Reveal
- Hopper Disassembler



# 逆向环境

> **$** 为 Mac 终端命令，**#** 为 iPhone 终端命令

### Wi-Fi 连接

默认密码 `alpine`

```bash
$ ssh root@<iPhone-IP-Address>
```

### 服务器身份信息变更

删除公钥信息（`~/.ssh/known_hosts`）

```bash
$ ssh-keygen -R <iPhone-IP-Address>
```

### 免密 SSH 登陆 iPhone

```bash
$ ssh-keygen
$ ssh-copy-id root@<iPhone-IP-Address>
$ scp ~/.ssh/id_rsa.pub root@<iPhone-IP-Address>:~
$ ssh root@<iPhone-IP-Address>
# mkdir .ssh
# cat ~/id_rsa.pub >> ~/.ssh/authorized_keys
# rm ~/id_rsa.pub
# chmod 755 ~
# chmod 755 ~/.ssh
# chmod 644 ~/.ssh/authorized_keys
```

### USB 调试

下载 [usbmuxd](https://cgit.sukimashita.com/usbmuxd.git/snapshot/usbmuxd-1.0.8.tar.gz) 到 `~/Documents`，把 iPhone 的 22 端口映射到本机 localhost 的 10010 端口

```bash
$ cd ~/Documents/usbmuxd-1.0.8/python-client
$ python tcprelay.py -t 22:10010 10011:10011
```

新建一个命令行窗口，通过连接 localhost 的 10010 端口即连接 iPhone 的 22 端口

```bash
$ ssh root@localhost -p 10010
```

### iOS 终端的中文乱码问题

在 `~/.inputrc` 里添加以下内容：

```
set convert-meta off 
set output-meta on
set meta-flag on 
set input-meta on
```



# Cycript

常用工具：[mjcript](https://github.com/CoderMJLee/mjcript)

列出所有进程

```bash
# ps -A
```

进入 App 的 Cycript 环境

```bash
# cycript -p <pid or app_exec_name>
```

常用语法

```
[UIApplication sharedApplication]
UIApp
var app = UIApp.keyWindow
#<address_value>
ObjectiveC.classes
*UIApp
UIApp.keyWindow.recursiveDescription().toString()
choose(UIViewController)
```



# Mach-O 文件

```c
#define MH_OBJECT 0x1      /* relocatable object file */
#define MH_EXECUTE 0x2     /* demand paged executable file */
#define MH_FVMLIB 0x3      /* fixed VM shared library file */
#define MH_CORE 0x4        /* core file */
#define MH_PRELOAD 0x5     /* preloaded executable file */
#define MH_DYLIB 0x6       /* dynamically bound shared library */
#define MH_DYLINKER 0x7    /* dynamic link editor */
#define MH_BUNDLE 0x8      /* dynamically bound bundle file */
#define MH_DYLIB_STUB 0x9  /* shared library stub for static */
                           /*  linking only, no section contents */
#define MH_DSYM 0xa        /* companion file with only debug */
                           /*  sections */
#define MH_KEXT_BUNDLE 0xb /* x86_64 kexts */

```

| 常见 Mach-O |                             描述                             |
| :---------: | :----------------------------------------------------------: |
|  MH_OBJECT  |      目标文件（.o）静态库文件(.a）即多个 .o 合并在一起       |
|  MH_DYLIB   |                动态库 `dylib` 和  `framework`                |
| MH_DYLINKER |                动态链接编辑器 `/usr/lib/dyld`                |
|   MH_DSYM   | 存储二进制文件符号信息的文件`.dSYM/Contents/Resources/DWARF/xxx`（常用于分析APP的崩溃信息） |

查看Mach-O的文件类型

```bash
$ file <file_dir>

```

导出某种特定架构

```bash
$ lipo <mach_o_file_dir> -thin arm64 -output <output_dir>

```

合并多种架构

```bash
$ lipo <mach_o_file_1> <mach_o_file_2> -output <output_dir>

```



# 脱壳

工具

- [Clutch](https://github.com/KJCracks/Clutch)
- [dumpdecrypted](https://github.com/stefanesser/dumpdecrypted/)

查看可执行文件是否已脱壳

```bash
$ otool -l <exec_dir> | grep crypt

```

`crypt` 为 `0` 则已脱壳

将 `make` 编译后得到的 `dumpdecrypted.dylib` 放到 `/var/root/` 下，使用 `ps -A` 获取 App 可执行文件

```bash
# DYLD_INSERT_LIBRARIES=dumpdecrypted.dylib <exec_dir>

```

#### 导出头文件

使用工具 [class-dump](http://stevenygard.com/projects/class-dump/) 导出 Objective-C 编写的 App 的头文件

```bash
$ class-dump -H <app_exec_dir> -o <headers_folder_output_dir>

```



# Theos

安装签名工具 `ldid`

```bash
$ brew install ldid

```

配置环境变量，在 `.bash_profile` 里加入：

```bash
$ export THEOS=~/theos
$ export PATH=$THEOS/bin:$PATH
$ export THEOS_DEVICE_IP=127.0.0.1
$ export THEOS_DEVICE_PORT=10010

```

下载 `theos`

```bash
$ cd ~ && git clone --recursive https://github.com/theos/theos.git $THEOS

```

创建 `tweak` 项目

```bash
$ nic.pl

```

选择 `[iphone/tweak]`

> MobileSubstrate Bundle filter: 破解 App 的 Bundle ID

打开 `Tweak.xm` 文件编写代码

```objective-c
%hook XXXView
- (id)initWithFrame:(struct CGRect)arg1 {
  return nil; 
}
%end

```

编译打包安装

```bash
$ make clean && make && make package && make install

```

其他资料：

> 目录结构：https://github.com/theos/theos/wiki/Structure
> 环境变量：http://iphonedevwiki.net/index.php/Theos
> Logo语法：http://iphonedevwiki.net/index.php/Logos



# 动态调试

复制 iPhone 上 `/Developer` 里的 `debugserver`，导出 `entitlements` 权限文件

```bash
$ ldid -e debugserver > debugserver.entitlements

```

打开 `entitlements` 文件，增加以下两项：

- get-task-allow
- task_for_pid-allow

`Boolen` 值，设为 `YES`

然后把 `entitlements` 权限重新签给 `debugserver`

```bash
$ ldid -Sdebugserver.entitlements debugserver

```

再把 `debugserver` 移动到 iPhone 的 `/usr/bin` 下

#### 把 debugserver 附加到 App 上

```bash
# debugserver *:10011 -a <pid or app_exec_name>

```

启动 `lldb` 并连接 `debugserver`

```bash
$ lldb
(lldb) process connect connect://<iPhone-IP-Address>:10011

```

#### 通过 debugserver 启动 App

```bash
# debugserver -x auto *:10011 <app_exec_dir>

```



# LLDB

**执行一个表达式**

```bash
(lldb) expression self.view.backgroundColor = [UIColor redColor]

```

`--`为命令选项结束符

**打印线程堆栈信息**

```bash
(lldb) thread backtrace
(lldb) bt

```

**让函数不执行断电后的内容并直接返回**

```bash
(lldb) thread return

```

**打印当前栈帧变量**

```bash
(lldb) frame variable

```

**继续运行**

```bash
(lldb) thread continue
(lldb) continue
(lldb) c

```

**单步运行（子函数为一步）**

```bash
(lldb) thread step-over
(lldb) next
(lldb) n
(lldb) ni  # instruction

```

**单步运行（遇到子函数则进入）**

```bash
(lldb) thread step-in
(lldb) step
(lldb) s
(lldb) si  # instructios

```

**执行完当前函数所有代码，返回上一个函数**

```bash
(lldb) thread step-out
(lldb) finish

```



**断点**

```bash
(lldb) breakpoint set -n test
(lldb) breakpoint set -n touchesBegan:withEvent:
(lldb) breakpoint set -n "-[ViewController touchesBegan:withEvent:]"
(lldb) breakpoint set -r <regex_expression>

(lldb) breakpoint list
(lldb) breakpoint enable <bpt_no>
(lldb) breakpoint disable <bpt_no>
(lldb) breakpoint delete <bpt_no>

```

**内存断点**（在内存数据发生改变时触发）

```bash
(lldb) watchpoint set variable self->age
(lldb) watchpoint set expression &(self->_age)

```



**查找某个类型的信息**

```bash
(lldb) image lookup -t <type>

```

**根据内存地址查找在模块中的位置**

```bash
(lldb) image lookup -a <address>

```

**查找某个符号或者函数的位置**

```bash
(lldb) image lookup -n <symbol_name or func_name>

```

**列出所加载模块的信息**

```bash
(lldb) image list
(lldb) image list -o -f  # 打印模块全路径和偏移地址

```



# 重签名

获取使用付费证书在 Xcode 编译后的 App 包中的 `embedded.mobileprovision` 文件

从 `embedded.mobileprovision` 提取 `entitlements.plist` 权限文件

```bash
$ security cms -D -i embedded.mobileprovision > tmp.plist
$ /usr/libexec/PlistBuddy -x -c 'Print :Entitlements' tmp.plist > entitlements.plist

```

查看可用证书

```bash
$ security find-identity -v -p codesigning

```

对 `.app` 包内的动态库，AppExtension 等进行重签名

```bash
$ codesign -fs <cer_id or cer_str> <dylib_dir>

```

对 `.app` 包进行重签名

```bash
$ codesign -fs <cer_id or cer_str> --entitlements entitlements.plist <app_file>

```

> GUI工具：
>
> 提取 `embedded.mobileprovision` 拷贝到 `.app` 内部后，再使用 [iOS App Signer](https://github.com/DanTheMan827/ios-app-signer) 工具进行重签名

#### 动态库注入

下载工具包 [insert_dylib](https://github.com/Tyilo/insert_dylib)，编译后把可执行文件放入 `/usr/local/bin`

```bash
$ cd <app_file_exec_dir>

```

在 iPhone 的 `/Library/MobileSubstrate/DynamicLibararies` 目录下找到把编写的 `tweak` 项目生成的动态库，把它拷贝出来，注入到 App 可执行文件中

```bash
$ insert_dylib @executable_path/<tweak_dylib_name> <app_exec_name> --all-yes --waek <app_exec_name>

```

#### 更改动态库加载地址

拷贝 iPhone 的 `/Library/Frameworks/CydiaSubstrate.framework/CydiaSubstrate` 到 `tweak` 项目生成的动态库同级目录下

更改 `tweak` 项目生成的动态库依赖项目录

```bash
$ install_name_tool -change /Library/Frameworks/CydiaSubstrate.framework/CydiaSubstrate @loader_path/CydiaSubstrate <tweak_dylib_name>

```

重签名后安装 `ipa` 文件到非越狱手机上



以上大部分代码和工具包可以在我的 [GitHub](https://github.com/iWeslie/ReverseEngineering) 里找到
