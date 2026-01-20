#!/bin/sh
set -eu

FTP_HOST="192.168.10.10"
HTTP_HOST="192.168.10.20"
SMTP_HOST="192.168.10.30"
DNS_HOST="192.168.10.40"

if [ -t 1 ]; then
  C_RESET="$(printf '\033[0m')"
  C_BLUE="$(printf '\033[34m')"
  C_GREEN="$(printf '\033[32m')"
  C_YELLOW="$(printf '\033[33m')"
else
  C_RESET=""
  C_BLUE=""
  C_GREEN=""
  C_YELLOW=""
fi

section() {
  printf "%s==> %s%s\n" "$C_BLUE" "$1" "$C_RESET"
}

ok() {
  printf "%s%s%s\n" "$C_GREEN" "$1" "$C_RESET"
}

note() {
  printf "%s%s%s\n" "$C_YELLOW" "$1" "$C_RESET"
}

section "FTP login + file transfer"
FTP_TMP="/tmp/ftp-upload.txt"
printf "forensic ftp upload %s\n" "$(date -u +%Y-%m-%dT%H:%M:%SZ)" > "$FTP_TMP"
note "Uploading $FTP_TMP to ftp://${FTP_HOST}/upload.txt (user: testuser)"
lftp -e "set ftp:ssl-allow no; set net:timeout 10; set net:max-retries 1; open -u testuser,testpass ${FTP_HOST}; put ${FTP_TMP} -o upload.txt; ls; bye"
ok "FTP transfer complete"

section "HTTP POST login request"
note "POST http://${HTTP_HOST}/login with user=test&pass=1234"
HTTP_STATUS="$(curl -s -o /dev/null -w "%{http_code}" -d "user=test&pass=1234" "http://${HTTP_HOST}/login")"
ok "HTTP response code: ${HTTP_STATUS}"

section "SMTP plaintext email"
note "Sending email to ${SMTP_HOST}:1025"
cat <<EOF | nc -w 5 "${SMTP_HOST}" 1025 >/dev/null
EHLO lab.local
MAIL FROM:<alice@lab.local>
RCPT TO:<bob@lab.local>
DATA
Subject: Forensic SMTP Test

Hello from plaintext SMTP.
.
QUIT
EOF
ok "SMTP message sent"

section "DNS queries"
note "Querying ${DNS_HOST} for google.com and lab records"
dig @"${DNS_HOST}" google.com +short
dig @"${DNS_HOST}" ftp.lab.local +short
dig @"${DNS_HOST}" smtp.lab.local +short
ok "DNS queries complete"
