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
# Fetch Geolocation Information
#####################################################

print_info "Fetching Geolocation Information..."

GEO_DATA=$(get_geolocation "$CURRENT_IP")

COUNTRY=$(echo "$GEO_DATA" | jq -r '.country')
REGION=$(echo "$GEO_DATA" | jq -r '.regionName')
CITY=$(echo "$GEO_DATA" | jq -r '.city')
ZIP=$(echo "$GEO_DATA" | jq -r '.zip')
LATITUDE=$(echo "$GEO_DATA" | jq -r '.lat')
LONGITUDE=$(echo "$GEO_DATA" | jq -r '.lon')
ISP=$(echo "$GEO_DATA" | jq -r '.isp')
ORG=$(echo "$GEO_DATA" | jq -r '.org')
TIMEZONE=$(echo "$GEO_DATA" | jq -r '.timezone')

print_success "Geolocation Retrieved Successfully."

echo
echo "========== GEOLOCATION =========="
echo "Country      : $COUNTRY"
echo "Region       : $REGION"
echo "City         : $CITY"
echo "ZIP Code     : $ZIP"
echo "ISP          : $ISP"
echo "Organization : $ORG"
echo "Timezone     : $TIMEZONE"
echo "Latitude     : $LATITUDE"
echo "Longitude    : $LONGITUDE"
echo

#####################################################
# Compare Current IP with Previous IP
#####################################################

PREVIOUS_IP=$(read_previous_ip)
echo "========== DEBUG =========="
echo "CURRENT_IP_FILE = $CURRENT_IP_FILE"

if [ -f "$CURRENT_IP_FILE" ]; then
    echo "✓ File exists"
else
    echo "✗ File does NOT exist"
fi

if [ -s "$CURRENT_IP_FILE" ]; then
    echo "✓ File has data"
else
    echo "✗ File is empty"
fi

echo "PREVIOUS_IP = '$PREVIOUS_IP'"
echo "==========================="
echo

# First Execution
if [ ! -s "$CURRENT_IP_FILE" ]
then

    print_warning "No previous IP found."

    save_current_ip "$CURRENT_IP"

    echo "$(date "$DATE_FORMAT") | OLD: N/A | NEW: $CURRENT_IP | STATUS: FIRST ENTRY | COUNTRY: $COUNTRY | CITY: $CITY | ISP: $ISP" >> "$HISTORY_LOG"

    log_message "First execution. IP saved."

    print_success "Current IP stored successfully."

    save_csv_report "FIRST ENTRY"

# Same IP
elif [ "$CURRENT_IP" = "$PREVIOUS_IP" ]
then

    print_success "No IP Change Detected."

    log_message "No IP change."

    save_csv_report "NO CHANGE"

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

    save_csv_report "CHANGED"

fi

echo
print_success "CSV Report Updated Successfully."

echo
print_success "Phase 5 Completed Successfully."