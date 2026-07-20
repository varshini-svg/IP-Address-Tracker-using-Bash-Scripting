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

    curl -s --head https://api.ipify.org > /dev/null

    if [ $? -eq 0 ]
    then
        return 0
    else
        return 1
    fi

}

#############################################
# Get Public IP
#############################################

get_public_ip() {

    curl -s "$IP_API"

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