# **Docker-Based Simulated Environment**

## *Insecure Protocol Lab for Wireshark & Network Forensics*

---

## **Why This Environment Exists**

Modern systems rely heavily on encrypted communication, yet many legacy protocols (FTP, HTTP, SMTP, POP3, Telnet, DNS) still transmit sensitive information **in plaintext**.
To demonstrate how attackers intercept, analyze, and exploit these weaknesses, we need a **controlled, reproducible, isolated environment** that mirrors real-world insecure communication.

This Docker lab provides:

* Safe experimentation without virtual machines
* Fast startup and reproducible setups
* Realistic traffic for Wireshark captures
* Controlled attack simulations
* A secure sandbox for forensic analysis

---

## **What This Environment Is Used For**

### ✔ **Demonstration of insecure protocols**

* FTP logins → user/password in plaintext
* HTTP login forms → POST data visible
* SMTP emails → headers + body exposed
* DNS queries → user activity fingerprints

### ✔ **Wireshark training**

* Packet inspection
* TCP stream reconstruction
* Credential extraction
* Protocol layer analysis

### ✔ **Autopsy Forensics**

* Importing PCAP files
* Reconstructing communication flows
* Identifying suspicious or exfiltration traffic

### ✔ **Cybersecurity Awareness**

Students clearly see **why** insecure protocols must be replaced with secure alternatives like:

* SSH
* HTTPS / TLS
* SMTPS
* FTPS
* DNSSEC

---

## **Legal Safekeeping Notice**

This project is intentionally designed to expose credentials and sensitive data **only within an isolated lab environment**.

By using this environment, you agree that:

* You run it **only on your own system**
* You use it **only in isolated, non-production networks**
* You never apply these techniques outside your authorized environment
* You understand that the project is for **education and research only**

> ⚠️ **Unauthorized packet capturing or credential extraction is illegal** under Swiss law (StGB Art. 143 / 143bis) and most international jurisdictions.

This environment uses Docker containers with no external connectivity, ensuring safety.

---

## **Directory Structure**

```
Docker/
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

Each protocol runs in its own isolated container, all sharing the network:

```
forensic-net (192.168.10.0/24)
```

---

# **Quickstart**

## **1. Clone the Repository**

```bash
git clone https://github.com/Campus-Castolo/m182
cd Docker
```

---

## **2. (Optional) Create the Docker Network Manually**

Only needed if you want to ensure the network exists ahead of time:

```bash
docker network create --subnet=192.168.10.0/24 forensic-net
```

> Note: Each docker-compose file already defines this network, so this step is optional.

---

## **3. Start Each Service Individually**

Because each service has its own compose file:

### **Start FTP**

```bash
cd ftp
docker compose up -d
cd ..
```

### **Start HTTP**

```bash
cd http
docker compose up -d
cd ..
```

### **Start SMTP**

```bash
cd smtp
docker compose up -d
cd ..
```

### **Start DNS**

```bash
cd dns
docker compose up -d
cd ..
```

### **Start Client**

```bash
cd client
docker compose up -d
cd ..
```

---

## **4. Verify Running Containers**

```bash
docker ps
```

You should see:

* ftp-server
* http-server
* smtp-server
* dns-server
* forensic-client

---

## **5. Generate Traffic for Wireshark Captures**

Open a shell inside the forensic client:

```bash
docker exec -it forensic-client sh
```

### **FTP – Plaintext Credentials**

```bash
ftp 192.168.10.10
```

### **HTTP – POST Login Sniffing**

```bash
curl -d "user=test&pass=1234" http://192.168.10.20/login
```

### **SMTP – Plaintext Email**

```bash
echo -e "EHLO test\nMAIL FROM:<a@test>\nRCPT TO:<b@test>\nDATA\nHallo Welt\n.\nQUIT" \
 | nc 192.168.10.30 1025
```

### **DNS – Query Leakage**

```bash
dig @192.168.10.40 google.com
```

---

## **6. Capture Traffic with Wireshark**

### On your host machine:

1. Select the Docker network interface
2. Apply useful filters:

```
ftp
http
smtp
dns
tcp.stream eq 1
```

3. Reconstruct plaintext credentials and data transfers.

---

# **FAQ**

### ❓ Why use Docker instead of Virtual Machines?

* Faster startup
* Lower resource usage
* Cleaner isolation
* Easier version control
* Perfect reproducibility

---

### ❓ Can this harm my real network?

No — as long as:

* You keep everything in Docker
* You do not expose ports unnecessarily
* You do not bridge the containers into your LAN

---

### ❓ Does this simulate real attacks?

Yes — you will capture **real plaintext passwords**, emails, and DNS data.

This is exactly how attackers exploit insecure protocols.

---

### ❓ Can I extend this lab?

Yes! Suggestions:

* Telnet server
* POP3 server
* IMAP without TLS
* ARP spoofing with Ettercap
* Custom Python C2 channel

---

### ❓ Where should I save PCAP files?

A recommended folder:

```
/analysis/pcap/
```
