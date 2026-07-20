# IP Address Tracker

A Bash-based IP Address Tracker that monitors your public IP address, detects IP changes, retrieves geolocation information, maintains logs, generates CSV and HTML reports, and provides desktop notifications when changes occur.

## Features

* Public IP address detection
* Internet connectivity verification
* Public IP validation
* Automatic IP change detection
* Geolocation lookup using a public REST API
* History logging
* CSV report generation
* HTML dashboard generation
* Desktop notifications
* Timestamped execution logs
* Modular Bash scripting
* Cross-platform notification support (Linux, Windows Git Bash, macOS)

---

## Project Structure

```text
IP-Tracker/
│
├── logs/
│   ├── current_ip.txt
│   ├── ip_history.log
│   └── tracker.log
│
├── reports/
│   ├── ip_report.csv
│   └── dashboard.html
│
├── notifications/
│   └── notify.sh
│
├── cron/
│   └── setup_cron.sh
│
├── screenshots/
│
├── tracker.sh
├── config.sh
├── functions.sh
├── README.md
└── .gitignore
```

---

## Technologies Used

* Bash Shell Scripting
* cURL
* jq
* HTML
* CSS
* REST APIs
* Git

---

## APIs Used

### Public IP API

```
https://api.ipify.org
```

### Geolocation API

```
http://ip-api.com/json
```

---

## Features Implemented

### Phase 1

* Project setup
* Folder structure
* Configuration file
* Logging system

### Phase 2

* Internet connectivity verification
* Public IP retrieval
* IP validation

### Phase 3

* Previous IP comparison
* IP history tracking
* Change detection

### Phase 4

* Geolocation retrieval
* Country
* Region
* City
* ZIP Code
* ISP
* Organization
* Timezone
* Latitude
* Longitude

### Phase 5

* CSV report generation
* Automatic report updates
* Execution status tracking

### Phase 6

* Desktop notifications
* Windows support
* Linux support
* macOS support

### Phase 7

* HTML dashboard
* Responsive dashboard layout
* Recent history section
* CSS styling

---

## Installation

Clone the repository.

```bash
git clone https://github.com/<username>/IP-Tracker.git
```

Move into the project directory.

```bash
cd IP-Tracker
```

Grant execution permissions.

```bash
chmod +x tracker.sh
chmod +x notifications/notify.sh
```

---

## Dependencies

### Ubuntu / Debian

```bash
sudo apt update
sudo apt install curl jq
```

### Fedora

```bash
sudo dnf install curl jq
```

### Arch Linux

```bash
sudo pacman -S curl jq
```

### Windows

Install:

* Git Bash
* jq
* cURL (included with Git for Windows)

---

## Usage

Run the tracker.

```bash
bash tracker.sh
```

---

## Sample Output

```text
===========================================
        IP ADDRESS TRACKER
===========================================

Checking Internet Connection...
Internet Connection Available

Fetching Public IP Address...
Public IP Retrieved Successfully

Current Public IP : xxx.xxx.xxx.xxx

Fetching Geolocation Information...
Geolocation Retrieved Successfully.

Country      : India
Region       : Tamil Nadu
City         : Coimbatore
ISP          : Example ISP

No IP Change Detected.

CSV Report Updated Successfully.

Notification Sent Successfully.

HTML Dashboard Generated.

Phase 7 Completed Successfully.
```

---

## Generated Reports

### Tracker Log

```
logs/tracker.log
```

Stores execution details and application events.

### IP History

```
logs/ip_history.log
```

Maintains a history of IP changes.

### CSV Report

```
reports/ip_report.csv
```

Stores structured tracking data for analysis.

### HTML Dashboard

```
reports/dashboard.html
```

Displays a formatted dashboard containing IP details, geolocation, and recent history.

---

## Notification Support

Desktop notifications are supported on:

* Linux using `notify-send`
* Windows using PowerShell
* macOS using AppleScript

---

## Configuration

The following settings can be modified in `config.sh`.

```bash
CURRENT_IP_FILE="./logs/current_ip.txt"
HISTORY_LOG="./logs/ip_history.log"
TRACKER_LOG="./logs/tracker.log"
CSV_REPORT="./reports/ip_report.csv"
HTML_REPORT="./reports/dashboard.html"
NOTIFY_SCRIPT="./notifications/notify.sh"
```

---

## Future Enhancements

* Automatic scheduled execution using cron
* Email notifications
* Web-based dashboard
* Interactive graphs
* IP lookup history search
* Export reports to PDF
* Multi-device monitoring
* Database integration

---

## Learning Outcomes

This project demonstrates:

* Bash scripting
* Shell automation
* REST API integration
* JSON parsing using jq
* File handling
* Logging
* Conditional programming
* Modular scripting
* Report generation
* HTML and CSS integration
* Cross-platform scripting

---

## Author

**Varshini G S**

B.Tech Electrical and Electronics Engineering

Amrita Vishwa Vidyapeetham

---

## License

This project is licensed under the MIT License.
