# Verify unbonded amounts

## Results

| HostZone | date | expected amount | requested amount | unbonded amount | difference | block height | status |
| --- | --- | ---: | ---: | ---: | ---: | --- | --- |
| cosmos | 20221208 | -192133500 | -192133500 | x | x | 13154000+ |  |
| cosmos | 20221212 | -1388465824 | -1388465824 | -1315585122 | **72880702** | 13222069 | Diff matches 'undelegated balance': Note 1 |
| juno | 20221208 | -28555221161 | -28555221161 | -28555221161 | 0 | 6021887 | UndelegationOK |
| juno | 20221212 | -264800261 | -264800261 | -264800261 | 0 | 6078947 | UndelegationOK |
| osmosis | 20221208 | -4889402 | -4889402 | 6354579687 | **-6359469089** | 7244300-7244400 | Sum matches 'undelegated balance': Note 2 |
| osmosis | 20221214 | -2203354 | -2203354 | -2203354 | 0 | 7333696 | UndelegationOK |
| stargaze | 20221208 | -4298398525 | -4298398525 | -4298398525 | 0 | 5913787 | UndelegationOK |
| stargaze | 20221214 | -45757447978 | -45757447978 | -45757447978 | 0 | UndelegationOK |  |

### Notes

Note 1: 
```
7:00PM INF |   COSMOSHUB-4   |  Redemption Rate Components - Undelegated Balance: 72880702, Staked Balance: 464919274656, Module Account Balance: 231403090, stToken Supply: 443849072916 module=x/stakeibc
7:00PM INF |   COSMOSHUB-4   |  New Redemption Rate: 1.048157103025075365 (vs Prev Rate: 1.048009253412448267) module=x/stakeibc
```

```
$ ./scripts/calcDelegationsDifferences.sh cosmos 13222067 1 13222069
hostZone,startHeight,endHeight,startBalance,endBalance,diff
cosmos,0,13222067,0,464919274665,464919274665
cosmos,13222068,13222069,464919274665,463603689543,-1315585122```

Note 2:
```
7:00PM INF |   OSMOSIS-1     |  Redemption Rate Components - Undelegated Balance: 6359469089, Staked Balance: 1222475550003, Module Account Balance: 176499000, stToken Supply: 1205432980482 module=x/stakeibc
7:00PM INF |   OSMOSIS-1     |  New Redemption Rate: 1.019560222751307147 (vs Prev Rate: 1.019560050198398924) module=x/stakeibc
```

```
$ ./scripts/calcDelegationsDifferences.sh osmosis 7240000 100 7250000
hostZone,startHeight,endHeight,startBalance,endBalance,diff
osmosis,0,7240000,0,1215420987179,1215420987179
osmosis,7240900,7241000,1215420987179,1222475550003,7054562824
osmosis,7244300,7244400,1222475550003,1228830129690,6354579687
osmosis,7248000,7248100,1228830129690,1229006628690,176499000
```

## Flow

1. Isolate unbonding related lines from `epoch_$date_$time.log`:
   - Find line containing 'Total unbonded amount' and copy related lines
     to `logs/unbondings-$date.log`.
   - Add first and last found `Block Time` timestamps taken from the log
     file to the new file for reference
   - Convert timestamps to datetime e.g. by entering first 10 digits at: https://www.unixtimestamp.com/
   - Look up block height estimations in host zone explorer.
2. Check if the numbers reported by the new log file show that the amounts of unbonding
   requests match the expected unbonding amount :
   - Run `diffUnbondedAmount.sh logs/unbondings-$hostzone-$date.log`
3. Download balance records for delegators at their host zones with `queryManyDelegations.sh`.
   This script needs as input: host zone, first block height, block height step size and last block height.
4. Check if the delegator's balance decreased anywhere in the period. Note that the differenes can be
   calculated over a range of blocks, so if there are more delegations than undelegations, you need
   a smaller step size.
   `calcDelegationsDifferences.sh` repeatedly calls `sumDelegations.py` and reports back.
5. If a smaller range of block heights is found with a comparable decrease in balance, zoom in by
   going back to step 3. with a smaller step size (preferrably step size=1)

## Example

1. - Created `logs/unbondings-20221212-02.log`
   - Block Time: 1670871584274751011 (Mon Dec 12 2022 18:59:44 GMT+0000)
     Block Time: 1670861233737979333 (Mon Dec 12 2022 16:07:13 GMT+0000)
   - Ballpark block height: 6070000
2. - Run: `./scripts/diffUnbondedAmount.sh logs/unbondings-juno-20221212.log`:
```
$ ./scripts/diffUnbondedAmount.sh ../logs/unbondings-20221212-02.log
Requested amount: 264800261
Expected amount: 264800261
Diff: 0
```
3. `$ ./scripts/queryManyDelegations.sh juno 6000000 1000 6110000`
4. `$ ./scripts/calcDelegationsDifferences.sh juno 6000000 1000 6110000`
output:
```
hostZone,startHeight,endHeight,startBalance,endBalance,diff
juno,6021000,6022000,128873645200,100349450583,-28524194617
juno,6078000,6079000,108822626929,108615975497,-206651432
```
5. 6021000 is a bit early, so:
```
./scripts/queryManyDelegations.sh juno 6078000 200 6079000
./scripts/calcDelegationsDifferences.sh juno 6078000 200 6079000 
```
output:
```
hostZone,startHeight,endHeight,startBalance,endBalance,diff
juno,6078800,6079000,108822626929,108615975497,-206651432
```

Again:
```
./scripts/queryManyDelegations.sh juno 6078800 1 6079000
./scripts/calcDelegationsDifferences.sh juno 6078800 1 6079000
```
output:
```
hostZone,startHeight,endHeight,startBalance,endBalance,diff
juno,6078946,6078947,108822626929,108557826668,-264800261
```

Note that the diff for block 6078946->6078947 matches the expected amount: -264800261