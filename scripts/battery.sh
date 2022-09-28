#!/bin/bash
PERCENTAGE=$(pmset -g batt 2>&1 | egrep "1?[0-9][0-9]%" | awk '{print $3}' | sed 's/;//')

if [ "$PERCENTAGE" != '' ]; then
    if [ "$1" == 'icons' ]; then
        printf "\xF0\x9F\x94\x8B %s" "${PERCENTAGE}"
    else
        printf "Bat: %s" "${PERCENTAGE}"
    fi
else
    # Silently fail
    printf ''
fi

