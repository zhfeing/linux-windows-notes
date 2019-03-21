# ssh 界面化

如果在ubuntu系统下，服务器安装运行SSH服务,安装命令:
```
sudo apt-get install openssh-server
```

ssh客户端一般是自带的，如果没有可以执行
```
sudo apt-get install openssh-client进行安装，
```

之后执行
```
ps -e|grep ssh
```
如果有ssh-agent那么就表示ssh客户端安装成功了。在终端可以输入
ssh username@192.168.0.222登录到192.168.0.222这个ssh服务器，然后会让你输入密码，之后就登录了。

ssh连接成功后，如果想要显示图形界面，需要做一些配置。步骤如下：

1、服务器端的ssh必须运行转发X界面，在ssh服务器中，找到/etc/ssh/sshd_config 这个配置文件，其中有一行X11Forwarding yes，确保这个是yes（注意这个配置文件中的#是注释，确保X11Forwarding前面没有#注释），然后重启ssh服务，cd /etc/init.d这个目录下执行 ./ssh restart

2、客户端配置，在/etc/ssh/ssh_config配置文件中，找到ForwardAgent yes，ForwardX11 yes，ForwardX11Trusted yes这3个确保是yes（注意这个配置文件中的#是注释，确保你修改的行没有被注释掉）

3、配置完成后，进入终端，现在假设我们的ubuntu客户端的ip是192.168.0.19（只是假设），而ssh服务器的ip是192.168.0.222。下面是执行步骤，注意别弄错了：

首先终端未连接ssh之前，执行xhost +192.168.0.222 这个步骤是允许ssh服务器的X界面连接过来然后执行ssh -X root@192.168.0.222 注意-X这个是大写的X，这个步骤是连接到ssh服务器，接着会要输入密码

这个时候终端已经连接到ssh服务器了，然后执行export DISPLAY=192.168.0.19:0.0这个步骤是把ssh服务器的X显示重新定位到192.168.0.19的0.0显示器中，也就是我们的客户端

然后做个测试，执行xclock，等待。。。如果这个时候在你的ubuntu界面中出现了一个时钟界面，那么恭喜你成功了。