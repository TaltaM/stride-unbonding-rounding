#!/bin/bash
set -x
sed -n 's/.*validator_address:"\([+0-9a-zA-Z]*\)".*/\1/p' $1
