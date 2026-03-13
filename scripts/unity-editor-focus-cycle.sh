#!/bin/zsh
# Raycast Script Command: Unity Editor Focus/Cycle
#
# SETUP
# 1) Save this file in your Raycast Script Commands folder, or add this folder
#    in Raycast Settings > Extensions > Script Commands.
# 2) Make it executable:
#      chmod +x "/Users/gjtiquia/scripts/unity-editor-focus-cycle.sh"
# 3) In Raycast, assign hotkey Option+9 to this command.
# 4) Grant permissions if prompted:
#    macOS Settings > Privacy & Security > Accessibility
#    Enable Raycast (and your terminal if you test manually).
#
# BEHAVIOR
# - If no Unity Editor process is running: do nothing.
# - If one Unity Editor is running: focus it.
# - If multiple Unity Editors are running: cycle to the next one.

# @raycast.schemaVersion 1
# @raycast.title Unity Editor Focus/Cycle
# @raycast.mode silent
# @raycast.packageName Custom Scripts

set -u

# Collect running Unity Editor PIDs ("Unity Hub" is excluded by exact-name match)
pids=("${(@f)$(pgrep -x Unity | sort -n)}")

# 0 editors -> do nothing
if (( ${#pids[@]} == 0 )); then
  exit 0
fi

# Determine the currently frontmost Unity PID, if any
current_pid=$(osascript <<'APPLESCRIPT'
tell application "System Events"
  set frontPid to ""
  repeat with p in application processes
    if name of p is "Unity" then
      if frontmost of p is true then
        set frontPid to (unix id of p) as text
        exit repeat
      end if
    end if
  end repeat
  return frontPid
end tell
APPLESCRIPT
)

target_pid=""

if (( ${#pids[@]} == 1 )); then
  target_pid="${pids[1]}"
else
  # Multiple editors: move to next PID after current frontmost one.
  found=0
  idx=1

  for i in {1..${#pids[@]}}; do
    if [[ "${pids[$i]}" == "$current_pid" ]]; then
      found=1
      idx=$i
      break
    fi
  done

  if (( found == 1 )); then
    next=$(( idx + 1 ))
    if (( next > ${#pids[@]} )); then
      next=1
    fi
    target_pid="${pids[$next]}"
  else
    # No Unity currently frontmost: focus the first running editor.
    target_pid="${pids[1]}"
  fi
fi

# Focus chosen Unity process without launching a new editor.
osascript - "$target_pid" <<'APPLESCRIPT'
on run argv
  set targetPid to (item 1 of argv) as integer

  tell application "System Events"
    repeat with p in application processes
      try
        if (unix id of p) is targetPid then
          set frontmost of p to true
          exit repeat
        end if
      end try
    end repeat
  end tell
end run
APPLESCRIPT
