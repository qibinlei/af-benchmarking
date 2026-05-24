#!/usr/bin/env bash
# shellcheck disable=SC2034  # variables are consumed by EVNT/run_evnt.sh via source
# UC Analysis Facility site configuration.
# Sourced by EVNT/run_evnt.sh at job execution time.
# All variable names must match config/sites/BNL.sh.

readonly MOUNT_FLAG=""
# JOB_CONFIG_DIR uses GITHUB_WORKSPACE, which is set by the UC CI/cluster environment.
readonly JOB_CONFIG_DIR="${GITHUB_WORKSPACE}/EVNT/EVNTFiles/100xxx/100001"
# Empty LOG_DIR_BASE: UC jobs leave output files in the HTCondor working directory.
readonly LOG_DIR_BASE=""
