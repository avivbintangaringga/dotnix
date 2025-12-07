#!/usr/bin/env bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# This assumes python3 is in your PATH and has the required libraries.
# If you used a virtual environment, replace `python3` with the path to its python executable.
python3 "$SCRIPT_DIR/least_busy_region.py" "$@"