#!/bin/bash

hostzone=$1     
firstblock=$2
step=$3
lastblock=$4
newSum=0
prevSum=0
prevHeight=0
printf 'hostZone,startHeight,endHeight,startBalance,endBalance,diff\n'
for height in `seq $firstblock $step $lastblock `;
do
    newSum=`./scripts/sumDelegations.py $hostzone/$hostzone-$height.json`
    diff=$(( $newSum - $prevSum ))
    if [[ $diff -ne 0 ]]; then
        printf '%s,%d,%d,%d,%d,%d\n' $hostzone $prevHeight $height $prevSum $newSum $diff
    fi
    prevSum=$newSum
    prevHeight=$height

done

# user@stride-dev-1:~/git/TaltaM/stride-unbonding-rounding/scripts$ ./calcDelegationsDifferences.sh juno 6078800 1 6079000
# juno,6078947,108557826668,-264800261
