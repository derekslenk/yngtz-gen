#!/bin/bash

while true; do

    while [ ! -f updated ]; do
        sleep 1
    done
    rm updated
    
    date

    ./parse.sh

    rm -f dataset.tar.xz
    cd out
    tar cf ../dataset.tar --owner=0 --group=0 .
    cd ..
    xz -T0 -9 dataset.tar

    mv graphs/three-gorges.png graphs/three-gorges-3d.png graphs/three-gorges-24h.png graphs/cuntan.png graphs/cuntan-3d.png graphs/cuntan-24h.png graphs/hankou.png graphs/hankou-3d.png graphs/hankou-24h.png graphs/hankou-prev.png graphs/yichang.png graphs/yichang-3d.png graphs/yichang-24h.png graphs/shashi-chenglingji.png graphs/shashi-chenglingji-3d.png graphs/shashi-chenglingji-24h.png /var/www/html
    cp three-gorges.gnuplot cuntan.gnuplot hankou.gnuplot hankou-prev.gnuplot yichang.gnuplot shashi-chenglingji.gnuplot parse.sh /var/www/html/source
    mv csv/three-gorges.csv csv/cuntan.csv csv/hankou.csv csv/hankou-prev.csv csv/yichang.csv csv/wulong.csv csv/cuntan-wulong.csv csv/shashi-chenglingji.csv dataset.tar.xz /var/www/html/source
    tar xJf /var/www/html/source/dataset.tar.xz --directory /var/www/html/source/dataset/

    sync; sync; sync

    date

    echo "*****************************************"

done
