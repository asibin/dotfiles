#!/bin/bash

top -l 1 | grep 'CPU usage' | awk '{printf "%.0f%%\n", $3 + $5}'
