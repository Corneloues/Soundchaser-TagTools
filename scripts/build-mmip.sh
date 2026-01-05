#!/bin/bash
# build-mmip.sh
# Build MediaMonkey Addon (.mmip) - macOS/Linux

# -------------------------
# CONFIG
# -------------------------
addonName="Soundchaser-TagTools"
version="1.0.0"   # Internal use
root="$(cd "$(dirname "$0")/.." && pwd)"
src="$root/src"
build="$root/build"
outFile="$build/$addonName.mmip"   # Fixed filename

# -------------------------
# PREPARE BUILD FOLDER
# -------------------------
mkdir -p "$build"

# Remove previous build
[ -f "$outFile" ] && rm "$outFile"

# -------------------------
# CREATE ZIP (.mmip)
# -------------------------
cd "$src" || exit
zip -r "$outFile" ./*

echo "✅ Built $outFile"
