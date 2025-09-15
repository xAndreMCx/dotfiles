#!/usr/bin/fish
set PID_FILE ~/.config/hypr/.ctrl_left_click_spam.pid

# Ensure ydotoold is running
if not pgrep -x ydotoold >/dev/null
    ydotoold &
    sleep 0.5  # Wait for daemon to initialize
end

# Check if spamming is running
if test -f "$PID_FILE" -a (ps -p (cat $PID_FILE) >/dev/null 2>&1; echo $status) -eq 0
    # Stop spamming
    kill (cat $PID_FILE) >/dev/null 2>&1
    ydotool key 29:0  # Release Ctrl key
    rm -f $PID_FILE
else
    # Start spamming in background
    begin
        ydotool key 29:1  # Hold Ctrl down
        while true
            ydotool m:1   # Left click
            sleep 0.02    # ~50 clicks/sec; adjust for speed (lower = faster)
        end
    end &
    set pid $last_pid
    if test -n "$pid"
        echo $pid > $PID_FILE  # Save PID
    else
        echo "Error: Failed to get PID of background process" >&2
        exit 1
    end
end
