#!/bin/sh
INPUT_FILE="$1"
OUTPUT_FILE="$2"

cp "$INPUT_FILE" "$OUTPUT_FILE"

# Handle ${VAR:-default} syntax
for match in $(grep -o '\${[A-Za-z0-9_]*:-[^}]*}' "$OUTPUT_FILE" | sort -u); do
  var=$(echo "$match" | sed 's/\${//;s/:-.*//')
  default=$(echo "$match" | sed 's/.*:-//;s/}//')
  value=$(printenv "$var")
  if [ -z "$value" ]; then
    value="$default"
  fi
  sed -i "s|$match|$value|g" "$OUTPUT_FILE"
done

# Handle simple ${VAR} syntax
for var in $(grep -o '\${[A-Za-z0-9_]\+}' "$OUTPUT_FILE" | tr -d '${}' | sort -u); do
  value=$(printenv "$var")
  if [ -n "$value" ]; then
    sed -i "s|\${$var}|$value|g" "$OUTPUT_FILE"
  fi
done
