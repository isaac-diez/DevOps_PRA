#!/bin/bash

# Function to log messages
log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> publish_log.txt
}

# Check if the commit message is provided
if [ -z "$1" ]; then
    echo "Please provide a commit message."
    log_message "Error: No commit message provided"
    exit 1
fi

# Start logging
log_message "Starting Quarto publishing process"

# Commit the changes with the provided message
git add .
git commit -m "$1"
if [ $? -eq 0 ]; then
    log_message "Changes committed successfully"
else
    log_message "Error: Git commit failed"
    exit 1
fi

# Push the changes to the main branch
git push origin main
if [ $? -eq 0 ]; then
    log_message "Changes pushed to remote repository"
else
    log_message "Error: Git push failed"
    exit 1
fi

# Publish to GitHub Pages using quarto
quarto publish gh-pages --no-render --no-prompt
if [ $? -eq 0 ]; then
    log_message "Quarto site published successfully"
else
    log_message "Error: Quarto publish failed"
    exit 1
fi

log_message "Quarto publishing process completed successfully"

echo "Process completed. Check publish_log.txt for details."
