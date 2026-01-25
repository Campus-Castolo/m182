# 🟥 Red-Team Report: Credential Snooping (PCAP-Based)

**Evidence PCAP:** `red-team-wireshark-dump.pcapng`

---

## 📌 Purpose and Scope

This report documents **credential snooping exposure** observed in a controlled lab network by analyzing the provided packet capture.

**Focus:** observations and outcomes (what leaked + why it matters).
**Out of scope:** step-by-step exploitation instructions.

### Redaction policy

Credentials seen in the PCAP are **not reproduced verbatim**. Where helpful for evidence, values are **masked** (e.g., `t******r`) while keeping the protocol artifacts intact (e.g., `USER`, `PASS`, `POST`).

---

## 🧾 Evidence Summary

**Capture window (local time, Europe/Zurich):** 2026-01-25 11:05:41.336695 CET → 11:05:47.021998 CET (~5.69s)
**Total frames:** 1312

**Observed insecure plaintext protocols relevant to snooping:**

* ✅ FTP (TCP/21)
* ✅ HTTP (TCP/80)
* ✅ SMTP (TCP/1025, lab mail service)

**Not present in this PCAP:** Telnet (TCP/23), POP3 (TCP/110)

---

## 1️⃣ Credential Snooping Overview

### What credential snooping is

Credential snooping is **passively observing network traffic** to capture authentication material or other sensitive data **in transit**. It requires **visibility on the network path** (e.g., same broadcast domain, SPAN/mirror port, compromised router/switch, or endpoint-level capture).

### Why insecure protocols enable it

Protocols that do not encrypt traffic (no TLS/SSH/STARTTLS):

* transmit credentials as plaintext (or weak encodings like Base64),
* expose session identifiers and application content,
* allow attackers to extract secrets **without interacting with the service**.

---

## 2️⃣ Protocol-Specific Findings (From PCAP)

> The references below use **Wireshark-style evidence pointers**: *Frame #* and *TCP stream #*.

---

### 🔴 FTP (File Transfer Protocol) — Plaintext Credentials Confirmed

**Endpoints (observed):**

* Client: `192.168.10.50:41490`
* Server: `192.168.10.10:21`
* **TCP stream:** `1`

#### Exposed data (observed)

* FTP username and password transmitted in cleartext
* File operation intent (upload/list), filenames, and directory commands

#### How it appeared in traffic (observed)

The FTP control channel contained readable ASCII commands:

* `USER <username>`
* `PASS <password>`

**Evidence (PCAP):**

* **Frame 559 (11:05:44.090665 CET)** — `USER t******r` (masked)
* **Frame 561 (11:05:44.090777 CET)** — `PASS t******s` (masked)
* **Frame 556** — server capability listing includes `AUTH TLS` (TLS available but **not used**)
* Additional operational leakage:

  * **Frame 574** — `STOR upload.txt` (file upload intent)
  * **Frame 592** — `LIST` (directory listing request)

#### Why this is dangerous

* Captured credentials can be replayed immediately for authenticated access
* Credential reuse across systems can expand impact
* File activity reveals sensitive filenames and operational behavior

**Outcome:** FTP credentials were fully recoverable from the PCAP.

---

### 🔴 HTTP (Hypertext Transfer Protocol) — Plaintext Web Login Parameters Confirmed

**Endpoints (observed):**

* Client: `192.168.10.50:40994`
* Server: `192.168.10.20:80`
* **TCP stream:** `4`

#### Exposed data (observed)

* Web login form parameters and values
* Request path and host header (application mapping)

#### How it appeared in traffic (observed)

A cleartext HTTP `POST` was visible, including form body data.

**Evidence (PCAP):**

* **Frame 611 (11:05:44.104905 CET)** — `POST /login HTTP/1.1` with:

  * `Content-Type: application/x-www-form-urlencoded`
  * body containing `user=<...>&pass=<...>`
  * masked example from PCAP: `user=t**t&pass=1**4`
* Server response identifies software/version:

  * `Server: nginx/1.29.4` (visible in response stream)

*(Note: the server returned `404 Not Found`, but the credential material was still transmitted and exposed in transit.)*

#### Why this is dangerous

* Any attacker with traffic visibility can capture login attempts and credentials
* URLs and application paths help attackers map the web surface
* Enables credential stuffing and account takeover if reused elsewhere

**Outcome:** HTTP login parameters (including password value) were readable from the PCAP.

---

