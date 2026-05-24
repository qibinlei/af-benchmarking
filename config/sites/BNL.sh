#!/usr/bin/env bash
# shellcheck disable=SC2034  # variables are consumed by EVNT/run_evnt.sh via source
# BNL Analysis Facility site configuration.
# Sourced by EVNT/run_evnt.sh at job execution time.
# All variable names must match config/sites/UC.sh.

readonly MOUNT_FLAG="-m /atlasgpfs01"
readonly JOB_CONFIG_DIR="/atlasgpfs01/usatlas/data/qlei/EVNTJob/100xxx/100001"
# BNL jobs move output logs into a dated subdirectory under LOG_DIR_BASE.
readonly LOG_DIR_BASE="/atlasgpfs01/usatlas/data/qlei/logs"
