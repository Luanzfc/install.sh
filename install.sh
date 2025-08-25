#!/bin/sh
set -e

# tải & cài cloudflared
wget -q https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb -O /tmp/cloudflared.deb
dpkg -i /tmp/cloudflared.deb || apt-get -f install -y
rm -f /tmp/cloudflared.deb

# chạy ttyd nếu chưa có
if ! command -v ttyd >/dev/null 2>&1; then
  wget -q https://github.com/tsl0922/ttyd/releases/download/1.7.7/ttyd.x86_64 -O /usr/local/bin/ttyd
  chmod +x /usr/local/bin/ttyd
fi

# chạy web terminal
nohup ttyd bash >/dev/null 2>&1 &

# publish bằng cloudflared
cloudflared tunnel --url http://localhost:7681
