#!/bin/bash
# build-mmip.sh
# Build MediaMonkey Addon (.mmip) - macOS/Linux

# -------------------------
# CONFIG
# -------------------------
addonName="Soundchaser-TagTools"
version=$(cat version.txt)
root="$(cd "$(dirname "$0")/.." && pwd)"
src="$root/src"
build="$root/build"
outFile="$build/$addonName.mmip"   # Fixed filename

# -------------------------
# GET LATEST VERSION
# -------------------------
jq --arg v "$version" '.version = $v' src/info.json > src/info.tmp.json
mv src/info.tmp.json src/info.json

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
