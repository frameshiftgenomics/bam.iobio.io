#!/bin/bash

readDeptherPath="/Users/chase/Code/minion/bin/bamReadDepther"

curl -s $1 | $readDeptherPath
