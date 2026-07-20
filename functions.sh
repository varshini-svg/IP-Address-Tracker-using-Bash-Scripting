#!/bin/bash

#############################################
# Display Functions
#############################################

print_header() {

    echo "==========================================="
    echo "        IP ADDRESS TRACKER"
    echo "==========================================="

}

print_success() {

    echo -e "${GREEN}$1${NC}"

}

print_error() {

    echo -e "${RED}$1${NC}"

}

print_warning() {

    echo -e "${YELLOW}$1${NC}"

}

print_info() {

    echo -e "${BLUE}$1${NC}"

}

#############################################
# Logging
#############################################

log_message() {

    echo "$(date "$DATE_FORMAT") : $1" >> "$TRACKER_LOG"

}

#############################################
# Internet Check
#############################################

check_internet() {

    curl -s https://api.ipify.org > /dev/null

}

#############################################
# Get Public IP
#############################################

get_public_ip() {

    curl -s "$IP_API"

}

#############################################
# Get Geolocation Information
#############################################

get_geolocation() {

    local ip="$1"

    curl -s "$GEO_API/$ip"

}

#############################################
# Validate IPv4
#############################################

validate_ip() {

    local ip="$1"

    if [[ $ip =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]]
    then
        return 0
    else
        return 1
    fi

}

#############################################
# Read Previous IP
#############################################

read_previous_ip() {

    if [ -f "$CURRENT_IP_FILE" ];
    then
        cat "$CURRENT_IP_FILE"
    else
        echo ""
    fi

}

#############################################
# Save Current IP
#############################################

save_current_ip() {

    echo "$1" > "$CURRENT_IP_FILE"

}

#############################################
# Save History
#############################################

save_history() {

    local old_ip="$1"
    local new_ip="$2"

    echo "$(date "$DATE_FORMAT") | OLD: N/A | NEW: $CURRENT_IP | STATUS: FIRST ENTRY | COUNTRY: $COUNTRY | CITY: $CITY | ISP: $ISP" >> "$HISTORY_LOG"

}