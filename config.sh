#!/bin/bash

#############################################
# Configuration
#############################################

# APIs
# Public IP API
IP_API="https://api.ipify.org"

# Geolocation API
GEO_API="http://ip-api.com/json"

# Files
CURRENT_IP_FILE="./logs/current_ip.txt"
HISTORY_LOG="./logs/ip_history.log"
TRACKER_LOG="./logs/tracker.log"
CSV_REPORT="./reports/ip_report.csv"
NOTIFY_SCRIPT="./notifications/notify.sh"
HTML_REPORT="./reports/dashboard.html"

# Time Format
DATE_FORMAT="+%Y-%m-%d %H:%M:%S"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'