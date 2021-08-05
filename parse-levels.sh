#!/bin/bash

DATE=$(date)

# Previous inflow value
CURINFLOW=$(tail -n 1 levels.txt | awk '{ print $2 }')
PREVINFLOW=$(cat csv/three-gorges.csv | cut -d ' ' -f3 | grep -v "^0$" | tail -n 2 | head -n 1)

#Previous outflow value
OUTFLOW=$(tail -n 2 levels.txt | head -n 1 | awk '{ print $2}')

PREVTGD=$(tail -n 2 csv/three-gorges.csv | awk '{print $5}' | head -n 1)
TGD=$(tail -n 1 csv/three-gorges.csv | awk '{print $5}')

PREVCUNTAN=$(tail -n 2 csv/cuntan-wulong.csv | awk '{print $5}' | head -n 1)
CUNTAN=$(tail -n 1 csv/cuntan-wulong.csv | awk '{print $5}')

PREVYICHANG=$(tail -n 2 csv/yichang.csv | awk '{print $5}' | head -n 1)
YICHANG=$(tail -n 1 csv/yichang.csv | awk '{print $5}')

PREVHANKOU=$(tail -n 2 csv/hankou.csv | awk '{print $5}' | head -n 1)
HANKOU=$(tail -n 1 csv/hankou.csv | awk '{print $5}')

NEWOUTFLOW=$(tail -n 1 csv/three-gorges.csv | awk '{print $2}')
NEWINFLOW=$(tail -n 1 csv/three-gorges.csv | awk '{ if ($3==0) print "-"; else print $3 }')

if [ $NEWINFLOW = "-" ]; then
    NEWINFLOW=$CURINFLOW
fi

#Thanks https://stackoverflow.com/questions/11237794/how-to-compare-two-decimal-numbers-in-bash-awk

printf "CURRENT WATER LEVELS\n" >levels.txt

if echo $CUNTAN $PREVCUNTAN | awk '{exit !( $1 > $2)}'; then
    printf "Chongqing:        %s m ↑\n" $CUNTAN >>levels.txt
elif echo $CUNTAN $PREVCUNTAN | awk '{exit !( $1 < $2)}'; then
    printf "Chongqing:        %s m ↓\n" $CUNTAN >>levels.txt
else
    printf "Chongqing:        %s m ‒\n" $CUNTAN >>levels.txt
fi

if echo $TGD $PREVTGD | awk '{exit !( $1 > $2)}'; then
    printf "Three Gorges Dam: %s m ↑\n" $TGD >>levels.txt
elif echo $TGD $PREVTGD | awk '{exit !( $1 < $2)}'; then
    printf "Three Gorges Dam: %s m ↓\n" $TGD >>levels.txt
else
    printf "Three Gorges Dam: %s m ‒\n" $TGD >>levels.txt
fi

if echo $YICHANG $PREVYICHANG | awk '{exit !( $1 > $2)}'; then
    printf "Yichang:          %s m ↑\n" $YICHANG >>levels.txt
elif echo $YICHANG $PREVYICHANG | awk '{exit !( $1 < $2)}'; then
    printf "Yichang:          %s m ↓\n" $YICHANG >>levels.txt
else
    printf "Yichang:          %s m ‒\n" $YICHANG >>levels.txt
fi

if echo $HANKOU $PREVHANKOU | awk '{exit !( $1 > $2)}'; then
    printf "Hankou/Wuhan:     %s m ↑\n" $HANKOU >>levels.txt
elif echo $HANKOU $PREVHANKOU | awk '{exit !( $1 < $2)}'; then
    printf "Hankou/Wuhan:     %s m ↓\n" $HANKOU >>levels.txt
else
    printf "Hankou/Wuhan:     %s m ‒\n" $HANKOU >>levels.txt
fi

printf "\nCURRENT FLOW RATES\n" >>levels.txt

printf "Prev outflow is: %s\n" $OUTFLOW
printf "New outflow is: %s\n" $NEWOUTFLOW
if (($NEWOUTFLOW > $OUTFLOW)); then
    printf "Outflow:          %s m³/s ↑\n" $NEWOUTFLOW >>levels.txt
elif (($NEWOUTFLOW < $OUTFLOW)); then
    printf "Outflow:          %s m³/s ↓\n" $NEWOUTFLOW >>levels.txt
else
    printf "Outflow:          %s m³/s ‒\n" $NEWOUTFLOW >>levels.txt
fi

printf "Prev inflow is: %s\n" $PREVINFLOW
printf "New inflow is: %s\n" $NEWINFLOW
if (($NEWINFLOW > $PREVINFLOW)); then
    printf "Inflow:           %s m³/s ↑\n" $NEWINFLOW >>levels.txt
elif (($NEWINFLOW < $PREVINFLOW)); then
    printf "Inflow:           %s m³/s ↓\n" $NEWINFLOW >>levels.txt
else
    printf "Inflow:           %s m³/s ‒\n" $NEWINFLOW >>levels.txt
fi

# printf "Updated: %s\n" $DATE >> levels.txt
