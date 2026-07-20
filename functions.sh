#!/bin/bash

#############################################
#           Utility Functions
#############################################

print_header() {

    echo "======================================="
    echo "      IP ADDRESS TRACKER"
    echo "======================================="

}

log_message() {

    local message="$1"

    echo "$(date "$DATE_FORMAT") : $message" >> "$TRACKER_LOG"

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