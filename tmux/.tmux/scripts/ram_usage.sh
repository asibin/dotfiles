#!/bin/bash

sum_pages() {
  grep -Eo '[0-9]+' | awk '{ a += $1 } END { print a }'
}

stats="$(vm_stat)"

used_and_cached=$(echo "$stats" | grep -E "(Pages active|Pages inactive|Pages speculative|Pages wired down|Pages occupied by compressor)" | sum_pages)
cached=$(echo "$stats" | grep -E "(Pages purgeable|File-backed pages)" | sum_pages)
free=$(echo "$stats" | grep -E "(Pages free)" | sum_pages)

used=$((used_and_cached - cached))
total=$((used_and_cached + free))

awk -v used="$used" -v total="$total" 'BEGIN { printf "%.0f%%\n", 100*used/total }'
