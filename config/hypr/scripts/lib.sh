#!/usr/bin/env bash
# Shared helpers for the Hyprland scripts (self-contained, no external deps).

_writeLog() {
    echo ":: $1"
}

# notify_user --a APP --i ICON --s SUMMARY --m MESSAGE [--t TIMEOUT] [--u URGENCY]
notify_user() {
    local icon="notifications-symbolic"
    local urgency="low"
    local time=""
    local app=""
    local summary=""
    local message=""
    local extra=()

    while [[ $# -gt 0 ]]; do
        case "$1" in
        --icon | --i | -i) icon="$2"; shift 2 ;;
        --urgency | --u | -u) urgency="$2"; shift 2 ;;
        --app | --a | -a) app="$2"; shift 2 ;;
        --time | --t | -t) time="$2"; shift 2 ;;
        --summary | --s | -s) summary="$2"; shift 2 ;;
        --message | --m | -m) message="$2"; shift 2 ;;
        --extra | --e | -e)
            read -r -a extra <<<"$2"
            shift 2
            ;;
        *)
            echo "notify_user: unknown option: $1" >&2
            return 1
            ;;
        esac
    done

    if [[ -z "$summary" && -z "$app" ]]; then
        echo "notify_user: --summary or --app is required" >&2
        return 1
    fi

    [[ -z "$summary" ]] && summary="$app"
    [[ -z "$app" ]] && app="$summary"

    local args=(-u "$urgency" -i "$icon" -a "$app")
    [[ -n "$time" ]] && args+=(-t "$time")
    [[ ${#extra[@]} -gt 0 ]] && args+=("${extra[@]}")

    notify-send "${args[@]}" "$summary" "$message"
}
