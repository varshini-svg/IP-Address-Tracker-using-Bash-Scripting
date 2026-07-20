#!/bin/bash

#############################################
#           Project Configuration
#############################################

# API URLs
IP_API="https://api.ipify.org"
GEO_API="http://ip-api.com/json"

# Log Files
CURRENT_IP_FILE="./logs/current_ip.txt"
HISTORY_LOG="./logs/ip_history.log"
TRACKER_LOG="./logs/tracker.log"

# Report File
CSV_REPORT="./reports/ip_report.csv"

# Notification Settings
ENABLE_NOTIFICATION=true

# Time Format
DATE_FORMAT="+%Y-%m-%d %H:%M:%S"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'