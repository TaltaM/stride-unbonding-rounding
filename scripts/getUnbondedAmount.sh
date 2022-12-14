#!/bin/bash
cat $1 |grep "Total unbonded amount"|cut -d':' -f3|cut -d' ' -f2|egrep -o '[[:digit:]]+'
