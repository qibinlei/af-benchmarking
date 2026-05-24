#!/usr/bin/env bash
# shellcheck disable=SC2034  # variables are consumed by EVNT/run_evnt.sh via source
# EL9 (Alma9) OS configuration.
# Sourced by EVNT/run_evnt.sh at job execution time.
# All variable names must match config/oses/CentOS7.sh.

readonly CONTAINER_ARGS="el9"
readonly ATHENA_RELEASE="AthGeneration,23.6.34"
# Subdirectory name appended to LOG_DIR_BASE when archiving BNL job output.
readonly OS_LOG_SUBDIR="EVNT_el9_batch"
# EL9 ships with a compatible LHAPDF; no extra exports needed.
readonly LHAPDF_SETUP=""
