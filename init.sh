!#/bin/bash

rm -rf logs nodes && mkdir logs nodes


home=$PWD

function initNode() {
    cd $home
    nodeDir=$home/nodes/$1/
    rm -rf $nodeDir && mkdir -p $nodeDir
    cp $home/swarm.key $nodeDir
    ipfs -config=$nodeDir init 
    ipfs -config=$nodeDir bootstrap rm --all
    # 替换端口
    sed -ig "s/tcp\/4001/tcp\/400$2/" $nodeDir/config # Swarm
    sed -ig "s/tcp\/5001/tcp\/500$2/" $nodeDir/config # API
    sed -ig "s/tcp\/8080/tcp\/600$2/" $nodeDir/config # gateway
    rm -rf $nodeDir/configg
}


function connectMainNode() {
    mainNode=$home/nodes/$1

    key=$(cat $mainNode/config | awk -F "[PeerID]" '/PeerID/{print$0}')
    head=${key#*\"PeerID\"\: \"}
    PeerID=${head%\"\,}
    nohup ipfs -config=$mainNode daemon > $home/logs/$1.log 2>&1 &
    for(( i=1;i<${#nodes[@]};i++)) do
        ipfs -config=$home/nodes/${nodes[i]} bootstrap add /ip4/127.0.0.1/tcp/4001/ipfs/$PeerID
        nohup ipfs -config=$home/nodes/${nodes[i]} daemon > $home/logs/${nodes[i]}.log 2>&1 &
    done
}

nodes=("magic" "manage" "node1" "node2")

go run $home/main.go > $home/swarm.key
i=1
for node in ${nodes[@]}
do
    initNode "$node" $i
    let i+=1
done

echo "\n======== 初始化节点完成 ===========\n"

connectMainNode $nodes
rm $home/swarm.key