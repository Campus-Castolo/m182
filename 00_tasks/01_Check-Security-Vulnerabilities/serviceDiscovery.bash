#!/bin/bash
TARGET=172.16.17.3
echo "[*] Running Service Discovery Scan on $TARGET ..."
nmap -sV $TARGET
echo "[*] Service Discovery Scan completed."