#!/bin/bash

home=$PWD

function connectMainNode() {
    mainNode=$home/nodes/$1
    value=$(cat $mainNode/config | jq '.Identity.PeerID')
    head=${value#*\"}
    PeerID=${head%\"}
    nohup ipfs -config=$mainNode daemon > $home/logs/$1.log 2>&1 &
    for(( i=1;i<${#nodes[@]};i++)) do
        ipfs -config=$home/nodes/${nodes[i]} bootstrap add /ip4/127.0.0.1/tcp/4001/ipfs/$PeerID
        nohup ipfs -config=$home/nodes/${nodes[i]} daemon > $home/logs/${nodes[i]}.log 2>&1 &
    done
}

nodes=("magic" "manage" "node1" "node2")

connectMainNode $nodes