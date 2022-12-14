#!/bin/bash

set -x

# Usage:
# Param 1: API URL
# Param 2: Delegator address
# Param 3: Block height
# Param 4: Output file

# COSMOS API: https://gaia-fleet.main.stridenet.co/api
# JUNO API: https://juno-fleet.main.stridenet.co/api
# OSMOSIS API: https://osmo-fleet-api.main.stridenet.co/
# STARGAZE API: https://stars-fleet.main.stridenet.co/api

# COSMOS Delegator address: cosmos10uxaa5gkxpeungu2c9qswx035v6t3r24w6v2r6dxd858rq2mzknqj8ru28
# JUNO Delegator address: juno1zjpfewdsdykrgce8d20lfanhh6evufxeyya4fyepjs9lh57tv3jqrutwt0
# OSMOSIS Delegator address: osmo1npfl4vmmmf4yqhcemz95mvqujgdnlhrlxfzhlhz2gru8g2t749xqr9zm5e
# STARGAZE Delegator address: stars1rfxv568skvtncxfl28s25scg87es4ez2w8q32z727mvtxgjmexuqc246ra

curl -H "x-cosmos-block-height: $3" $1/cosmos/staking/v1beta1/delegations/$2 -o $4