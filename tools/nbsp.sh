#!/bin/bash

if [[ $# -ne 2 ]]; then
	echo "Usage: $0 INPUT_FILE OUTPUT_FILE"
	exit 1
fi
sed -E 's/(^|[^[:alnum:]\\])(a|i|k|s|u|v|z|o)[[:space:]]+/\1\2~/gI' "$1" > "$2"
