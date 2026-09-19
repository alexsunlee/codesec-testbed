#!/usr/bin/env bash
# Secrets fixture. Every value here is FABRICATED - each one contains the
# literal string CODESECTESTBED so it can never be confused with a real
# credential - but the FORMAT is valid, which is what a detector matches on.
set -euo pipefail

export AWS_ACCESS_KEY_ID="AKIACODESECTESTBED00"
export AWS_SECRET_ACCESS_KEY="wJalrXUtnFEMICODESECTESTBEDbPxRfiCYEXAMP"
export AWS_DEFAULT_REGION="us-west-2"

aws s3 sync ./dist "s3://codesec-testbed-artifacts/$(git rev-parse --short HEAD)"
