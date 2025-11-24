#!/bin/bash
# AUTO-FIX ENGINE - SELF-HEALING SYSTEM

echo "🔧 ACTIVATING AUTO-FIX ENGINE..."

# Fix permissions
chmod +x *.sh
chmod 755 config/ logs/ templates/

# Install missing dependencies
sudo apt update
sudo apt install -y php curl wget sqlite3 qrencode

# Install cloudflared
if ! command -v cloudflared &> /dev/null; then
    wget -q https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 -O /tmp/cloudflared
    chmod +x /tmp/cloudflared
    sudo mv /tmp/cloudflared /usr/local/bin/
fi

# Install ngrok
if ! command -v ngrok &> /dev/null; then
    wget -q https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz -O /tmp/ngrok.tgz
    tar -xzf /tmp/ngrok.tgz -C /tmp/
    sudo mv /tmp/ngrok /usr/local/bin/
fi

echo "✅ AUTO-FIX COMPLETE"
