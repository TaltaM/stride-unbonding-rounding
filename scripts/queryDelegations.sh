#!/bin/bash

# Usage:
# Param 1: API URL
# Param 2: Delegator address
# Param 3: Block height
# Param 4: Output file

curl -H "x-cosmos-block-height: $3" $1/cosmos/staking/v1beta1/delegations/$2 -o $4