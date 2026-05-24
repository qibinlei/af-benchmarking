#!/bin/bash
set -euo pipefail
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="$(cd "${HERE}/../../.." && pwd)"

exec condor_submit \
  -append "SITE=BNL" \
  -append "OS=EL9" \
  -append "JOB_CLEANUP_DIR=/usatlas/u/qlei/EVNT/el" \
  -append "AF_BENCH_DIR=/usatlas/u/qlei/AF-Benchmarking" \
  -append "REQUEST_MEMORY=3GB" \
  -append "CONDOR_LOG_DIR=/usatlas/u/qlei/batch_output_files/evnt/el" \
  "${ROOT}/EVNT/evnt.sub"
