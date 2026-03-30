#!/bin/bash
# Claude Code 长任务完成通知 (>3 分钟)
start_file="/tmp/.claude_task_start"

if [ -f "$start_file" ]; then
  start=$(cat "$start_file")
  now=$(date +%s)
  elapsed=$((now - start))
  rm -f "$start_file"

  if [ $elapsed -ge 180 ]; then
    minutes=$((elapsed / 60))
    seconds=$((elapsed % 60))
    terminal-notifier -title 'Claude Code' -message "Task completed (${minutes}m${seconds}s)"
    afplay /System/Library/Sounds/Glass.aiff &
  fi
fi
