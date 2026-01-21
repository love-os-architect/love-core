#!/usr/bin/env bash
set -e

# Configuration
SRC="assets/love-core.pdf.gpg"
DEST_DIR=".cache"
DEST="$DEST_DIR/love-core.pdf"

# Check for Environment Variable
if [ -z "$CORE_KEY" ]; then
    echo "Error: CORE_KEY environment variable is not set."
    echo "This system requires a valid phase key to initialize."
    exit 1
fi

# Decryption Process
mkdir -p "$DEST_DIR"
echo "Starting Phase Synchronization..."

gpg --quiet --batch --yes --passphrase "$CORE_KEY" \
    --output "$DEST" --decrypt "$SRC"

# Final Validation
if [ -f "$DEST" ]; then
    echo "[OK] Initial Condition Loaded into $DEST"
    echo "     System state: Superconducting (R=0)"
else
    echo "[FAIL] Decryption failed. Phase mismatch."
    exit 1
fi
