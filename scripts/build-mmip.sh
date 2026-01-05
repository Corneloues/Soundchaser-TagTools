#!/bin/bash

addonName="Soundchaser-TagTools"
root="$(cd "$(dirname "$0")/.." && pwd)"
src="$root/src"
build="$root/build"
outFile="$build/$addonName.mmip"

# Ensure build folder exists
mkdir -p "$build"

# Remove existing build
[ -f "$outFile" ] && rm "$outFile"

# Create zip (.mmip is just a zip)
cd "$src" || exit
zip -r "$outFile" ./*

echo "Built $outFile"
