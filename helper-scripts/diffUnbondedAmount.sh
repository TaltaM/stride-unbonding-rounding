#!/bin/bash
set -x
SENTAMOUNT=`./getUnbondingAmounts.sh $1 | awk '{s+=$1} END {printf "%.0f\n", s}'`
ACTUALAMOUNT=`./getUnbondedAmount.sh $1`
echo $((ACTUALAMOUNT-SENTAMOUNT))
