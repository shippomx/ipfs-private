
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

### 启动
```bash
./init.sh
```
