#!/bin/bash

# Function to log the activity
log_activity() {
    local archive_name=$1
    echo "$(date +'%Y-%m-%d %H:%M:%S') - Archived logs to $archive_name" >> archive_log.txt
}

# Check if a log directory is provided
if [ -z "$1" ]; then
    echo "Error: Log directory is required."
    echo "Usage: log-archive <log-directory>"
    exit 1
fi

# Validate the log directory
LOG_DIR="$1"
if [ ! -d "$LOG_DIR" ]; then
    echo "Error: Directory $LOG_DIR does not exist."
    exit 1
fi

# Create a new directory for storing archives if it doesn't exist
ARCHIVE_DIR="$LOG_DIR/archives"
mkdir -p "$ARCHIVE_DIR"

# Get the current timestamp
TIMESTAMP=$(date +'%Y%m%d_%H%M%S')

# Archive file name
ARCHIVE_FILE="logs_archive_$TIMESTAMP.tar.gz"

# Compress the logs using tar
echo "Compressing logs from $LOG_DIR..."
tar -czf "$ARCHIVE_DIR/$ARCHIVE_FILE" -C "$LOG_DIR" .

# Log the archive creation
log_activity "$ARCHIVE_FILE"

# Notify the user of successful archiving
echo "Logs have been successfully archived to $ARCHIVE_DIR/$ARCHIVE_FILE"
