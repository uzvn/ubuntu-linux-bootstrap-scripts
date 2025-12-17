#!/usr/bin/env bash
set -e

sudo apt autoremove -y
sudo apt autoclean

echo "Cleanup completed."