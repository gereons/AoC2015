#!/bin/sh

DAY=$1

if [ -z "$DAY" ]; then
    echo "usage: $0 DAY" >&2
    exit 1
fi

D2=$(printf "%02d" $DAY)

curl https://adventofcode.com/2015/day/$DAY/input --cookie "session=$AOC_SESSION" >Fixtures/Day${D2}_input.txt
