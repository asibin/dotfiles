#!/bin/bash

{ macmon pipe 2>/dev/null; } | head -1 | jq -r '.temp.cpu_temp_avg | round | tostring + "°C"'
