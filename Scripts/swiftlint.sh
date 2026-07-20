#!/bin/sh

set -eu

SCRIPT_DIRECTORY=$(CDPATH= cd "$(dirname "$0")" && pwd)
PROJECT_ROOT=${SRCROOT:-$(dirname "$SCRIPT_DIRECTORY")}
CONFIG_FILE=${SWIFTLINT_CONFIG_FILE:-"$PROJECT_ROOT/.swiftlint.yml"}

# Xcode does not always inherit the interactive shell's Homebrew PATH.
export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"

if [ -n "${SWIFTLINT_EXECUTABLE:-}" ]; then
    SWIFTLINT_BIN=$SWIFTLINT_EXECUTABLE
elif command -v swiftlint >/dev/null 2>&1; then
    SWIFTLINT_BIN=$(command -v swiftlint)
else
    echo "error: SwiftLint is not installed or is not available in PATH." >&2
    echo "error: Install it with 'brew install swiftlint', then rebuild." >&2
    exit 1
fi

if [ ! -x "$SWIFTLINT_BIN" ]; then
    echo "error: SwiftLint executable is not runnable: $SWIFTLINT_BIN" >&2
    exit 1
fi

if [ ! -f "$CONFIG_FILE" ]; then
    echo "error: SwiftLint configuration is missing: $CONFIG_FILE" >&2
    exit 1
fi

cd "$PROJECT_ROOT"

echo "SwiftLint $($SWIFTLINT_BIN version)"
exec "$SWIFTLINT_BIN" lint \
    --config "$CONFIG_FILE" \
    --force-exclude \
    --quiet
