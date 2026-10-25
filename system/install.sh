#!/bin/sh
set -e
cd "$(dirname "$0")"

sudo install -Dm644 ly/config.ini /etc/ly/config.ini
sudo install -Dm644 ly/override.conf /etc/systemd/system/ly@tty2.service.d/override.conf
sudo systemctl daemon-reload
sudo install -Dm644 ly/en.ini /etc/ly/lang/en.ini
