#!/usr/bin/env bash

PROGNAME="mybackup"
SHORTDESCRIPTION="Perform incremental backups."
PROGVERSION=

SOURCE_DIR="$HOME/"
BACKUP_DIR="/media/mskocic/MSKOCIC_1TB/milan_backup/home/mskocic/"
DATETIME="$(date '+%Y-%m-%d_%H:%M:%S')"
BACKUP_PATH="${BACKUP_DIR}/${DATETIME}"
LATEST_LINK="${BACKUP_DIR}/latest"
EXCLUDE=""


main () {
    rsync -aruh --delete --info=progress2 "${SOURCE_DIR}/" --link-dest "${LATEST_LINK}" --exclude=$EXCLUDE "${BACKUP_PATH}"
    rm -rf "${LATEST_LINK}"
    ln -s "${BACKUP_PATH}" "${LATEST_LINK}"
}

if [[ ! -d $SOURCE_DIR ]]; then echo "Source dir $SOURCE_DIR does not exist."; exit 1; fi
if [[ ! -d $BACKUP_DIR ]]; then echo "Backup dir $BACKUP_DIR does not exist."; exit 1; fi

main
