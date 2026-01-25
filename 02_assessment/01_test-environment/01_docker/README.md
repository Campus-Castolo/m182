# **Docker-Based Simulated Environment**

## *Insecure Protocol Lab for Wireshark & Network Forensics*

---

## **Purpose of This Environment**

Modern IT infrastructures rely on encrypted communication, but many legacy protocols (FTP, HTTP, SMTP, POP3, Telnet, DNS) still transmit sensitive information **without encryption**.
This environment exists to safely demonstrate:

* how plaintext protocols behave
* how attackers intercept and analyze traffic
* how forensic tools reconstruct insecure communications

A controlled Docker lab allows:

* clean isolation
* reproducible network behavior
* fast deployment
* realistic traffic generation
* safe packet-capture for training and investigations

---

## **What You Can Do With This Lab**

### ✔ Demonstrate Insecure Protocols

* **FTP** → credentials in plaintext
* **HTTP** → POST login data visible
* **SMTP** → sender, receiver & message body exposed
* **DNS** → query metadata leaks user activity
* **POP3 / Telnet (optional)** → planned but not yet implemented

### ✔ Wireshark Training & Hands-On Forensics

* Inspect packets
* Reassemble TCP streams
* Extract credentials
* Identify suspicious traffic
* Build PCAP datasets for Autopsy or other forensic tools

### ✔ Cybersecurity Awareness

Shows students *why* secure replacements exist:

| Insecure | Secure      |
| -------- | ----------- |
| FTP      | FTPS / SFTP |
| HTTP     | HTTPS       |
| SMTP     | SMTPS       |
| DNS      | DNSSEC      |
| Telnet   | SSH         |

---

## **Legal & Ethical Notice**

This environment is intentionally insecure **by design** and must **only** be used:

* on systems you own
* in isolated, non-production networks
* for training, research, or internal education

> ⚠️ **Unauthorized packet sniffing, interception, or credential extraction is illegal** under Swiss law (StGB Art. 143 / 143bis) and most international jurisdictions.

All containers are restricted to an internal Docker network to ensure safety.

---

## **Repository Structure**

```
docker/
 ├── ftp/
 │    └── docker-compose.yml
 ├── http/
 │    └── docker-compose.yml
 ├── smtp/
 │    └── docker-compose.yml
 ├── dns/
 │    └── docker-compose.yml
 ├── client/
 │    └── docker-compose.yml
 ├── scripts/
 │    └── generate-traffic.sh
 ├── Makefile
 └── README.md
```

Each service is isolated into its own stack. All share the same internal network:

```
forensic-net (192.168.10.0/24)
```

> POP3 and Telnet are **planned modules** but not implemented yet.

---

# **Quickstart**

## **1. Clone the Repository**

```bash
git clone https://github.com/Campus-Castolo/m182
cd Docker
```

---

## **2. (Optional) Create the Docker Network Manually**

Each compose file defines the network automatically, but you may create it ahead of time:

```bash
docker network create --subnet=192.168.10.0/24 forensic-net
```

---

## **3. Starting Services (Makefile-Powered)**

Instead of entering each folder manually, you now use:

### ▶ Start **all** services

```bash
make up
```

### ▶ Start an individual stack

```bash
make up-ftp
make up-http
make up-smtp
make up-dns
make up-client
```

### ▶ Stop everything

```bash
make down
```

### ▶ View logs for a stack

```bash
make logs-http
```

### ▶ Rebuild all containers

```bash
make build
```

This replaces the older manual `cd <folder> && docker compose up -d` workflow.

---

## **4. Check Running Containers**

```bash
make ps
```

You should see:

* ftp-server
* http-server
* smtp-server
* dns-server
* forensic-client

POP3 and Telnet will appear later once implemented.

---

## **5. Generate Traffic (Client Side)**

Open a shell in the client container:

```bash
docker exec -it forensic-client sh
```

or use the Makefile:

```bash
make run-traffic
```

### **Example Traffic Commands**

#### FTP – Plaintext Login

```bash
ftp 192.168.10.10
```

#### HTTP – Sniffable POST Login

```bash
curl -d "user=test&pass=1234" http://192.168.10.20/login
```

#### SMTP – Plaintext Email

```bash
echo -e "EHLO test\nMAIL FROM:<a@test>\nRCPT TO:<b@test>\nDATA\nHallo Welt\n.\nQUIT" \
 | nc 192.168.10.30 1025
```

#### DNS – Metadata Leakage

```bash
dig @192.168.10.40 google.com
```

#### POP3 / Telnet

*Not yet implemented — coming soon*

---

## **6. Capture Traffic With Wireshark**

On the host:

1. Select the Docker NIC (usually `Ethernet vEthernet (Docker)` or similar)
2. Apply filters:

```
ftp
http
smtp
dns
tcp.stream eq 1
```

3. Follow streams to recover plaintext data and credentials.

---

# **FAQ**

### ❓ Why Docker instead of VMs?

* Faster
* Lightweight
* Easy to reproduce
* Versioned in git
* Safer isolation

---

### ❓ Can it harm my real network?

No — as long as:

* You keep everything inside Docker
* You do not publish external ports unnecessarily
* You do not bridge the Docker network

---

### ❓ Does this simulate real attacks?

Yes.
You will capture **real plaintext credentials**, emails, and DNS queries exactly as attackers would.

---

### ❓ Can I extend this lab?

Absolutely. Future modules may include:

* Telnet (planned)
* POP3 (planned)
* IMAP (unencrypted)
* ARP spoofing scenarios
* MITM attacks using Kali containers
* Custom malware/C2 traffic simulation

---

### ❓ Where should I save PCAPs?

Recommended folder:

```
analysis/pcap/
```
