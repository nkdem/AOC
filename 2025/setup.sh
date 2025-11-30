#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: ./setup.sh <day_number>"
  exit 1
fi

DAY=$1
DIR="day$DAY"

mkdir -p "$DIR/inputs"
cp template.go "$DIR/day$DAY.go"
sed -i '' "s/dayN_input/day${DAY}_input/g" "$DIR/day$DAY.go"
touch "$DIR/inputs/day${DAY}_input"

echo "Created $DIR with day$DAY.go and inputs/day${DAY}_input"
