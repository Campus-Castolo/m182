# 🟥 Red-Team Report: Credential Snooping


## Purpose of This Document

**Evidence Base:** This report is based on analysis of the provided packet capture **`red-team-wireshark-dump.pcapng`**.

All observations below are derived from traffic visible in that PCAP. No credentials are reproduced verbatim; examples are described at a structural level only.

This document describes **credential snooping** activities observed in a controlled lab environment. The focus is **not** on step-by-step exploitation, but on:

* What information was exposed
* How it appeared in network traffic
* Why insecure protocols are dangerous in real environments

The goal is educational: to understand how insecure protocols leak credentials and why they must be avoided or secured.

---

## 1️⃣ Credential Snooping Overview

### What Is Credential Snooping?

Credential snooping is the act of **passively capturing authentication data** (such as usernames and passwords) as it travels across a network.

Unlike active attacks, credential snooping:

* Does **not** modify traffic
* Does **not** require direct interaction with the target system
* Relies purely on observing unencrypted network communication

If a protocol transmits credentials in plaintext, anyone with access to the network path can potentially read them.

---

### Why Insecure Protocols Enable Credential Snooping

Insecure protocols:

* Transmit data **without encryption**
* Rely on trust within the network
* Expose authentication details directly in packets

As a result:

* Credentials can be read directly from packet captures (PCAPs)
* No brute force or exploitation is required
* Even low-skilled attackers can extract sensitive data

---

## 2️⃣ Protocol-Specific Findings

The following sections describe what was observed for each protocol during lab traffic analysis.

---

### 🔴 FTP (File Transfer Protocol)

#### Exposed Data

* FTP usernames
* FTP passwords
* File and directory interaction commands

#### Appearance in Traffic (Observed in PCAP)

* Authentication exchanges containing `USER` and `PASS` commands were visible in plaintext
* Credentials appeared as readable ASCII strings in the TCP stream
* Command/response flow could be fully reconstructed from the capture

*(Reference: FTP control-channel authentication visible in `red-team-wireshark-dump.pcapng`)*

#### Why This Is Dangerous

* Captured credentials can be reused immediately
* Attackers gain authenticated access without triggering alerts
* File operations and directory structures are exposed

FTP provides **no confidentiality** and should never be used without encryption.

---

### 🔴 HTTP (Hypertext Transfer Protocol)

#### Exposed Data

* Web application usernames and passwords
* Session identifiers (cookies)
* Requested URLs and parameters

#### Appearance in Traffic (Observed in PCAP)

* HTTP `POST` requests contained login parameters in cleartext
* Request bodies were readable directly from packet payloads
* Session cookies were visible in HTTP headers

*(Reference: HTTP login request visible in `red-team-wireshark-dump.pcapng`)*

#### Why This Is Dangerous

* Enables credential theft without active exploitation
* Allows session hijacking using stolen cookies
* Exposes application behavior and internal paths

Plain HTTP exposes **both authentication and session state**.

---

### 🔴 SMTP (Simple Mail Transfer Protocol)

#### Exposed Data

* Email account usernames
* Email account passwords
* Email metadata and message content

#### Appearance in Traffic (Observed in PCAP)

* SMTP authentication sequences were visible during `AUTH` negotiation
* Base64-encoded credentials were present and trivially decodable
* Email headers and message bodies were readable

*(Reference: SMTP authentication exchange visible in `red-team-wireshark-dump.pcapng`)*

#### Why This Is Dangerous

* Compromised email accounts enable account recovery abuse
* Email content leakage violates confidentiality
* Enables impersonation and phishing

SMTP without encryption exposes **identity and communication data**.

---

### ⚠️ Optional: Telnet

#### Exposed Data

* Usernames
* Passwords
* All typed commands

#### Appearance in Traffic

* Every keystroke transmitted in plaintext
* Full session reconstruction possible

#### Why This Is Dangerous

* Complete system interaction is exposed
* Allows replay and lateral movement

Telnet offers **zero security** and is considered obsolete.

---

### ⚠️ Optional: POP3

#### Exposed Data

* Email credentials
* Mailbox contents

#### Appearance in Traffic

* USER/PASS commands visible
* Email content readable

#### Why This Is Dangerous

* Enables mailbox takeover
* Often paired with SMTP compromise

---

## 3️⃣ Attacker Perspective

### What an Attacker Learns

From sniffed traffic, an attacker can obtain:

* Valid usernames and passwords
* Session cookies
* Internal system names
* Application structure
* Email contents and metadata

This information often exceeds what is needed for initial access.

---

### How This Enables Further Attacks

Credential snooping enables:

* Account takeover
* Privilege escalation (via reused credentials)
* Lateral movement
* Social engineering and phishing
* Long-term persistence

Because the attack is passive, it is:

* Hard to detect
* Often unnoticed by defenders

---

## 4️⃣ Summary

Credential snooping demonstrates that:

* Encryption is **not optional**
* Trusting the network is dangerous
* Insecure protocols expose critical secrets

The lab findings clearly show why modern environments must enforce:

* Encrypted protocols (TLS)
* Secure authentication mechanisms
* Network segmentation

---

## 📁 References

* PCAP captures stored with lab artifacts
* Screenshots attached to assessment submission

