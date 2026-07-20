#!/bin/bash

source config.sh
source functions.sh

clear

print_header

print_info "Checking Internet Connection..."

if check_internet
then
    print_success "Internet Connection Available"
    log_message "Internet connection verified."
else
    print_error "No Internet Connection!"
    log_message "Internet connection failed."
    exit 1
fi

echo

print_info "Fetching Public IP Address..."

CURRENT_IP=$(get_public_ip)

if validate_ip "$CURRENT_IP"
then
    print_success "Public IP Retrieved Successfully"
    log_message "Public IP: $CURRENT_IP"
else
    print_error "Unable to retrieve a valid Public IP."
    log_message "Invalid IP received."
    exit 1
fi

echo
echo "Current Public IP : $CURRENT_IP"
echo

print_success "Phase 2 Completed Successfully."