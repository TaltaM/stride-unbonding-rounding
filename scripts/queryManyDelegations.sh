#!/bin/bash

for i in `seq 7280000 100 7340000 `;
do
        ./scripts/queryDelegations.sh https://osmo-fleet-api.main.stridenet.co osmo1npfl4vmmmf4yqhcemz95mvqujgdnlhrlxfzhlhz2gru8g2t749xqr9zm5e $i osmosis-${i}.json
done

#for i in `seq 13200000 100 13258000 `;
#do
#        ./scripts/queryDelegations.sh https://gaia-fleet.main.stridenet.co/api cosmos10uxaa5gkxpeungu2c9qswx035v6t3r24w6v2r6dxd858rq2mzknqj8ru28 $i cosmos/cosmos-${i}.json
#done

#for i in `seq 5960000 200 6117000 `;
#do
#        ./scripts/queryDelegations.sh https://juno-fleet.main.stridenet.co/api juno1zjpfewdsdykrgce8d20lfanhh6evufxeyya4fyepjs9lh57tv3jqrutwt0 $i juno/juno-${i}.json
#done

#for i in `seq 5679800 200 6000000 `;
#do
#        ./scripts/queryDelegations.sh https://stars-fleet.main.stridenet.co/api stars1rfxv568skvtncxfl28s25scg87es4ez2w8q32z727mvtxgjmexuqc246ra $i stargaze/stargaze-${i}.json
#done
