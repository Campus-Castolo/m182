# **Network Forensics Lab – Wireshark & Autopsy (Docker Simulation)**

### *Credential Snooping in Unsafe Network Protocols*

---

## **Overview**

This project demonstrates how insecure legacy network protocols leak sensitive information such as **credentials, emails, and activity metadata**.
Using **Wireshark**, **Docker**, and **Autopsy**, you will capture and analyze network traffic, extract plaintext passwords, and perform forensic reconstruction.

Everything runs in a **fully isolated Docker-based lab environment**.

---

## **Project Goals**

* Understand how Wireshark captures and interprets network traffic
* Extract plaintext credentials from insecure protocols
* Analyze forensic artifacts using Autopsy
* Demonstrate risks of legacy protocols
* Provide mitigation recommendations (TLS, FTPS, SMTPS, DNSSEC, SSH)

---

## **Simulated Docker Environment**

The lab includes insecure versions of:

* **FTP** – Plaintext USER/PASS
* **HTTP** – Unsafe login form (POST sniffing)
* **SMTP** – Plaintext emails (Port 25)
* **DNS** – Query metadata exposure
* **Telnet** *(optional bonus)* – Plaintext shell access
* **POP3** *(optional bonus)* – Plaintext mailbox access

*Docker Compose files:*
[Docker Compose Files](./01_docker/README.md)

---

## **Core Components**

### **1. Wireshark Analysis**

* Interface selection
* Capture & display filters
* TCP stream reconstruction
* Extracting credentials (FTP/HTTP/POP3/Telnet)
* Inspecting SMTP & DNS metadata

Detailed guide:
`[link-placeholder-wireshark-doc]`

---

### **2. Credential Snooping Demonstrations**

| Protocol   | What You Capture             |
| ---------- | ---------------------------- |
| **FTP**    | USER / PASS in plaintext     |
| **HTTP**   | POST login credentials       |
| **SMTP**   | Email header + body          |
| **DNS**    | Browsing patterns, hostnames |
| **Telnet** | Credentials + commands       |
| **POP3**   | Email login + mailbox access |

PCAPs stored in:
`[link-placeholder-pcaps]`

---

### **3. Autopsy Forensic Analysis**

* Import PCAP files
* Reconstruct sessions and payloads
* Identify suspicious or custom protocol traffic
* Document recovered artifacts

Report:
`[link-placeholder-autopsy-report]`

---

## **Bonus Topics (High Engagement)**

* MITM via **ARP spoofing** (Ettercap/arpspoof)
* Re-injection of network packets
* Analysis of obfuscated/custom protocol traffic
* Comparison of insecure vs secure protocol variants

---

## **Deliverables**

- [ ] Video tutorial (8–14 minutes)
- [ ] Wireshark capture files (PCAP)
- [ ] Autopsy forensic analysis report
- [ ] Documentation (Journal, Resilienz-Bezug, Quellen)
- [ ] Presentation slides

---

## **Link Placeholders**

* `[link-placeholder-compose.yml]`
* `[link-placeholder-wireshark-doc]`
* `[link-placeholder-pcaps]`
* `[link-placeholder-autopsy-report]`

---

## **Security Note**

All activities are performed **exclusively in an isolated lab environment**.
Never replicate these techniques on production systems or networks that you do not own.
