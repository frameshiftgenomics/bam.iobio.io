#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

readDeptherPath=$DIR/bamReadDepther

curl -s $1 | $readDeptherPath
