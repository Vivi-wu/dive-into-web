---
title:  "命令行工具及Shell语句tips"
category: Other
---
## Shell语句tips

Shell 是Unix系统下的一种命令行解释器。

本文摘录《The Missing Semester of Your CS Education(2020)》视频里提到的 shell 命令。

```sh
date # 显示当前日期时间
echo "Hello, world" # 输出 Hello, world
echo Hello\ world # 一样的效果
echo hello > hello.txt # 输出 hello 到 hello.txt 文件
echo $? # 显示上一条命令的返回值，0 表示成功，非 0 表示失败
cat hello.txt # 显示 hello.txt 文件内容
cat < hello.txt  >> hello2.txt # 将 hello.txt 文件内容追加到 hello2.txt 文件末尾
which echo # 显示 echo 命令的路径
pwd # 打印当前目录路径
cd /home # 切换到 /home 目录
cd .. # 切换到上级目录
cd ./home # 切换到当前目录下的 home 目录
cd - # 切换到上一次所在目录
ls # 列出当前目录下的文件和目录
ls -l # 列出详细信息，包括文件权限、所有者、大小、修改日期
mkdir My\ Photos # 创建目录 My Photos
rmdir My\ Photo/ # 删除目录 My Photo/
rm test.txt # 删除文件 test.txt
man ls # 查看 ls 命令的手册，按 q 退出
exit # 退出当前用户
open index.html # 在默认浏览器中打开 index.html 文件
grep foobar mcd.sh # 在 mcd.sh 文件中搜索 foobar 字符串
grep -R foobar . # 在当前目录及其子目录下搜索 foobar 字符串
grep -v 'moon' # 搜索不包含 moon 字符串的行
diff <(ls foo) <(ls bar) # 比较并显示 foo 和 bar 目录下的文件和目录
find . -name test -type d # 在当前目录下查找名为 test 的目录
touch project{1..3} # 创建 project1、project2、project3 三个空文件
rm project{1..3} # 删除 project1、project2、project3 三个文件
history | grep grep # 显示在终端里运行过的命令中包含 grep 的命令
alias gs # 查看指定命令的别名
unalias gs # 删除指定命令的别名
cmp mcd.sh mcd.dec.sh # 比较两个文件是否相同。可以使用 echo $? 查看返回值，0 表示相同，非 0 表示不同。
```

<!--more-->
有一些保留的命令行参数，如：`$0` 至 `$9`，表示上一条命令的第 0 至 9 个参数。`$_` 表示上一条命令的最后一个参数。

### pipe 命令

作用是将左侧的命令的输出作为右侧的命令的输入。通过管道命令，shell可以用一行命令执行复杂的操作。

```sh
ls -l / | tail -n1 # 列出根目录下最后一个文件或目录
curl --head --silent baidu.com | grep -i content-length # 获取网页内容长度
cat mcd.sh | wc -l # 统计并显示 mcd.sh 内容的行数，包含空行
sort | uniq -c # 统计并显示排序后的结果中每个元素出现的次数
sort -nk1,1 | awk '{print $2}' | paste -sd, # 显示第二列排序后的结果，并用逗号分隔显示在一行
echo "1+2" | bc # 计算 1+2 的结果
awk '$1 != 1 {print $1}' | paste -sd+ | bc # 计算第1列不等于1的数字之和，并显示结果
grep nightly | sed 's/-x86.*//' | xargs npm uninstall # 卸载所有包含 nightly 的 npm 包。sed 作用是替换字符串，这里是将 -x86 后的内容替换为空；xargs 作用是将前面命令的输出作为后面命令的输入
```

### sudo 命令

作用是以超级用户权限执行命令。比如一些文件被限制只能用超级用户权限才能修改。两种方法：一是切换到 root 用户再执行，二是直接使用 sudu 执行命令。

```sh
sudo su # 切换到 root 用户
echo 10 | sudo tee brightness # 输出 10 到 brightness 文件，并以 root 用户权限写入
```

### 清屏

ctrl + l

