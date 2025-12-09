# **Docker Lab  Simulated Network Environment**

### *Building an Isolated Infrastructure for Network Protocol Analysis*

---

## **Why Do We Do This?**

This Docker-based lab environment simulates a **realistic but controlled network** where insecure protocols operate without endangering real systems or data. By containerizing each service, we can:

* **Isolate security testing** from production environments
* **Reproduce vulnerable configurations** safely and consistently
* **Capture authentic network traffic** without ethical or legal concerns
* **Learn offensive and defensive techniques** in a sandboxed environment
* **Demonstrate real-world attack vectors** that still exist in legacy systems

---

## **What Purpose Does It Serve?**

This lab enables you to:

1. **Capture plaintext credentials** transmitted over FTP, HTTP, SMTP, and other insecure protocols
2. **Analyze network traffic patterns** using Wireshark in a controlled setting
3. **Understand protocol-level vulnerabilities** that persist in many enterprise environments
4. **Practice forensic analysis** by reconstructing sessions and extracting artifacts
5. **Compare insecure vs. secure implementations** (e.g., FTP vs. FTPS, HTTP vs. HTTPS)

The Docker environment provides a **repeatable, version-controlled infrastructure** that can be shared, modified, and redeployed with a single command.

---

## **Legal Safekeeping**

### **  Ethical Use Only**

All activities in this lab are conducted in a **fully isolated, self-contained Docker network**.

* **Only perform these tests on your own infrastructure**
* **Never capture traffic on networks you do not own or have explicit permission to test**
* **Do not use these techniques for unauthorized access or malicious purposes**
* This lab is designed for **educational and defensive security training** only

**Unauthorized network interception is illegal in most jurisdictions** (e.g., Wiretap Act in the US, GDPR in Europe, § 202a/b StGB in Germany).

---

## **Structure**

The Docker lab consists of the following components:

### **1. Network Infrastructure**

* **Custom Docker network:** `network-forensics-net` (172.20.0.0/16)
* **Isolated subnet** to prevent interference with host or other containers
* **Bridge networking** for container-to-container communication

### **2. Service Containers**

| Service    | Container Image            | Purpose                              | Port(s)       |
| ---------- | -------------------------- | ------------------------------------ | ------------- |
| **FTP**    | `stilliard/pure-ftpd`      | Plaintext authentication & file xfer | 21, 30000-30009 |
| **HTTP**   | `nginx:alpine`             | Unsecured web server with login form | 80            |
| **SMTP**   | `mailhog/mailhog`          | Plaintext email transmission         | 1025, 8025    |
| **DNS**    | `strm/dnsmasq`             | Query logging and metadata exposure  | 53            |
| **Client** | `alpine:latest`            | Test client for protocol interaction | -             |

### **3. Wireshark Host**

* **Your PC (not containerized)** runs Wireshark
* Captures traffic on the Docker bridge interface
* Analyzes protocols using display filters and TCP stream reconstruction

---

## **Quickstart**

### **Prerequisites**

* Docker Desktop or Docker Engine installed
* Docker Compose (v2.0+)
* Wireshark installed on host machine
* Basic command-line knowledge

### **Step 1: Clone or Navigate to Project**

```bash
cd 02_assessment/01_wireshark/01_Docker
```

### **Step 2: Start the Lab Environment**

```bash
docker-compose up -d
```

This will:
* Create the `network-forensics-net` network
* Start all service containers (FTP, HTTP, SMTP, DNS, Client)
* Assign static IP addresses to each container

### **Step 3: Verify Containers are Running**

```bash
docker ps
```

You should see all services in the "Up" state.

### **Step 4: Identify the Docker Network Interface**

**On Windows:**
```bash
ipconfig
# Look for "vEthernet (WSL)" or Docker bridge adapter
```

**On Linux/macOS:**
```bash
ifconfig
# Look for "docker0" or "br-<network-id>"
```

### **Step 5: Start Wireshark Capture**

1. Open Wireshark
2. Select the Docker network interface
3. Start capturing traffic
4. Apply display filters as needed (e.g., `ftp`, `http`, `smtp`, `dns`)

### **Step 6: Generate Test Traffic**

**Enter the client container:**
```bash
docker exec -it forensics-client sh
```

**Test FTP:**
```bash
ftp 172.20.0.10
# User: testuser
# Pass: testpass123
```

**Test HTTP:**
```bash
curl -X POST http://172.20.0.20/login \
  -d "username=admin&password=secret123"
```

**Test SMTP:**
```bash
telnet 172.20.0.30 1025
EHLO client
MAIL FROM:<attacker@test.com>
RCPT TO:<victim@test.com>
DATA
Subject: Test Mail
This is a plaintext email.
.
QUIT
```

**Test DNS:**
```bash
nslookup malicious-domain.com 172.20.0.40
```

### **Step 7: Stop the Lab**

```bash
docker-compose down
```

To also remove volumes:
```bash
docker-compose down -v
```

---

## **FAQ**

### **Q: Can I run this on Windows/macOS?**
**A:** Yes, Docker Desktop supports all platforms. Network interface names may vary.

### **Q: Why can't I see traffic in Wireshark?**
**A:**
* Ensure you're capturing on the correct Docker interface
* Check that containers are running (`docker ps`)
* Try disabling promiscuous mode if on WiFi
* On Windows, may need to run Wireshark as Administrator

### **Q: How do I add more services?**
**A:** Edit `docker-compose.yml` and add new service definitions with appropriate network configurations.

### **Q: Are these containers production-ready?**
**A:** **No.** These are deliberately insecure for educational purposes. Never deploy these configurations in production.

### **Q: Can I capture HTTPS/TLS traffic?**
**A:** TLS-encrypted traffic cannot be decrypted in Wireshark without private keys. This lab focuses on plaintext protocols.

### **Q: How do I extract credentials from captures?**
**A:** Use Wireshark's "Follow TCP Stream" feature or filter by protocol (e.g., `ftp.request.command == "PASS"`).

### **Q: What's the difference between MailHog and a real SMTP server?**
**A:** MailHog is a testing tool that captures emails without sending them. It provides a web UI (port 8025) to inspect messages.

### **Q: Can I use this for CTF competitions?**
**A:** Yes, this setup is ideal for CTF preparation and network forensics challenges.

### **Q: How do I persist capture files?**
**A:** Save PCAPs to the `/pcap/` directory (mounted volume) for persistent storage.

### **Q: What if containers fail to start?**
**A:** Check logs with `docker-compose logs <service-name>` and verify port availability.

---

## **Next Steps**

* [Wireshark Analysis Guide](../docs/wireshark-guide.md)
* [Capture File Examples](../pcap/)
* [HTTP Login Form Source](./http-server/login.html)
* [Parent README  Project Overview](../README.md)

---

## **Contributing**

To extend this lab:
1. Fork the repository
2. Add new service definitions to `docker-compose.yml`
3. Update this README with usage instructions
4. Submit a pull request

---

## **References**

* [Docker Networking Documentation](https://docs.docker.com/network/)
* [Wireshark User Guide](https://www.wireshark.org/docs/wsug_html_chunked/)
* [OWASP Testing Guide  Network Layer](https://owasp.org/www-project-web-security-testing-guide/)

---

**Last Updated:** 2025-12-09
**Author:** [Your Name]
**License:** MIT (Educational Use)
