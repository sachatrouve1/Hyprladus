#!/usr/bin/env bash

# This script monitors the battery status and sends notifications based on different power levels.

# Global variables
scrDir=$(dirname "$(realpath "$0")")
# shellcheck disable=SC1091
source "$scrDir/globalcontrol.sh"
dock=${BATTERY_NOTIFY_DOCK:-false}
verbose=false
last_notified_percentage=0
prev_status=""

# Default configuration values
battery_full_threshold=${BATTERY_NOTIFY_THRESHOLD_FULL:-100}
battery_critical_threshold=${BATTERY_NOTIFY_THRESHOLD_CRITICAL:-10}
# unplug_charger_threshold=${BATTERY_NOTIFY_THRESHOLD_UNPLUG:-80}
battery_low_threshold=${BATTERY_NOTIFY_THRESHOLD_LOW:-20}
timer=${BATTERY_NOTIFY_TIMER:-120}
notify=${BATTERY_NOTIFY_NOTIFY:-1140}
interval=${BATTERY_NOTIFY_INTERVAL:-5}
execute_critical=${BATTERY_NOTIFY_EXECUTE_CRITICAL:-"systemctl suspend"}
execute_low=${BATTERY_NOTIFY_EXECUTE_LOW:-}
# execute_unplug=${BATTERY_NOTIFY_EXECUTE_UNPLUG:-}
execute_charging=${BATTERY_NOTIFY_EXECUTE_CHARGING:-}
execute_discharging=${BATTERY_NOTIFY_EXECUTE_DISCHARGING:-}

# Function to display configuration information
config_info() {
    cat <<EOF

Modify variables in the script to set options.

      STATUS      THRESHOLD    INTERVAL
      Full        $battery_full_threshold          $notify Minutes
      Critical    $battery_critical_threshold           $timer Seconds then '$execute_critical'
      Low         $battery_low_threshold           $interval Percent    then '$execute_low'

      Command on Charging: $execute_charging
      Command on Discharging: $execute_discharging
      Dock Mode: $dock (Will not notify on status change) 

EOF
}

# Function to check if the system is a laptop
is_laptop() {
    if grep -q "Battery" /sys/class/power_supply/BAT*/type; then
        return 0
    else
        echo "No battery detected. If you think this is an error please post a report to the repo"
        exit 0
    fi
}

# Function to get the average battery percentage
get_battery_percentage() {
    total_percentage=0
    battery_count=0
    for battery in /sys/class/power_supply/BAT*; do
        if [ -f "$battery/capacity" ]; then
            total_percentage=$((total_percentage + $(cat "$battery/capacity")))
            battery_count=$((battery_count + 1))
        fi
    done

    if [ "$battery_count" -gt 0 ]; then
        echo "$((total_percentage / battery_count))"
    else
        echo "0"
    fi
}

# Function to get the battery status
get_battery_status() {
    for battery in /sys/class/power_supply/BAT*; do
        if [ -f "$battery/status" ]; then
            cat "$battery/status"
            return
        fi
    done
    echo "Unknown"
}

# Function to send notifications
fn_notify() {
    local urgency_level="$1"
    local icon="$2"
    local title="$3"
    local message="$4"
    notify-send -a "HyDE Power" -t 5000 -r 5 -u "$urgency_level" -i "$icon" "$title" "$message"
}

# Main logic for notifications
main() {
    is_laptop
    config_info

    while true; do
        battery_percentage=$(get_battery_percentage)
        battery_status=$(get_battery_status)

        if $verbose; then
            cat <<VERBOSE
=============================================
        Battery Status: $battery_status
        Battery Percentage: $battery_percentage
=============================================
VERBOSE
        fi

        if [[ "$battery_status" != "$prev_status" ]] || [[ "$battery_percentage" != "$last_notified_percentage" ]]; then

            if [[ "$battery_status" == "Discharging" ]]; then
                if [[ "$battery_percentage" -le "$battery_critical_threshold" ]]; then
                    fn_notify "CRITICAL" "xfce4-battery-critical" "Battery Critically Low" "$battery_percentage% is critically low. Device will execute $execute_critical soon."
                    sleep "$timer"
                    $execute_critical
                elif [[ "$battery_percentage" -le "$battery_low_threshold" ]]; then
                    fn_notify "CRITICAL" "battery-level-10-symbolic" "Battery Low" "Battery is at $battery_percentage%. Connect the charger."
                fi
            elif [[ "$battery_status" == "Charging" ]]; then
                if [[ "$battery_percentage" -ge "$battery_full_threshold" ]]; then
                    fn_notify "CRITICAL" "battery-full-charging-symbolic" "Battery Full" "Please unplug your Charger"
                # elif [[ "$battery_percentage" -ge "$unplug_charger_threshold" ]]; then
                #     fn_notify "NORMAL" "battery-080-charging" "Battery Charged" "Battery is at $battery_percentage%. You can unplug the charger"
                fi
            fi

            prev_status=$battery_status
            last_notified_percentage=$battery_percentage
        fi

        sleep 60 # Check every 60 seconds
    done
}

# Parse command-line options
case "$1" in
-i | --info)
    config_info
    exit 0
    ;;
-v | --verbose)
    verbose=true
    ;;
-h | --help)
    cat <<HELP
Usage: $0 [options]

[-i|--info]                    Display configuration information
[-v|--verbose]                 Debugging mode
[-h|--help]                 This Message
HELP
    exit 0
    ;;
esac

main
