#!/bin/bash

PLISTBUDDY="/usr/libexec/PlistBuddy -c"
PLIST="/Library/Preferences/com.apple.TimeMachine.plist"
DATE_FORMAT_TODAY="Today, %H:%M"
DATE_FORMAT_OLD="%d %B %Y"

i=0
while true; do
  # use tmutil to get destination names
  name=$(tmutil destinationinfo | egrep "Name" -m$((i + 1)) | tail -n1 | cut -d ":" -f2 | cut -c 2-)
  dest_id_tmutil=$(tmutil destinationinfo | egrep -m$((i + 1)) -o "[0-9A-Z]{8}-[0-9A-Z]{4}-[0-9A-Z]{4}-[0-9A-Z]{4}-[0-9A-Z]{12}$" | tail -n 1)
  # use plist file to get last backup date
  date=$($PLISTBUDDY "Print Destinations:$i:SnapshotDates" "$PLIST" 2>/dev/null | tail -n 2 | head -n 1)
  dest_id_plist=$($PLISTBUDDY "Print Destinations:$i:DestinationID" "$PLIST" 2>/dev/null)
  if [ $? -ne 0 ]; then
    break
  fi
  date_notz="${date//CET /}"                                               # remove time zone as it might be wrong
  date_trimmed=$(echo "$date_notz" | xargs)                                # remove leading and trailing spaces
  date_comp=$(date -jf "%a %b %d %H:%M:%S %Y" "$date_trimmed" +"%Y-%m-%d") # make date comparable to today
  today=$(date -j +"%Y-%m-%d")
  if [[ "$date_comp" == "$today" ]]; then
    # format date (last backup was today)
    date_out=$(date -jf "%a %b %d %H:%M:%S %Y" "$date_trimmed" +"$DATE_FORMAT_TODAY")
  else
    # format date (backup was longer ago)
    date_out=$(date -jf "%a %b %d %H:%M:%S %Y" "$date_trimmed" +"$DATE_FORMAT_OLD")
  fi
  echo "$date_out ($name)"
  # check if destination id's match:
  # echo $dest_id_plist
  # echo $dest_id_tmutil
  # echo "date_trimmed: $date_trimmed"
  i=$(($i + 1))
done
