#!/bin/sh
echo -ne '\033c\033]0;Simple-space-shooter\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/Simple-space-shooter.x86_64" "$@"
