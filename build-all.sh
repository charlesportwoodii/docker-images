#!/bin/bash
for i in xenial centos7 rhel7 trusty; do
    for j in nginx php56 php70 php71 disque; do
        if [ -d ./$i/$j ]; then
            echo "Building $i/$j"
            docker build $i/$j
        fi
    done
done
