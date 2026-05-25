#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/.."

if ! command -v aws >/dev/null 2>&1; then
  echo "Missing AWS CLI v2. Install with: brew install awscli" >&2
  exit 1
fi

mkdir -p "$HOME/.aws"
if [[ ! -f "$HOME/.aws/config" ]]; then
  cp aws/config.example "$HOME/.aws/config"
  chmod 600 "$HOME/.aws/config"
  echo "✓ installed AWS config template to ~/.aws/config"
  echo "Now edit placeholders and run: aws configure sso --profile joel"
else
  echo "✓ ~/.aws/config exists; leaving it untouched"
fi

if [[ -f "$HOME/.aws/credentials" ]]; then
  echo "⚠ ~/.aws/credentials exists. Keep it private and never commit it. Prefer SSO profiles."
fi

aws --version
