#!/bin/bash
set -euo pipefail
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="$(cd "${HERE}/../../.." && pwd)"

exec condor_submit \
  -append "SITE=UC" \
  -append "OS=EL9" \
  -append "JOB_CLEANUP_DIR=" \
  -append "AF_BENCH_DIR=${ROOT}" \
  -append "REQUEST_MEMORY=3GB" \
  -append "CONDOR_LOG_DIR=/home/selbor/EVNTJob/el9" \
  "${ROOT}/EVNT/evnt.sub"
