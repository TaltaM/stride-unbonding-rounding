#!/bin/bash
sed -n 's/.*amount:"\([+0-9]*\)".*/\1/p' $1
