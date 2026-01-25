# Red Team

> 📁 **Related content**
> - [Attack scripts](./01_attack-scripts/)
> - [Test cases](./02_docs/Attack-test-cases.md)
> - [PCAP captures](./03_pcap/)

## Table of Contents
- [Red Team](#red-team)
  - [Table of Contents](#table-of-contents)
  - [Overview](#overview)
  - [Objectives](#objectives)
  - [Scope](#scope)
  - [Folder Structure](#folder-structure)
  - [Quick Start](#quick-start)
  - [Artifacts \& Evidence](#artifacts--evidence)
  - [Safety \& Legal Notice](#safety--legal-notice)

---

## Overview

This directory contains the **Red Team** portion of the security assessment.
Its purpose is to simulate realistic, low-effort attacker activity against
**insecure network protocols**, allowing credential exposure and sensitive
data leakage to be captured and analyzed using tools such as **Wireshark**
and **Autopsy**.

All actions are executed **exclusively within an isolated lab environment**
and are designed to reflect common misconfigurations rather than advanced
exploitation techniques.

---

## Objectives

- Demonstrate how insecure protocols expose sensitive information
- Generate realistic attack traffic for forensic analysis
- Provide reproducible evidence for Blue Team validation
- Support learning and documentation of defensive mitigation strategies

---

## Scope

**In scope**
- Passive or low-interaction attacker model
- Network sniffing and basic spoofing
- Insecure protocol analysis:
  - FTP
  - HTTP
  - SMTP
  - DNS

**Out of scope**
- Attacks against real or production systems
- Denial-of-Service (DoS) attacks
- OS-level exploitation or privilege escalation
- Destructive or persistent attacks

---

## Folder Structure

```

02_red-team/
├── 01_attack-scripts/   # Automation to generate attack traffic
├── 02_docs/             # Test cases, methodology, and expected outcomes
└── pcap/                # Captured network traffic for analysis

````

---

## Quick Start

1. Ensure the secure lab environment is running.
2. Execute the attack traffic generator:

```sh
cd 02_assessment/02_red-team
sh ./01_attack-scripts/attack-vectors.sh
````

> ⚠️ If your lab uses different IP addresses or hostnames, update the
> `DNS_HOST` and `SMTP_HOST` variables inside
> `01_attack-scripts/attack-vectors.sh` before execution.

---

## Artifacts & Evidence

* **Test cases & methodology**
  `02_docs/Attack-test-cases.md`

* **Captured network traffic**
  `pcap/red-team-wireshark-dump.pcapng`

These artifacts are used by the Blue Team to validate detections,
assess mitigation effectiveness, and document findings.

---

## Safety & Legal Notice

The scripts and techniques in this directory are intended **strictly for
educational use in controlled lab environments**.

Do **not** run these tools on networks or systems you do not own or have
explicit authorization to test. Unauthorized use may be illegal and unethical.
