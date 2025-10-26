#!/usr/bin/env bash

# Perform incremental backups

SOURCE_DIR="$HOME/"
BACKUP_DIR="/media/mskocic/data/backups"
DATETIME="$(date '+%Y-%m-%d_%H:%M:%S')"
BACKUP_PATH="${BACKUP_DIR}/${DATETIME}"
LATEST_LINK="${BACKUP_DIR}/latest"

if [[ ! -d $SOURCE_DIR ]]; then echo "Source dir $SOURCE_DIR does not exist."; exit 1; fi
if [[ ! -d $BACKUP_DIR ]]; then echo "Backup dir $BACKUP_DIR does not exist."; exit 1; fi


rsync -aruh --delete --info=progress2 "${SOURCE_DIR}/" --link-dest "${LATEST_LINK}" --exclude=".cache" "${BACKUP_PATH}"

rm -rf "${LATEST_LINK}"
ln -s "${BACKUP_PATH}" "${LATEST_LINK}"
