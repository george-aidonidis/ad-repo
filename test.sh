#!/bin/sh
MINUTE=1000

getIcon() {
  brightness="$1"
  if [ "$brightness" -gt 75 ]; then
    icon="/usr/share/icons/Papirus/48x48/status/notification-display-brightness.svg"
  elif [ "$brightness" -gt 25 ]; then
    icon="/usr/share/icons/Papirus/48x48/status/notification-display-brightness-medium.svg"
  else
    icon="/usr/share/icons/Papirus/48x48/status/notification-display-brightness-low.svg"
  fi

  echo "$icon"
}

alert() {
  brightnessLevel=$(light -G)

  brightness=$(echo "(${brightnessLevel} + 0.5) / 1" | bc)

  bar=$(get-progress-string 10 "<b>ÔÑë  </b>" "<b>Ôáõ  </b>" "$brightnessLevel")

  icon=$(getIcon "$brightness")

  notify-send.sh -a "changeBrightness" "$brightness" --icon="$icon" --replace-file=/tmp/brightnessnotification "$bar" -t "$MINUTE"
}

case "$1" in
  --decrease)
    light -U 10
    alert
    ;;
  --increase)
    light -A 10
    alert
    ;;
  *)
    echo "Wrong argument"
    ;;
esac

