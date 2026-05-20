#!/bin/bash

# ==============================================================================
# 1. USER INPUT PROMPT
# ==============================================================================
echo "=================================================="
echo "🤖 Antigravity CLI & Last30Days Automation Assistant"
echo "=================================================="
read -p "Enter the search topic: " TOPIC_NAME

# Verify that the input is not empty
if [ -z "$TOPIC_NAME" ]; then
    echo "❌ Error: Topic cannot be empty."
    exit 1
fi

# ==============================================================================
# 2. REGEX APPLICATION / FILE NAMING LOGIC
# ==============================================================================
# - Trim spaces from start and end
TOPIC_TRIMMED=$(echo "$TOPIC_NAME" | xargs)

# - Convert string to lowercase
TOPIC_LOWER=$(echo "$TOPIC_TRIMMED" | tr '[:upper:]' '[:lower:]')

# - Replace all spaces with dashes "-"
TOPIC_DASHED=$(echo "$TOPIC_LOWER" | tr ' ' '-')

# - Define the expected final filename
FILE_NAME="${TOPIC_DASHED}-raw-v3.md"

# ==============================================================================
# PATH CONFIGURATION (TO BE MODIFIED BY THE USER)
# ==============================================================================
# ⚠️ IMPORTANT: You MUST modify these two paths to match your system configuration.
# - ANTIGRAVITY_DIR: The temporary directory where the Antigravity CLI agent writes the file.
# - TARGET_DIR: The final directory where you want to move and keep your reports.

ANTIGRAVITY_DIR="/path/to/your/source/directory/last30days" # e.g., "$HOME/.gemini/tmp/your_username/last30days"
TARGET_DIR="/path/to/your/destination/directory/Last30Days" # e.g., "$HOME/Documents/Last30Days"

# Safety validation to ensure paths have been personalized
if [[ "$ANTIGRAVITY_DIR" == *"/path/to/your"* || "$TARGET_DIR" == *"/path/to/your"* ]]; then
    echo "❌ Error: You must configure your paths in the script before running it."
    echo "Open this file and modify the ANTIGRAVITY_DIR and TARGET_DIR variables."
    exit 1
fi
# ==============================================================================

SRC_PATH="${ANTIGRAVITY_DIR}/${FILE_NAME}"
TARGET_PATH="${TARGET_DIR}/${FILE_NAME}"

# Ensure directories exist
mkdir -p "$TARGET_DIR"

echo "🎯 Expected target file: $FILE_NAME"
echo "--------------------------------------------------"

# ==============================================================================
# 3. SAFETY LOOP (WHILE - MAX 10 ATTEMPTS)
# ==============================================================================
MAX_ATTEMPTS=10
attempt=1
success=false

while [ $attempt -le $MAX_ATTEMPTS ] && [ "$success" = false ]; do
    echo "🔄 [Attempt $attempt/$MAX_ATTEMPTS] Initializing session..."

    # Delete any lingering old files to avoid false positives
    rm -f "$SRC_PATH"
    rm -f "$TARGET_PATH"

    # Step 3.1: Launch Antigravity in a NEW separate terminal in YOLO mode
    osascript -e 'tell application "Terminal" to do script "agy --approval-mode=yolo"'
    
    # Wait 15 seconds for the Antigravity> prompt to load
    sleep 15

    echo "⌨️ Injecting command into the Antigravity window..."
    
    # Step 3.2: Run AppleScript to focus and write the prompt
    osascript -e "
    tell application \"Terminal\"
        activate
        set agyWindow to first window whose name contains \"Antigravity\" or name contains \"agy\" or name contains \"python\"
        set index of agyWindow to 1
    end tell
    delay 0.3
    tell application \"System Events\"
        keystroke \"/last30days \\\"[COMMAND: Use your last30days tool now] $TOPIC_NAME\\\"\"
        delay 0.2
        key code 36
    end tell"

    echo "⏳ Waiting for scraping and Markdown file generation..."
    
    # Step 3.3: Dynamically monitor both directories simultaneously (180s)
    for i in {1..180}; do
        # Case 1: File appears in Antigravity's hidden temp directory
        if [ -f "$SRC_PATH" ]; then
            success=true
            sleep 2 
            mv "$SRC_PATH" "$TARGET_PATH" # Move it to destination
            break
        fi
        
        # Case 2: File appears directly in your destination directory
        if [ -f "$TARGET_PATH" ]; then
            success=true
            sleep 2
            break
        fi
        
        sleep 1
    done

    # Step 3.4: Analyze result and close Antigravity window
    if [ "$success" = true ]; then
        echo "✅ Success! The file was detected and moved to your destination directory."
        
        # Completely close the Antigravity Terminal window only
        osascript -e '
        tell application "Terminal"
            set agyWindow to first window whose name contains "Antigravity" or name contains "agy" or name contains "python"
            close agyWindow
        end tell'
    else
        echo "⚠️ The AI ignored the skill or the file was not created within 180s."
        echo "Closing the unstable window and preparing to retry..."
        
        # Force close the failed window before the next attempt
        osascript -e '
        tell application "Terminal"
            try
                set agyWindow to first window whose name contains "Antigravity" or name contains "agy" or name contains "python"
                close agyWindow
            end try
        end tell'
        
        sleep 2
        ((attempt++))
    fi
done

# ==============================================================================
# 4. FINAL CONTROLLER SCRIPT STATUS
# ==============================================================================
echo "--------------------------------------------------"
if [ "$success" = true ]; then
    echo "🎉 Operation completed successfully!"
    echo "📁 Your file is available here: $TARGET_PATH"
else
    echo "❌ Failure: The script reached the limit of 10 attempts without generating the file."
fi
echo "=================================================="