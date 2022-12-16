#!/bin/bash

hostzone=$1
firstblock=$2
step=$3
lastblock=$4

COSMOS_API="https://gaia-fleet.main.stridenet.co/api"
JUNO_API="https://juno-fleet.main.stridenet.co/api"
OSMOSIS_API="https://osmo-fleet-api.main.stridenet.co"
STARGAZE_API="https://stars-fleet.main.stridenet.co/api"

COSMOS_Delegator_address="cosmos10uxaa5gkxpeungu2c9qswx035v6t3r24w6v2r6dxd858rq2mzknqj8ru28"
JUNO_Delegator_address="juno1zjpfewdsdykrgce8d20lfanhh6evufxeyya4fyepjs9lh57tv3jqrutwt0"
OSMOSIS_Delegator_address="osmo1npfl4vmmmf4yqhcemz95mvqujgdnlhrlxfzhlhz2gru8g2t749xqr9zm5e"
STARGAZE_Delegator_address="stars1rfxv568skvtncxfl28s25scg87es4ez2w8q32z727mvtxgjmexuqc246ra"

API=
ADDRESS=
if [[ $hostzone == 'cosmos' ]]; then
        API=$COSMOS_API
        ADDRESS=$COSMOS_Delegator_address
elif [[ $hostzone == 'juno' ]]; then
        API=$JUNO_API
        ADDRESS=$JUNO_Delegator_address
elif [[ $hostzone == 'osmosis' ]]; then
        API=$OSMOSIS_API
        ADDRESS=$OSMOSIS_Delegator_address
elif [[ $hostzone == 'stargaze' ]]; then
        API=STARGAZE_API
        ADDRESS=$STARGAZE_Delegator_address
fi

for height in `seq $firstblock $step $lastblock `;
do
        curl -H "x-cosmos-block-height: $height" $API/cosmos/staking/v1beta1/delegations/$ADDRESS -o $hostzone/a-$hostzone-$height.json
done