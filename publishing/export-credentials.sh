#!/usr/bin/env bash

set -euo pipefail

usage() {
  cat <<'EOF'
usage: export-credentials.sh [options]

Options:
  --snap-name NAME   Snap name (default: goose)
  --channel CHANNEL  Snap Store channel (default: latest/edge)
  --acls ACLS        Comma-separated ACLs (default: package_upload,package_release)
  --output FILE      Output credential file (default: derived from channel)
  -h, --help         Show this help
EOF
}

snap_name="goose"
channel="latest/edge"
acls="package_upload,package_release"
output_file=""

while [ "$#" -gt 0 ]; do
  case "$1" in
    --snap-name)
      snap_name="${2:?missing value for --snap-name}"
      shift 2
      ;;
    --channel)
      channel="${2:?missing value for --channel}"
      shift 2
      ;;
    --acls)
      acls="${2:?missing value for --acls}"
      shift 2
      ;;
    --output)
      output_file="${2:?missing value for --output}"
      shift 2
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "unknown option: $1" >&2
      usage >&2
      exit 2
      ;;
  esac
done

if [ -z "$output_file" ]; then
  safe_channel="${channel//\//-}"
  output_file="${safe_channel#latest-}-credentials"
fi

snapcraft export-login \
  --snaps="$snap_name" \
  --channels="$channel" \
  --acls="$acls" \
  "$output_file"

printf 'wrote %s for %s (%s)\n' "$output_file" "$channel" "$snap_name"