### 🔴 SMTP (Simple Mail Transfer Protocol) — Plaintext Message Content Confirmed (No AUTH Observed)

**Endpoints (observed):**

* Client: `192.168.10.50:54964`
* Server: `192.168.10.30:1025` (lab mail service)
* **TCP stream:** `5`

#### Exposed data (observed)

* Email envelope metadata: sender and recipient addresses
* Email headers (e.g., Subject)
* Email body content
* Service fingerprinting via banner

#### How it appeared in traffic (observed)

SMTP commands and the message payload were readable ASCII.

**Evidence (PCAP):**

* Server banner (fingerprinting): `220 mailhog.example ESMTP MailHog` (visible in stream)
* **Frame 621 (11:05:44.107849 CET)** — `EHLO`, `MAIL FROM`, `RCPT TO`, `DATA`, and readable `Subject:` + body text
* **Frame 629 (11:05:44.108490 CET)** — server advertises `250 AUTH PLAIN`

#### Important accuracy note (for this PCAP)

* The server **advertises authentication**, but **no SMTP AUTH exchange was captured** in this trace.
* Therefore: **no SMTP username/password was observed**, but the protocol is still plaintext and exposed sensitive content.

#### Why this is dangerous

* Email content leakage can expose internal info, resets, tokens, and personal data
* If AUTH were used without encryption, credentials could leak (often Base64-encoded, not encrypted)
* Enables impersonation and targeted phishing through harvested addresses/content

**Outcome:** SMTP message content and metadata were recoverable; authentication capability was visible, but no credentials were transmitted in this capture.

---

### ⚪ Telnet / POP3 (Optional)

* **Telnet (TCP/23):** not present in `red-team-wireshark-dump.pcapng`
* **POP3 (TCP/110):** not present in `red-team-wireshark-dump.pcapng`

---

## 3️⃣ Attacker Perspective (What Can Be Learned From This PCAP)

From the observed plaintext traffic, an attacker gains:

### Immediate gains (confirmed)

* **FTP credentials** (enables direct authenticated access to FTP service)
* **HTTP login credentials** (enables account takeover attempts)
* **Email metadata + message content** (enables social engineering, intel gathering)

### Operational intelligence (confirmed)

* Service endpoints and roles:

  * FTP server: `192.168.10.10`
  * Web server: `192.168.10.20`
  * Mail service: `192.168.10.30` (port `1025`)
* Service software fingerprinting:

  * HTTP response indicates `nginx/1.29.4`
  * FTP banner indicates `Pure-FTPd` with TLS capability
  * SMTP banner indicates `MailHog`

### How this enables further attacks (conceptual, defensive framing)

* **Account takeover** using sniffed credentials
* **Lateral movement** if credentials are reused across services
* **Privilege escalation** through access to uploaded files or internal web apps
* **Phishing** fueled by harvested email addresses and message context

---

## ✅ Acceptance Criteria Checklist

* **Clear, protocol-by-protocol explanation:** ✅
* **Screenshots or references to PCAP included:** ✅ (Frame + Stream references; screenshot placeholders below)
* **No real-world attack encouragement:** ✅ (observation-only; no exploitation steps)
* **Stored under `red-team/docs/credential-snooping.md`:** ✅ (document formatted for that path)

---

## 📸 Screenshot / Evidence Placeholders (For Your Submission)

Add these as screenshots in your final hand-in:

* **Figure 1 — FTP plaintext credentials**
  Wireshark: `tcp.stream == 1` → show frames **559** (USER) and **561** (PASS)

* **Figure 2 — HTTP plaintext login POST**
  Wireshark: `tcp.stream == 4` → show **frame 611** (POST body with `user=` and `pass=`)

* **Figure 3 — SMTP plaintext email content**
  Wireshark: `tcp.stream == 5` → show **frame 621** (MAIL FROM / RCPT TO / DATA + Subject/body)

---

## 🔧 Defensive Notes (What Should Be Fixed)

* Replace FTP with **SFTP (SSH)** or enforce **FTPS** and disable plaintext login.
* Enforce **HTTPS only** (redirect HTTP→HTTPS, HSTS, remove plaintext endpoints).
* Use **SMTP with STARTTLS** and require encryption before AUTH; avoid plaintext SMTP for sensitive networks.
* Segment lab networks and monitor for plaintext credentials (DLP / IDS rules for `USER`, `PASS`, `user=`, `pass=` patterns).
