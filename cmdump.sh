#!/bin/sh
#
# RTMPDump wrapper for Panasonic Content Meister
# This script allows you to download videos from Content Meister without authentication.
#

BASE_URL=rtmpt://doshisha.fmsod.stream.ne.jp/doshisha

if [ $# -ne 1 ] && [ $# -ne 2 ]; then
    echo "Usage: $0 <url> [channel]"
    exit 1
fi

RTMPDUMP=$(which rtmpdump 2> /dev/null)

if [ -z "${RTMPDUMP}" ]; then
    echo 'rtmpdump is not found in PATH, install it first. -> https://rtmpdump.mplayerhq.hu/'
    exit 1
fi

CONTENT_ID=$(echo "$1" | cut -d = -f 2)
CHANNEL=$([ $# -eq 1 ] && echo 1 || echo "$2")

rtmpdump -i "${BASE_URL}/_definst_/${CONTENT_ID}/mp4:video${CHANNEL}.mp4" --verbose --resume --flv "${CONTENT_ID}_video${CHANNEL}.mp4"
