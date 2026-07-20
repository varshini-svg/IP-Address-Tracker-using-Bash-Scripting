#!/bin/bash

TITLE="$1"
MESSAGE="$2"

# Linux (notify-send)
if command -v notify-send >/dev/null 2>&1
then
    notify-send "$TITLE" "$MESSAGE"

# Windows Git Bash (PowerShell Toast)
elif command -v powershell.exe >/dev/null 2>&1
then
    powershell.exe -Command "
    Add-Type -AssemblyName PresentationFramework;
    [System.Windows.MessageBox]::Show('$MESSAGE','$TITLE')
    " >/dev/null 2>&1

# macOS
elif command -v osascript >/dev/null 2>&1
then
    osascript -e "display notification \"$MESSAGE\" with title \"$TITLE\""

# Fallback
else
    echo "$TITLE : $MESSAGE"
fi