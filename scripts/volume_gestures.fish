#!/usr/bin/env fish
# Continuous volume control via 4-finger trackpad swipe.
# Reads live libinput gesture events and scrubs volume per-frame
# while the swipe is in progress (not just once per swipe).

set -l fingers 4
set -l sensitivity 0.5 # % volume change per unit of accelerated (speed-sensitive) dy
set -l device /dev/input/event8
set -l max_volume 1.5 # 1.0 = 100%, wpctl's -l flag caps absolute volume
set -l active 0
set -l pending 0 # accumulated delta not yet flushed to wpctl
set -l flush_every 5 # call wpctl once every N update events
set -l event_count 0

sudo stdbuf -oL libinput debug-events --device $device | while read -l line
    if not string match -q "*GESTURE_SWIPE*" -- $line
        continue
    end

    # Finger count is the last bare number before any dx/dy or trailing word,
    # e.g. "...+0.348s  3" or "...+0.355s  3  0.00/-0.17 (...)"
    set -l fc_match (string match -r '\+[0-9.]+s\s+(\d+)' -- $line)
    if test (count $fc_match) -lt 2
        continue
    end
    set -l this_fingers $fc_match[2]
    if test "$this_fingers" != "$fingers"
        continue
    end

    if string match -q "*GESTURE_SWIPE_BEGIN*" -- $line
        set active 1
        set pending 0
        set event_count 0
        continue
    end

    if string match -q "*GESTURE_SWIPE_END*" -- $line
        set active 0
        # Flush any remaining accumulated delta immediately on release
        if test "$pending" != 0
            set -l p $pending
            if string match -q -- "-*" "$p"
                wpctl set-volume -l $max_volume @DEFAULT_AUDIO_SINK@ (string sub -s 2 -- "$p")"%-"
            else
                wpctl set-volume -l $max_volume @DEFAULT_AUDIO_SINK@ "$p%+"
            end
            set pending 0
        end
        continue
    end

    if test $active -eq 1
        and string match -q "*GESTURE_SWIPE_UPDATE*" -- $line
        # Extract the ACCELERATED dx/dy values
        set -l matches (string match -r '(-?[0-9.]+)/\s*(-?[0-9.]+)\s*\(' -- $line)
        if test (count $matches) -ge 3
            set -l dx $matches[2]
            set -l dy $matches[3]

            # Subtract absolute dx from absolute dy. 
            # If the swipe is vertical, this yields a positive number.
            set -l diff (math "abs($dy) - abs($dx)")

            # Check if the difference does NOT start with a negative sign.
            if not string match -q -- "-*" "$diff"
                set -l this_delta (math --scale=1 "-$dy * $sensitivity")
                set pending (math --scale=1 "$pending + $this_delta")
                set event_count (math $event_count + 1)

                if test $event_count -ge $flush_every
                    set event_count 0
                    if test "$pending" != 0
                        set -l p $pending
                        if string match -q -- "-*" "$p"
                            wpctl set-volume -l $max_volume @DEFAULT_AUDIO_SINK@ (string sub -s 2 -- "$p")"%-"
                        else
                            wpctl set-volume -l $max_volume @DEFAULT_AUDIO_SINK@ "$p%+"
                        end
                        set pending 0
                    end
                end
            end
        end
    end
end
