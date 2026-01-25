#!/bin/sh
set -eu

FTP_HOST="192.168.10.10"
HTTP_HOST="192.168.10.20"
SMTP_HOST="192.168.10.30"
DNS_HOST="192.168.10.40"

section() { printf "\n=== %s ===\n" "$1"; }

# --- sanity checks ---------------------------------------------------------

need_cmd() {
  if ! command -v "$1" >/dev/null 2>&1; then
    echo "[-] Required command '$1' not found in PATH" >&2
    exit 1
  fi
}

need_cmd lftp
need_cmd curl
need_cmd dig
need_cmd nc
need_cmd date

# --- FTP -------------------------------------------------------------------

section "FTP login + file transfer"
FTP_TMP="/tmp/ftp-upload.txt"
printf "forensic ftp upload %s\n" "$(date -u +%Y-%m-%dT%H:%M:%SZ)" > "$FTP_TMP"

# lftp can still error if the server is not ready, but we don't want to abort the script
lftp -e "
  set ftp:ssl-allow no;
  set net:timeout 10;
  set net:max-retries 1;
  open -u testuser,testpass ${FTP_HOST};
  put ${FTP_TMP} -o upload.txt;
  ls;
  bye
" || echo "[!] FTP step failed (check server or network)"

# --- HTTP ------------------------------------------------------------------

section "HTTP POST login request"
# verbose request for nicer payload in Wireshark; ignore HTTP error codes
curl -v -d "user=test&pass=1234" "http://${HTTP_HOST}/login" \
  >/dev/null 2>&1 || echo "[!] HTTP step failed (server may be down or returning error)"

# --- SMTP ------------------------------------------------------------------

section "SMTP plaintext email"
# Use nc with a timeout so it can't hang forever
{
  printf 'EHLO forensic.local\r\n'
  printf 'MAIL FROM:<alice@forensic.local>\r\n'
  printf 'RCPT TO:<bob@forensic.local>\r\n'
  printf 'DATA\r\n'
  printf 'Subject: Forensic SMTP Test\r\n'
  printf '\r\n'
  printf 'Hello from plaintext SMTP for packet capture demo.\r\n'
  printf '.\r\n'
  printf 'QUIT\r\n'
} | nc -w 5 "${SMTP_HOST}" 1025 >/dev/null 2>&1 \
  || echo "[!] SMTP step failed (Mailhog not reachable?)"

# --- DNS -------------------------------------------------------------------

section "DNS Queries"
dig @"${DNS_HOST}" google.com +short \
  || echo "[!] DNS query for google.com failed"
dig @"${DNS_HOST}" ftp.lab.local +short \
  || echo "[!] DNS query for ftp.lab.local failed"
dig @"${DNS_HOST}" smtp.lab.local +short \
  || echo "[!] DNS query for smtp.lab.local failed"

echo
echo "Done generating traffic."

# ftp || ftp-data || http || dns || smtp || tcp.port == 1025
