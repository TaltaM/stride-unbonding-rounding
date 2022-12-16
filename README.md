# Verify unbonded amounts

## Results

| HostZone | date | nr | expected amount | found amount | block height | status |
| --- | --- | --- | ---: | ---: | --- | --- |
| juno | 20221208 | 01 | 28555221161 | 28555221161 | 6021887 | UndelegationOK |
| juno | 20221212 | 01 | 264800261 | 264800261 |6078947 | UndelegationOK |

## Flow

1. Isolate unbonding related lines from `epoch_$date_$time.log`:
   - Find line containing 'Total unbonded amount' and copy related lines
     to `logs/unbondings-$date-$nr.log`.
   - Add first and last found `Block Time` timestamps taken from the log
     file to the new file for reference
   - Convert timestamps to datetime e.g. by entering first 10 digits at: https://www.unixtimestamp.com/
   - Look up block height estimations in host zone explorer.
2. Check if the numbers reported by the new log file show that the amounts of unbonding
   requests match the expected unbonding amount :
   - Run `diffUnbondedAmount.sh logs/unbondings-$hostzone-$date-$nr.log`
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
2. - Run: `./scripts/diffUnbondedAmount.sh logs/unbondings-juno-20221212-01.log`:
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