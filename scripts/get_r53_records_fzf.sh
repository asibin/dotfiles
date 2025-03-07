#!/bin/bash

# Ensure required tools are installed
if ! command -v aws &>/dev/null || ! command -v fzf &>/dev/null || ! command -v jq &>/dev/null; then
    echo "Error: Ensure AWS CLI, jq, and fzf are installed."
    exit 1
fi

# Detect clipboard tool (Linux: xclip, macOS: pbcopy)
if command -v pbcopy &>/dev/null; then
    CLIP_CMD="pbcopy"
elif command -v xclip &>/dev/null; then
    CLIP_CMD="xclip -selection clipboard"
else
    echo "Error: No clipboard tool found (install xclip for Linux or use pbcopy on macOS)."
    exit 1
fi

# Hide cursor
tput civis

# Step 1: Get Hosted Zone List and Select One
echo -ne "Fetching Route 53 Hosted Zones...\r"
HOSTED_ZONES=$(aws route53 list-hosted-zones --query "HostedZones[*].{ID:Id, Name:Name}" --output json | jq -r '.[] | "\(.Name)\t\(.ID)"')
echo -ne "                                          \r" # Clears loading message

ZONE_NAME=$(echo "$HOSTED_ZONES" | cut -f1 | fzf --prompt="Select Hosted Zone: " --height=20 --border --reverse)

# If no selection, exit
if [ -z "$ZONE_NAME" ]; then
    tput cnorm
    exit 1
fi

# Extract Hosted Zone ID
HOSTED_ZONE_ID=$(echo "$HOSTED_ZONES" | grep "^$ZONE_NAME" | cut -f2)

# Step 2: Fetch Records for Selected Hosted Zone
echo -ne "Fetching DNS Records for $ZONE_NAME...\r"
RAW_RECORDS=$(aws route53 list-resource-record-sets --hosted-zone-id "$HOSTED_ZONE_ID" --output json)
echo -ne "                                          \r"

# Process records with jq
FORMATTED_RECORDS=$(echo "$RAW_RECORDS" | jq -r '
    .ResourceRecordSets[] |
    (
        .Name | rtrimstr(".")
    ) as $name |
    (
        .Type
    ) as $type |
    (
        if .TrafficPolicyInstanceId then 
            "Traffic Policy: " + .TrafficPolicyInstanceId
        elif .AliasTarget then 
            .AliasTarget.DNSName
        elif .ResourceRecords then 
            (
                if .ResourceRecords[0].Value == "Traffic policy record" then 
                    "Traffic Policy: " + (.TrafficPolicyInstanceId // "Unknown")
                else 
                    (.ResourceRecords | map(.Value) | join(", "))
                end
            )
        else 
            "N/A"
        end
    ) as $values |
    "\($name)\t\($type)\t\($values)"
')

# Ensure formatting with `column -t`
FORMATTED_RECORDS=$(echo -e "NAME\tTYPE\tVALUES\n$FORMATTED_RECORDS" | column -t -s $'\t')

# Show formatted output in fzf
SELECTED_RECORD=$(echo "$FORMATTED_RECORDS" | fzf --header-lines=1 --prompt="Search & Select Record: " --height=30 --border --reverse)

# If no record is selected, exit
if [ -z "$SELECTED_RECORD" ]; then
    tput cnorm
    exit 1
fi

# Extract the record name only (first column)
RECORD_NAME=$(echo "$SELECTED_RECORD" | awk '{print $1}')

# Copy selected record to clipboard
echo "Copying to clipboard: $RECORD_NAME"
echo -n "$RECORD_NAME" | $CLIP_CMD

# Restore cursor visibility
tput cnorm
