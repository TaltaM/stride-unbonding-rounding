import json, sys

data = json.load(sys.stdin)

amount = 0
for i in data['delegationResponses']:
	amount += int(i['balance']['amount'])

print(amount)
