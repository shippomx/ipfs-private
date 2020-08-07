
# 快速搭建ipfs私链的脚本

## 必备环境
    - linux or macos
    - go:latest
    - ipfs: 安装参考官网教程, 我使用的是源码安装

## 简介
    四个节点，magic作为主节点存在, 其它节点暂时作为从节点. 可以在init.sh文件中修改nodes数组为自己需要的名称, 默认第一个名称是主节点.
    `Swarm`端口4001起, `API`端口5001起, `gateway`端口6001起。

## 使用
    假定已经安装了所需的必备条件

```bash
git clone https://github.com/shippomx/ipfs-private.git
```

### 初始化
```bash
./init.sh
```

### 启动
```bash
./start.sh
```

## 关于配置ipfs-desktop连接到刚刚搭建的私链

### 安装参照官方文档

### 将IPFS-Desktop连接到私链
- 修改ipfs-desktop的配置, 首先将默认的连接节点置空
	![IPFS Config](https://s1.ax1x.com/2020/08/07/afBf9P.png)
- 再将节点的位置设置为自己私链的根目录:
	IPFS-Desktop -> Advanced -> Open Configuration File

	![IPFS Desktop Config 1](https://s1.ax1x.com/2020/08/07/afBRht.png)

- 改为自己刚刚新建的IPFS私链的某个节点的根目录:
	![IPFS Desktop Config 2](https://s1.ax1x.com/2020/08/07/afB2tI.png)

然后重启软件，存取一个文件上去就可以在`ipfs-desktop`上看到刚刚的文件了。