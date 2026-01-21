#!/usr/bin/env bash
set -e

# Config
SRC="assets/love-core.pdf.gpg"
DEST_DIR=".cache"
DEST="$DEST_DIR/love-core.pdf"

# Check Key
if [ -z "$CORE_KEY" ]; then
    echo "Error: CORE_KEY environment variable is not set."
    echo "This repository requires a phase key to initialize."
    exit 1
fi

# Decrypt
mkdir -p "$DEST_DIR"
echo "Initializing Phase Synchronization..."

gpg --quiet --batch --yes --passphrase "$CORE_KEY" \
    --output "$DEST" --decrypt "$SRC"

if [ -f "$DEST" ]; then
    echo "[OK] Initial Condition Loaded. ($DEST)"
    echo "    Ready for R=0 State."
else
    echo "[FAIL] Decryption failed."
    exit 1
fi
