#!/bin/zsh --no-rcs
# Extension Attribute: Intel Only Apps (x86_64 only, no Universal)
# v1.0
# Copyright (c) 2026 Omer Ninyo, Wediggit Ltd.
# Released under the MIT License.
# Purpose: identifies Intel-only apps to support cleanup and readiness efforts
# before Intel support is removed in macOS 27 and Rosetta translation support is removed in macOS 28.
# Please keep this notice if you reuse or modify this script.

intelApps=""

# Scan Applications folder only
while read -r appPath; do
    # Check if MacOS folder exists with binary
    if [[ -d "$appPath/Contents/MacOS/" ]]; then
        # Check architecture precisely
        binaryInfo=$(/usr/bin/file "$appPath/Contents/MacOS/"* 2>/dev/null | head -1)
        
        # Intel-only: x86_64 executable WITHOUT universal/arm64
        if echo "$binaryInfo" | grep -q "x86_64.*executable" && \
           echo "$binaryInfo" | grep -vq "universal\|arm64"; then
            
            appName=$(basename "$appPath" .app)
            intelApps="${intelApps}${appName}, "
        fi
    fi
done < <(/usr/bin/mdfind 'kMDItemKind == "Application" && kMDItemFSName == "*.app"')

# Remove trailing comma
result=$(echo "$intelApps" | sed 's/, $//' | sed 's/^$//')

if [[ -z "$result" ]]; then
    echo "<result>No Intel-only apps</result>"
else
    echo "<result>$result</result>"
fi
#!/bin/zsh --no-rcs
# Extension Attribute: Intel Only Apps (x86_64 only, no Universal)
# Detects ONLY Intel-only applications in practice
# v1.0
# Copyright (c) 2026 Omer Ninyo, Wediggit Ltd.
# Released under the MIT License.
# Please keep this notice if you reuse or modify this script.
intelApps=""

# Scan Applications folder only
while read -r appPath; do
    # Check if MacOS folder exists with binary
    if [[ -d "$appPath/Contents/MacOS/" ]]; then
        # Check architecture precisely
        binaryInfo=$(/usr/bin/file "$appPath/Contents/MacOS/"* 2>/dev/null | head -1)
        
        # Intel-only: x86_64 executable WITHOUT universal/arm64
        if echo "$binaryInfo" | grep -q "x86_64.*executable" && \
           echo "$binaryInfo" | grep -vq "universal\|arm64"; then
            
            appName=$(basename "$appPath" .app)
            intelApps="${intelApps}${appName}, "
        fi
    fi
done < <(/usr/bin/mdfind 'kMDItemKind == "Application" && kMDItemFSName == "*.app"')

# Remove trailing comma
result=$(echo "$intelApps" | sed 's/, $//' | sed 's/^$//')

if [[ -z "$result" ]]; then
    echo "<result>No Intel-only apps</result>"
else
    echo "<result>$result</result>"
fi
