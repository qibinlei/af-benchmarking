#!/bin/bash
# Shared EVNT runner for UC and BNL HTCondor sites.
# Requires SITE and OS to be set in the environment (passed via condor environment = "...").
# Sources config/sites/${SITE}.sh and config/oses/${OS}.sh from the repo root,
# which supply MOUNT_FLAG, JOB_CONFIG_DIR, LOG_DIR_BASE, CONTAINER_ARGS,
# ATHENA_RELEASE, OS_LOG_SUBDIR, and LHAPDF_SETUP.

BENCH_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# shellcheck disable=SC1090
source "${BENCH_DIR}/config/sites/${SITE}.sh"
# shellcheck disable=SC1090
source "${BENCH_DIR}/config/oses/${OS}.sh"
# shellcheck disable=SC1091
source "${BENCH_DIR}/parsing/utils/benchmark_utils.sh"

seed=1001
start_time=$(date -u "+%Y-%m-%dT%H:%M:%SZ")
setup_start=$(date -u "+%Y-%m-%dT%H:%M:%SZ")
export ATLAS_LOCAL_ROOT_BASE=/cvmfs/atlas.cern.ch/repo/ATLASLocalRootBase

date -u "+%Y-%m-%dT%H:%M:%SZ" >> split.log

# LHAPDF_SETUP is empty for EL9 and ends with " && " for CentOS7,
# so it injects cleanly before "asetup" with no extra spacing logic needed.
# MOUNT_FLAG is intentionally unquoted: "-m /atlasgpfs01" must split into two
# words for atlasLocalSetup.sh, and an empty value must expand to nothing.
# shellcheck disable=SC2086,SC1091
source "${ATLAS_LOCAL_ROOT_BASE}/user/atlasLocalSetup.sh" \
  -c "${CONTAINER_ARGS}" \
  ${MOUNT_FLAG} \
  -r "${LHAPDF_SETUP}asetup ${ATHENA_RELEASE},here && \
echo \"SETUP_COMPLETE=\$(date -u '+%Y-%m-%dT%H:%M:%SZ')\" >> split.log && \
/usr/bin/time -v Gen_tf.py --ecmEnergy=13000.0 --jobConfig=${JOB_CONFIG_DIR} \
  --outputEVNTFile=EVNT.root --maxEvents=1000 --randomSeed=${seed} \
  2>&1 | tee pipe_file.log && \
cat pipe_file.log >> log.generate"

setup_end=$(grep "^SETUP_COMPLETE=" split.log 2>/dev/null | tail -1 | sed 's/^SETUP_COMPLETE=//')
end_time=$(date -u "+%Y-%m-%dT%H:%M:%SZ")

if [ -n "${LOG_DIR_BASE}" ]; then
  # BNL: move logs into a dated output directory, then clean the working directory.
  output_dir="${LOG_DIR_BASE}/${OS_LOG_SUBDIR}/${start_time}"
  mkdir -p "${output_dir}"
  hostname >> split.log
  du EVNT.root >> split.log
  append_benchmark "log.generate" "${start_time}" "${end_time}" "${setup_start}" "${setup_end}"
  mv log.generate split.log pipe_file.log "${output_dir}"
  if [ -n "${JOB_CLEANUP_DIR}" ] && [ "$(pwd)" = "${JOB_CLEANUP_DIR}" ]; then
    rm -r ./*
  fi
else
  # UC: output files remain in the HTCondor working directory.
  {
    date -u "+%Y-%m-%dT%H:%M:%SZ"
    hostname
    du EVNT.root
  } >> split.log
  append_benchmark "log.generate" "${start_time}" "${end_time}" "${setup_start}" "${setup_end}"
fi
