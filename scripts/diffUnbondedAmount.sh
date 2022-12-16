#!/bin/bash

REQUESTED_AMOUNT=`./scripts/getUnbondingAmounts.sh $1 | awk '{s+=$1} END {printf "%.0f\n", s}'`
EXPECTED_AMOUNT=`./scripts/getUnbondedAmount.sh $1`
printf 'Requested amount: %d\n' "$REQUESTED_AMOUNT"
printf 'Expected amount: %d\n' "$EXPECTED_AMOUNT"
printf 'Diff: %d\n' "$((EXPECTED_AMOUNT-REQUESTED_AMOUNT))"
