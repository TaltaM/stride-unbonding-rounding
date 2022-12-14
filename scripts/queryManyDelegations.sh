#!/bin/bash

#for i in `seq 7231000 100 7280000 `;
#do
#        ./scripts/queryDelegations.sh https://osmo-fleet-api.main.stridenet.co osmo1npfl4vmmmf4yqhcemz95mvqujgdnlhrlxfzhlhz2gru8g2t749xqr9zm5e $i osmosis-${i}.json
#done

for i in `seq 5859000 100000 5999000 `;
do
        ./scripts/queryDelegations.sh https://stars-fleet.main.stridenet.co/api stars1rfxv568skvtncxfl28s25scg87es4ez2w8q32z727mvtxgjmexuqc246ra $i stargaze-${i}.json
done
