#!/usr/bin/python3

import json, sys

def main(args):
    try:
        inputFile = open(args[1])
        data = json.load(inputFile)
        inputFile.close()
    except IndexError:
        return False
    amount = 0
    for i in data['delegation_responses']:
        amount += int(i['balance']['amount'])
    print(amount)
    return True

if __name__ == "__main__":
    sys.exit(not main(sys.argv))
