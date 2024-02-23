#!/bin/bash
#
# This script offers provides the ability to update the
# Legacy Boot payload, set boot options, and install
# a custom coreboot firmware for supported
# ChromeOS devices
#
# Created by Mr.Chromebox <mrchromebox@gmail.com>
#
# May be freely distributed and modified as needed,
# as long as proper attribution is given.
#

# where the stuff is
# Specify the directory where you've placed the backup files
local_files_directory="/mnt/chromeos/MyFiles/Downloads"

# ensure output of system tools in en-us for parsing
export LC_ALL=C

# set working dir
if grep -q "Chrom" /etc/lsb-release ; then
    # needed for ChromeOS/ChromiumOS v82+
    mkdir -p /usr/local/bin
    cd /usr/local/bin
else
    cd /tmp
fi

# clear screen / show banner
printf "\ec"
echo -e "\nMrChromebox Firmware Utility Script starting up"

# check for cmd line param, expired CrOS certs
if ! curl -sLo /dev/null https://mrchromebox.tech/index.html || [[ "$1" = "-k" ]]; then
    export CURL="curl -k"
else
    export CURL="curl"
fi

# set working dir
cd /tmp

# do setup stuff
prelim_setup || exit 1

# source local files instead of downloading
source "$local_files_directory/firmware.sh"
source "$local_files_directory/functions.sh"
source "$local_files_directory/sources.sh"

# show menu
menu_fwupdate