## windows系统Shell使用
在Windows系统 git-bash 终端命令行工具里，实用Windows资源管理器打开当前文件夹/目录

```bash
start .
```

[一个比较全的windows用户命令行汇总](http://johnatten.com/2012/09/08/basic-git-command-line-reference-for-windows-users/)

## SSH

SSH是一个安全的shell，用于远程登录到另一台计算机。也可以在远程机器上执行shell命令，并将结果显示在本地终端。

```sh
ssh user@host # 登录远程主机，host可以是ip地址也可以是域名
ssh user@host ls -la # 在远程主机上执行 ls -la 命令并显示结果
scp notes.md user@host:/path/to/notes_remote.md # 复制文件到远程主机。批量上传文件可以使用 rsync 命令，遇网络中断支持断点续传。
```

+ 使用SSH keys可以避免每次登录时输入密码。
+ 使用 ~/.ssh/config 文件，配置hostname、user、IdentityFile等，可以简化 SSH 登录过程。

## 更多示例

### 执行 shell 文件

使用 *.sh 文件，在命令行终端里运行 ./*.sh

Mac 下提示“permission denied”，解决：

[在 Mac 上的“终端”中使文件可执行](https://support.apple.com/zh-cn/guide/terminal/apdd100908f-06b3-4e63-8a87-32e71241bab4/mac)

```sh
chmod 755 文件名.sh
```

### 输出日期时间

```sh
echo "今天是`date`"

TIMESTAMP=`date "+%Y-%m-%d %H:%M:%S"`

echo "自定义日期时间输出 $TIMESTAMP"
```

### 从 iconfont.cn 下载字体文件到当前目录下

```sh
curl -v --cookie "cna=mTNtFEok3SkCAdy/utIDGBNM;EGG_SESS_ICONFONT=U8AXvqwdm-42-umGXGwgKq_Emj2wuVCkA87TjZ3dn6xm2T4whio3sIKoy4kjkuBSusLMQ-0MhcjWBE1FwhfGmHa4MwEHgW7pCbfU0Hhk3uY-kuveEaSWqxlut4MQVPKIeSSVMupL3DmRr12ReN1T2N42hwjutmR7MXZUdpP2MKhd3KnGyvF-m5v25bLDdQ4_6v4TEkYINuWDnZUYFvmlUU-zLA2yUIJnAXT1l7IE6mcwan95FbClOMPyq5OP_nLNdLq-J16YgAVR8l_XWPWku2xnCXnPkd2OVoNrV95rv73IlDKsd_jGq1DwbQh1GHEAFg-J13jkl9xYuXnDON2qtwxPaBoMdLeDStDkAQT1ly_MA9-ylpzcuaBBc8SBqIrtrsFn7mjsYel-sv8NGpTKIqMp47AoAkoBGaUxHrycjQM-9OnQJQK7ADr3sXbwGmeNQc3c1GH-hFm3cJS4UYAvf5nOBVJUf2Ap-GpV7uV8JUAIPM45cQThrxB1QTzpDhHu1Ngd8xuwG3Y6jKQawTJMY4H817sRld6_0sW4pcEDleYsp66BMA2eW61q0nfu2j2oCsVl4UAztS9xo0ePXrirAITDPm_xR9iu-pjGVb-ewjhyoWpjEK2YT0vVE6hBUbtiCgwKCn99mik6CCUt5-ZXc3C_wAitmL1AWZ5FB3ASWkBDQpAROHMsXpIb-Ryn_iCmcmh54XopgVw1NuB7Z0P0136Ur9NUGnYkgZ6RRl7yAECTMVr8kUFmPteLcr3-hgbvzTeD1IqiBIUhHnLtG0dJDF0bEErb5rgrj5GwDPPU2k6QwzirhH9hnqxIHOLYDc35or5svYSdRhaMtH7ScBvOuRsOAYQsXI1SzRNcnwPI22tmzS4k3twc5CJZety0bVln5JsnWeUNJ1chcJ8kaWCssuLMkG538LgwrOF8eUhpOGNELgipd28XNcKMd3VCAjKRdz301BNqCfilPPnAJiRITJmQ0EFnQS90TZMvmuaXrMWXirfIYa5MxdrYrO_kOcXWGkFJHvU1nTHjptxmwUGGWjr-47eE5-d5P0l_OcsG5k5wEX9bASRI8R7-MDxwpen1b0nYSDCpjERlZ-HoJijpsw==;trace=AQAAAKHxKXcbeQoAg19EZSNDhCJwSspr;ctoken=AkUxJUxFFHzd3gQ7fGGvWiSY;u=835843;u.sig=m5P7qa1Gc4S42xqNJtLhyDkgl2gyhmUJgrUEdkVhFAg;isg=BIGB_fAau04Xqdd6y9_noZfKkM2brvWg4aPV3OPWJAiXyqGcK_zfcK7LqD6MQo3Y" https://www.iconfont.cn/api/project/download.zip\?spm\=a313x.7781069.1998910419.d7543c303\&pid\=1969599\&ctoken\=AkUxJUxFFHzd3gQ7fGGvWiSY --output download.zip
```

1. 解压文件

    ```sh
    unzip download.zip
    ```
2. 删除以指定字符开头的文件

    ```sh
    rm -rf icon*
    ```
3. copy文件到指定目标，并重命名

    ```sh
    cp font_*/*.js ../public/font/iconfont_v1.js
    ```

curl 指令不设置请求method的值则默认为 get。下面指令表示设置请求头，并带上 cookie。

```sh
curl -H 'custom-header:值' -b ‘_ga=cookie1;_gid=cookie2’ http://www.example.com
```

### 查看网络连接耗时

```sh
time curl https://www.baidu.com/

# 输出结果，real 表示网络请求总共耗时，user 表示用户态耗时，sys 表示内核态耗时，两者相加是执行命令的总耗时。可以看出绝大多数时间花费在网络等待上。
real	0m0.160s 
user	0m0.022s
sys 	0m0.013s
```

### 监控进程内存使用情况

Mac终端：

```sh
top -pid 7272
```

### 提取视频帧另存为图片

下面的命令的作用是提取视频第一帧，使用图片处理为灰度图，并保存为 output.png 文件，然后用 feh 图片查看器显示图片。macOS需要额外安装convert、feh工具

```sh
ffmpeg -loglevel panic -i input.mp4 -frames 1 -f image2 - | convert - -colorspace gray - | tee output.png ｜ feh output.png
```

### 查找 Node 进程 pid

虽然可以通过代码输出 `console.log(process.pid)`, 但是以下可以不侵入代码，通过端口号在终端里定位进程。

```sh
lsof -i:3011
```

本地启动dev server，有时没有正常stop，再运行时终端报错“The address "http://127.0.0.1:9292" is already in use.”

通过指令找到对应端口号进程的pid（ex：22133），关闭掉进程

```sh
lsof -i tcp:9292
kill -9 22133
```

### source script.sh 和 ./script.sh 的区别

一些术语：

+ shell session：一个终端会话，每个session有自己的环境变量、命令历史、当前工作目录等。
+ bash instance：一个新的bash实例/进程，可以用来执行命令，但不能改变当前目录。一个bash instance，可以有多个shell session，

前者告诉当前的shell session执行script.sh，后者启动一个新的bash实例，然后在那里执行script.sh。

区别：当script.sh试图改变目录，后者执行时会改变目录，但当程序退出并返回你的shell时，你的shell仍然保持在相同的位置。

或者script.sh定义一些函数，你想在shell session里执行这些函数。你需要source这个script.sh，而不是执行它。如果你执行它，那些函数会被定义在启动的bash实例里，而不是定义在你当前的shell session里。

## Unix 信号

在终端输入 ctrl + c 向系统发送 _SIGINT_ 信号，告诉程序停止运行。

_SIGQUIT_ 信号用于终止进程（对大多数程序效果同上），_SIGKILL_ 信号用于杀死进程。

_SIGHUP_ 信号用于通知程序终端挂起，可用于重启程序。

_SIGCONT_ 信号用于恢复进程，可用于暂停的程序。
