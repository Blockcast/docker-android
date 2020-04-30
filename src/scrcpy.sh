#!/bin/bash

true ${WINDOW_WIDTH:=400}
true ${WINDOW_SPACING:=50}
true ${MAX_WINDOW_SIZE:=800}

if [ -z "$REAL_DEVICE" ]; then
  echo "Container is using android emulator"
else
  echo "Starting android screen copy..."
  if [ -z "$DEVICE_SERIALS" ]; then
    /usr/local/bin/scrcpy -T
  else
    serials="$(sed 's/,\+/ /g' <<<"${DEVICE_SERIALS}")"
    port=$SCRCPY_PORT
    window_x=$WINDOW_SPACING
   for serial in ${serials}
   do
     /usr/local/bin/scrcpy --serial ${serial} --window-title ${serial} -t --window-x ${window_x} --lock-video-orientation 0 --window-width ${WINDOW_WIDTH} -m ${MAX_WINDOW_SIZE} &
      port=$((port+1))
      window_x=$((window_x+WINDOW_SPACING+WINDOW_WIDTH))
   done
   $SHELL
  fi
fi
