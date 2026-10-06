#!/usr/bin/env bash
# SPDX-FileCopyrightText: Canonical Ltd.
# SPDX-License-Identifier: Apache-2.0

set -euo pipefail

snapcraft export-login \
  --snaps=goose \
  --channels=latest/stable \
  --acls=package_access,package_release \
  stable-credentials

echo "Credentials exported to stable-credentials"
