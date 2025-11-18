#!/bin/bash
TARGET=172.16.17.3
OUTPUT="metasploitable_scan.xml"

echo "[*] Running Version Scan with XML export..."
nmap -sV -oX $OUTPUT $TARGET

echo "[*] XML scan saved to $OUTPUT"
echo "[*] Version Scan completed."
