#!/bin/bash
./getUnbondingAmounts.sh $1 | awk '{s+=$1} END {printf "%.0f\n", s}'
