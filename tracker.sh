#!/bin/bash

source ./config.sh
source ./functions.sh

clear

print_header

#####################################################
# Internet Check
#####################################################

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

#####################################################
# Get Current Public IP
#####################################################

print_info "Fetching Public IP Address..."

CURRENT_IP=$(get_public_ip)

if validate_ip "$CURRENT_IP"
then
    print_success "Public IP Retrieved Successfully"
    log_message "Current Public IP: $CURRENT_IP"
else
    print_error "Invalid Public IP."
    log_message "Failed to retrieve IP."
    exit 1
fi

echo
echo "Current Public IP : $CURRENT_IP"
echo

#####################################################
# Compare Current IP with Previous IP
#####################################################

PREVIOUS_IP=$(read_previous_ip)

# First Execution
if [ -z "$PREVIOUS_IP" ]
then

    print_warning "No previous IP found."

    save_current_ip "$CURRENT_IP"

    echo "$(date "$DATE_FORMAT") | OLD: N/A | NEW: $CURRENT_IP | STATUS: FIRST ENTRY" >> "$HISTORY_LOG"

    log_message "First execution. IP saved."

    print_success "Current IP stored successfully."

# Same IP
elif [ "$CURRENT_IP" = "$PREVIOUS_IP" ]
then

    print_success "No IP Change Detected."

    log_message "No IP change."

# Different IP
else

    print_warning "Public IP Changed!"

    echo
    echo "Previous IP : $PREVIOUS_IP"
    echo "Current  IP : $CURRENT_IP"
    echo

    save_history "$PREVIOUS_IP" "$CURRENT_IP"

    save_current_ip "$CURRENT_IP"

    log_message "IP changed from $PREVIOUS_IP to $CURRENT_IP"

    print_success "History Updated."

fi

echo
print_success "Phase 3 Completed Successfully."