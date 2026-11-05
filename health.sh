#!/usr/bin/env bash

set -euo pipefail

# Default warning limits
: "${DISK_LIMIT:=85}"
: "${MEM_LIMIT:=80}"

# Log file
LOG_DIR="$HOME/logs"
LOG_FILE="$LOG_DIR/health.log"

# Quiet mode
QUIET=false

# Check command arguments
if [[ $# -gt 1 ]]; then
    printf 'Usage: health.sh [--quiet]\n' >&2
    exit 2
fi

if [[ $# -eq 1 ]]; then
    if [[ "$1" == "--quiet" ]]; then
        QUIET=true
    else
        printf 'Usage: health.sh [--quiet]\n' >&2
        exit 2
    fi
fi

# Validate limits
if [[ ! "$DISK_LIMIT" =~ ^[0-9]+$ ]]; then
    printf 'Error: DISK_LIMIT must be a whole number.\n' >&2
    exit 2
fi

if [[ ! "$MEM_LIMIT" =~ ^[0-9]+$ ]]; then
    printf 'Error: MEM_LIMIT must be a whole number.\n' >&2
    exit 2
fi

# Create log directory
mkdir -p "$LOG_DIR"

# Get disk usage percentage
disk_usage=$(df -P / | awk 'NR == 2 {
    gsub(/%/, "", $5)
    print $5
}')

# Get memory usage percentage
mem_usage=$(awk '
    /^MemTotal:/ {
        total = $2
    }
    /^MemAvailable:/ {
        available = $2
    }
    END {
        if (total > 0) {
            printf "%d", ((total - available) * 100 / total) + 0.5
        } else {
            exit 1
        }
    }
' /proc/meminfo)

# Get system load average
read -r load _ < /proc/loadavg

# Get number of CPU cores
cores=$(nproc)

# Track whether any warning exists
any_warn=0

# Log and display each health check
log_check() {
    local label="$1"
    local metric="$2"
    local level="$3"
    local detail="$4"
    local timestamp

    timestamp=$(date '+%Y-%m-%d %H:%M:%S')

    printf '%s [%s] %s: %s %s\n' \
        "$timestamp" "$level" "$label" "$metric" "$detail" \
        >> "$LOG_FILE"

    if [[ "$QUIET" == false ]]; then
        printf ' %-8s %-18s %s' "$label" "$metric" "$level"

        if [[ -n "$detail" ]]; then
            printf ' (%s)' "$detail"
        fi

        printf '\n'
    fi
}

# Display system information
if [[ "$QUIET" == false ]]; then
    printf 'System health: %s  (%s)\n' \
        "$(hostname)" "$(date '+%Y-%m-%d %H:%M')"
fi

# Check disk usage
if (( disk_usage > DISK_LIMIT )); then
    log_check "Disk" "${disk_usage}%" "WARN" "limit ${DISK_LIMIT}%"
    any_warn=1
else
    log_check "Disk" "${disk_usage}%" "OK" ""
fi

# Check memory usage
if (( mem_usage > MEM_LIMIT )); then
    log_check "Memory" "${mem_usage}%" "WARN" "limit ${MEM_LIMIT}%"
    any_warn=1
else
    log_check "Memory" "${mem_usage}%" "OK" ""
fi

# Check load average per CPU core
if awk -v l="$load" -v n="$cores" \
    'BEGIN { exit !(l / n > 1.0) }'; then

    log_check "Load" "$load on $cores cores" "WARN" "limit 1.0 per core"
    any_warn=1
else
    log_check "Load" "$load on $cores cores" "OK" ""
fi

# Return the correct exit code
if (( any_warn == 1 )); then
    exit 1
fi

exit 0
