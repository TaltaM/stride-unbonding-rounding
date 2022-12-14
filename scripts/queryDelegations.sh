#!/bin/bash
grpcurl -plaintext -H "x-cosmos-block-height: $1"  -d '{"delegator_addr": "$2"}' $3 cosmos.staking.v1beta1.Query/DelegatorDelegations > $4 
