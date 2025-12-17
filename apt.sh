#!/usr/bin/env bash
set -e

echo "Installing APT applications..."

sudo apt install -y \
  curl \
  wget \
  gnupg \
  build-essential \
  git \
  unrar \
  unzip \
  zip \
  ca-certificates \
  software-properties-common

# ------------------------------
# Core apps
# ------------------------------
for pkg in mpv gnome-shell-pomodoro; do
  if ! dpkg -s "$pkg" >/dev/null 2>&1; then
    sudo apt install -y $APT_FLAGS "$pkg"
  fi
done

# ------------------------------
# qBittorrent PPA
# ------------------------------
if ! grep -Rq "qbittorrent-team/qbittorrent-stable" /etc/apt/sources.list.d; then
  sudo add-apt-repository -y ppa:qbittorrent-team/qbittorrent-stable
fi

# ------------------------------
# YACReader (OBS)
# ------------------------------
YAC_LIST="/etc/apt/sources.list.d/home_selmf.list"
YAC_KEY="/etc/apt/trusted.gpg.d/home_selmf.gpg"

if [ ! -f "$YAC_LIST" ]; then
  echo "deb http://download.opensuse.org/repositories/home:/selmf/xUbuntu_24.04/ /" \
    | sudo tee "$YAC_LIST"
fi

if [ ! -f "$YAC_KEY" ]; then
  curl -fsSL https://download.opensuse.org/repositories/home:selmf/xUbuntu_24.04/Release.key \
    | gpg --dearmor | sudo tee "$YAC_KEY" > /dev/null
fi

# ------------------------------
# Browsers
# ------------------------------

# Chrome
if ! command -v google-chrome >/dev/null; then
  wget -qO- https://dl.google.com/linux/linux_signing_key.pub \
    | sudo gpg --dearmor -o /usr/share/keyrings/google-chrome.gpg
  echo "deb [signed-by=/usr/share/keyrings/google-chrome.gpg] https://dl.google.com/linux/chrome/deb/ stable main" \
    | sudo tee /etc/apt/sources.list.d/google-chrome.list
fi

# Brave
if ! command -v brave-browser >/dev/null; then
  curl -fsSL https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg \
    | sudo tee /usr/share/keyrings/brave-browser.gpg > /dev/null
  echo "deb [signed-by=/usr/share/keyrings/brave-browser.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" \
    | sudo tee /etc/apt/sources.list.d/brave-browser.list
fi

# ------------------------------
# Final install
# ------------------------------
sudo apt update

sudo apt install $APT_FLAGS \
  qbittorrent \
  yacreader \
  google-chrome-stable \
  brave-browser

echo "APT installation completed."
