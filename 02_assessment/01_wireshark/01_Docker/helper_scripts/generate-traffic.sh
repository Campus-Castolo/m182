#!/bin/sh

# ===============================
#  Traffic Generator Script
#  For Docker Network Forensics Lab
# ===============================

echo ">>> Starting simulated attack traffic..."
sleep 1

# FTP Test
echo "\n[FTP] Testing plaintext FTP login..."
ftp -inv 192.168.10.10 <<EOF
user testuser testpass
ls
quit
EOF
echo "[FTP] Done."

# HTTP Test
echo "\n[HTTP] Sending insecure POST login..."
curl -s -X POST -d "user=test&pass=1234" http://192.168.10.20/login
echo "\n[HTTP] Done."

# SMTP Test
echo "\n[SMTP] Sending plaintext email..."
{
echo "EHLO test"
echo "MAIL FROM:<a@test>"
echo "RCPT TO:<b@test>"
echo "DATA"
echo "This is a plaintext email from the forensic client."
echo "."
echo "QUIT"
} | nc 192.168.10.30 1025
echo "[SMTP] Done."

# DNS Test
echo "\n[DNS] Performing DNS queries..."
dig @192.168.10.40 google.com > /dev/null
dig @192.168.10.40 test.local > /dev/null
echo "[DNS] Done."

echo "\n>>> Traffic generation complete."
