#!/usr/bin/env bash
# SPDX-FileCopyrightText: Canonical Ltd.
# SPDX-License-Identifier: Apache-2.0

set -euo pipefail

snapcraft export-login \
  --snaps=goose \
  --channels=latest/candidate \
  --acls=package_upload,package_release \
  candidate-credentials

echo "Credentials exported to candidate-credentials"
