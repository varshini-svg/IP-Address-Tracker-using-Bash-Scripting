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

#############################################
# Save CSV Report
#############################################

save_csv_report() {

    local status="$1"

    echo "$(date '+%Y-%m-%d'),\
$(date '+%H:%M:%S'),\
$CURRENT_IP,\
$COUNTRY,\
$REGION,\
$CITY,\
$ZIP,\
$ISP,\
$ORG,\
$TIMEZONE,\
$LATITUDE,\
$LONGITUDE,\
$status" >> "$CSV_REPORT"

}

#############################################
# Send Notification
#############################################

send_notification() {

    local title="$1"
    local message="$2"

    bash "$NOTIFY_SCRIPT" "$title" "$message"

}

#############################################
# Generate HTML Dashboard
#############################################

generate_html_report() {

cat > "$HTML_REPORT" << EOF
<!DOCTYPE html>
<html>
<head>
<title>IP Tracker Dashboard</title>

<style>

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
}

body{

    font-family:'Segoe UI',Tahoma,Geneva,Verdana,sans-serif;
    background:linear-gradient(135deg,#0f172a,#1e3a8a,#2563eb);
    min-height:100vh;
    padding:40px;

}

.container{

    max-width:1200px;
    margin:auto;
    background:rgba(255,255,255,.96);
    border-radius:18px;
    padding:35px;
    box-shadow:0 20px 40px rgba(0,0,0,.25);

}

h1{

    text-align:center;
    color:#0f172a;
    margin-bottom:30px;
    font-size:38px;

}

.status{

    display:inline-block;
    padding:8px 18px;
    border-radius:25px;
    font-weight:bold;
    color:white;
    background:#10b981;

}

table{

    width:100%;
    border-collapse:collapse;
    overflow:hidden;
    border-radius:12px;
    margin-top:20px;

}

th{

    background:linear-gradient(90deg,#2563eb,#0ea5e9);
    color:white;
    padding:16px;
    font-size:18px;

}

td{

    padding:15px;
    border-bottom:1px solid #ddd;
    font-size:16px;

}

tr:nth-child(even){

    background:#f8fafc;

}

tr:hover{

    background:#e0f2fe;
    transition:.3s;

}

.info-grid{

    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(220px,1fr));
    gap:20px;
    margin-bottom:30px;

}

.card{

    background:white;
    border-left:6px solid #2563eb;
    border-radius:12px;
    padding:18px;
    box-shadow:0 6px 15px rgba(0,0,0,.08);

}

.card h3{

    color:#2563eb;
    margin-bottom:10px;

}

.card p{

    font-size:18px;
    font-weight:bold;

}

.history{

    margin-top:40px;

}

.history pre{

    background:#111827;
    color:#22c55e;
    padding:20px;
    border-radius:12px;
    overflow:auto;
    font-size:15px;

}

.footer{

    margin-top:35px;
    text-align:center;
    color:#555;
    font-size:14px;

}

</style>

</head>

<body>

<div class="container">

<h1>IP Address Tracker Dashboard</h1>

<table>

<tr>
<th>Parameter</th>
<th>Value</th>
</tr>

<tr>
<td>Date</td>
<td>$(date '+%Y-%m-%d')</td>
</tr>

<tr>
<td>Time</td>
<td>$(date '+%H:%M:%S')</td>
</tr>

<tr>
<td>Current IP</td>
<td>$CURRENT_IP</td>
</tr>

<tr>
<td>Status</td>
<td>$1</td>
</tr>

<tr>
<td>Country</td>
<td>$COUNTRY</td>
</tr>

<tr>
<td>Region</td>
<td>$REGION</td>
</tr>

<tr>
<td>City</td>
<td>$CITY</td>
</tr>

<tr>
<td>ISP</td>
<td>$ISP</td>
</tr>

<tr>
<td>Organization</td>
<td>$ORG</td>
</tr>

<tr>
<td>Timezone</td>
<td>$TIMEZONE</td>
</tr>

<tr>
<td>Latitude</td>
<td>$LATITUDE</td>
</tr>

<tr>
<td>Longitude</td>
<td>$LONGITUDE</td>
</tr>

</table>

<br>

<h2>Recent IP History</h2>

<pre>

$(tail -10 "$HISTORY_LOG")

</pre>

</div>

</body>

</html>

EOF

}