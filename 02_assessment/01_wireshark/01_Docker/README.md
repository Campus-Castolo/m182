# **Docker-Based Simulated Environment**

## *Insecure Protocol Lab for Wireshark & Network Forensics*

---

### **Why We Create This Environment**

Modern systems rely heavily on encrypted communication, but many legacy protocols (FTP, HTTP, SMTP, POP3, Telnet, DNS) still transmit data **in plaintext**.
To demonstrate how attackers extract sensitive information from unencrypted traffic, we need a controlled, reproducible, and isolated environment.

This Docker lab enables:

* Safe experimentation without virtual machine overhead
* Easy reproducibility
* Fast protocol switching
* Realistic traffic for Wireshark captures
* Controlled attack simulations (e.g., credential theft, packet inspection, protocol reconstruction)

---

### **What Purpose This Environment Serves**

This environment is used for:

### ** Demonstration of insecure protocols**

Real login attempts → credentials exposed
Email transmission → visible headers & bodies
DNS lookups → visible user activity patterns

### ** Wireshark practice**

* TCP stream reconstruction
* Credential extraction
* Packet-based forensic analysis

### ** Autopsy Forensics**

* Importing PCAP files
* Reconstructing communication flows
* Identifying exfiltration or suspicious traffic

### ** Education & Cybersecurity Awareness**

Students learn **why** insecure protocols must be replaced with secure alternatives like SSH, HTTPS, SMTPS, DNSSEC, FTPS.

---

### **Legal Safekeeping Notice**

This lab is intentionally designed to expose credentials and sensitive data **for educational purposes only**.

By using this environment, you agree that:

* You run it **only on your own system**
* You use it **only in isolated networks / lab setups**
* You must **never** use these techniques on real networks, production systems, or systems you do not own
* The project is strictly for **training and research**

> **Unauthorized packet capturing or credential extraction is illegal under Swiss law (StGB Art. 143 / 143bis) and most international regulations.**

This project keeps everything safe by using Docker containers with no real-world connectivity or persistence.

---

### **Directory Structure**

```
/Docker
│
├── docker-compose.yml        # Full insecure protocol lab
├── ftp/                      # FTP server & test user config
├── http/                     # Insecure HTTP login page
├── smtp/                     # SMTP server for plain mail
├── dns/                      # DNS server with query logging
│
├── client/                   # Test machine (Alpine/Ubuntu)
│
├── scripts/
│   ├── generate-traffic.sh   # Optional traffic generator
│   └── test-login.sh         # Used for Wireshark demos
│
└── docs/
    ├── usage.md              # How to interact with services
    ├── protocol-overview.md  # Description of each insecure protocol
    └── mitigation.md         # How to secure them properly
```

Each protocol is isolated but shares the same custom Docker network.

---

# **Quickstart**

### **1. Clone the repository**

```bash
git clone <your-repo-url>
cd Docker
```

---

# **2. Start the network first (required for static IPs)**

If you have a shared network definition file:

```bash
docker network create \
  --subnet=192.168.10.0/24 \
  forensic-net
```

If each compose defines the network itself → **skip this step**.

---

# **3. Start each service individually**

Since every service has **its own docker-compose.yml**, navigate into each folder and start it.

---

### **Start FTP**

```bash
cd ftp
docker compose up -d
cd ..
```

---

### **Start HTTP**

```bash
cd http
docker compose up -d
cd ..
```

---

### **Start SMTP**

```bash
cd smtp
docker compose up -d
cd ..
```

---

### **Start DNS**

```bash
cd dns
docker compose up -d
cd ..
```

---

### **Start Client**

```bash
cd client
docker compose up -d
cd ..
```

---

# **4. Verify running containers**

```bash
docker ps
```

Expected containers:

* `ftp-server`
* `http-server`
* `smtp-server`
* `dns-server`
* `forensic-client`

---

# **5. Start generating traffic**

Open a shell in the **client** container:

```bash
docker exec -it forensic-client sh
```

Now run example traffic to capture with Wireshark:

### **FTP (plaintext credentials)**

```bash
ftp 192.168.10.10
```

---

### **HTTP POST login sniffing**

```bash
curl -d "user=test&pass=1234" http://192.168.10.20/login
```

---

### **SMTP plaintext email**

```bash
echo -e "EHLO test\nMAIL FROM:<a@test>\nRCPT TO:<b@test>\nDATA\nHallo Welt\n.\nQUIT" \
  | nc 192.168.10.30 1025
```

---

### **DNS Query Leakage**

```bash
dig @192.168.10.40 google.com
```

**Done. Start Wireshark and sniff the forensic-net traffic.**

---

### **5. Capture traffic with Wireshark**

On your host:

1. Choose the Docker network interface

2. Apply filters like:

   * `ftp`
   * `http`
   * `smtp`
   * `dns`
   * `tcp.stream eq 1`

3. Begin reconstructing plaintext credentials

---

# ## **FAQ**

### **Why Docker instead of Virtual Machines?**

* Faster startup
* Lower resource usage
* Perfect reproducibility
* Easy version control
* Cleaner network isolation

---

### **Can this harm my computer or network?**

No — as long as:

* You run it *only inside Docker*
* You do not expose ports externally
* You do not bridge it into your real network

All protocols stay isolated inside the `network-forensics-net` subnet.

---

### **Does this simulate real-world attacks?**

Yes — this is **exactly** how attackers steal plaintext credentials when insecure protocols are used.

You will see **real captured passwords** in FTP, Telnet, POP3, and HTTP.

---

### **Can I extend this lab?**

Absolutely. Common additions:

* **Telnet server**
* **POP3 server**
* **IMAP without TLS**
* **MITM simulation via arpspoof**
* **Custom Python C2 server**

---

### **Where do PCAP files go?**

You can export them manually from Wireshark or use:

`/analysis/pcap/` 
