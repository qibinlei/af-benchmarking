#!/usr/bin/env bash
# shellcheck disable=SC2034  # variables are consumed by EVNT/run_evnt.sh via source
# CentOS7 OS configuration.
# Sourced by EVNT/run_evnt.sh at job execution time.
# All variable names must match config/oses/EL9.sh.

readonly CONTAINER_ARGS="centos7"
readonly ATHENA_RELEASE="AthGeneration,23.6.31"
# Subdirectory name appended to LOG_DIR_BASE when archiving BNL job output.
readonly OS_LOG_SUBDIR="EVNT_centos7_batch"
# CentOS7's bundled LHAPDF doesn't include all needed sets; point to CVMFS copies.
# Trailing " && " is intentional: this string is injected before "asetup" in the -r block.
_LHAPDF_PATH="/cvmfs/sft.cern.ch/lcg/external/lhapdfsets/current:/cvmfs/atlas.cern.ch/repo/sw/software/23.6/sw/lcg/releases/LCG_104d_ATLAS_13/MCGenerators/lhapdf/6.5.3/x86_64-centos7-gcc11-opt/share/LHAPDF:/cvmfs/atlas.cern.ch/repo/sw/Generators/lhapdfsets/current"
readonly LHAPDF_SETUP="export LHAPATH=${_LHAPDF_PATH} && export LHAPDF_DATA_PATH=${_LHAPDF_PATH} && "
unset _LHAPDF_PATH
