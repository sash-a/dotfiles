#!/bin/sh
input=$(cat)

# Git branch from cwd
cwd=$(echo "$input" | jq -r '.cwd // .workspace.current_dir // empty')
branch=""
if [ -n "$cwd" ]; then
  branch=$(git -C "$cwd" --no-optional-locks symbolic-ref --short HEAD 2>/dev/null)
fi

# 7-day remaining usage
seven_day_used=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')
seven_day_str=""
if [ -n "$seven_day_used" ]; then
  seven_day_remaining=$(echo "$seven_day_used" | awk '{printf "%.0f", 100 - $1}')
  seven_day_str="7d:${seven_day_remaining}% left"
fi

# 5-hour (session) remaining usage
five_hour_used=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
five_hour_str=""
if [ -n "$five_hour_used" ]; then
  five_hour_remaining=$(echo "$five_hour_used" | awk '{printf "%.0f", 100 - $1}')
  five_hour_str="5h:${five_hour_remaining}% left"
fi

# Context used percentage
ctx_used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
ctx_str=""
if [ -n "$ctx_used" ]; then
  ctx_str="ctx:$(printf "%.0f" "$ctx_used")%"
fi

# Build output parts
parts=""

if [ -n "$branch" ]; then
  parts=" $branch"
fi

if [ -n "$seven_day_str" ]; then
  if [ -n "$parts" ]; then parts="$parts   $seven_day_str"; else parts=" $seven_day_str"; fi
fi

if [ -n "$five_hour_str" ]; then
  if [ -n "$parts" ]; then parts="$parts   $five_hour_str"; else parts=" $five_hour_str"; fi
fi

if [ -n "$ctx_str" ]; then
  if [ -n "$parts" ]; then parts="$parts   $ctx_str"; else parts=" $ctx_str"; fi
fi

printf "%s" "$parts"
