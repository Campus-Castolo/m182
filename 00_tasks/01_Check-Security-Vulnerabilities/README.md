# Host-Discovery-Scan in docker network

The docker network `pentest_network` has the network address of `172.16.17.0/24`, since `kalibox` and `victim/metasploit` are in the same network we can execute the following command:

## Directory Navigation
```bash
01_Check-Security-Vulnerabilities/
└── exploit-scripts/
    └── exploits_ssh.rc
├── hostDiscovery.bash
├── README.md
├── serviceDiscovery.bash
└── serviceScanXml.bash
```

## Commands

```bash
nmap -sn 172.16.17.0/24
```

This command performs a host-discovery (“ping scan”) without doing any port scanning.
The output identifies all active hosts in the subnet, including:

* the attacker machine (`kalibox`)
* the metasploitable target (`victim`)
* the docker gateway (`172.16.17.1`)

---

# Service-Discovery-Scan (Portscan) on the metasploitable container

From the host-discovery step, we have the IP address of the metasploitable container (commonly something like `172.16.17.x`).
We can now run a service discovery scan with version detection:

```bash
nmap -sV 172.16.17.X
```

This scan enumerates all open ports on the metasploitable target and attempts to identify the running services and their versions.
Typical findings include: FTP (vsftpd), SSH (OpenSSH), Apache HTTPD, MySQL, Tomcat, Samba, IRC, etc.

---

# Service-Scan with Version-Information (XML Output)

To export the scan results in XML format for further analysis or automated workflows, we run:

```bash
nmap -sV -oX metasploitable_scan.xml 172.16.17.X
```

This produces a structured XML file (`metasploitable_scan.xml`) containing all detected ports, services, versions, and metadata.

You can display the output using:

```bash
cat metasploitable_scan.xml
```

---

# Potential Exploits for Discovered Services and Versions

Based on typical Metasploitable2 scan results, the following vulnerable services may be detected.
All exploits listed are widely documented and used for **training and educational lab purposes**:

---

### **vsftpd 2.3.4 (FTP)**

* **Vulnerability:** Backdoor command execution
* **CVE:** CVE-2011-2523
* **Description:** A malicious backdoor was inserted into a compromised vsftpd source package. Connecting with a username containing `:)` triggers a shell on port 6200.
* **Metasploit Module:**
  `exploit/unix/ftp/vsftpd_234_backdoor`

---

### **Samba smbd 3.0.20 (Port 139/445)**

* **Vulnerability:** “Username map script” Remote Code Execution
* **CVE:** CVE-2007-2447
* **Description:** Improper input validation allows passing shell commands that the server executes with root privileges.
* **Metasploit Module:**
  `exploit/multi/samba/usermap_script`

---

### **UnrealIRCd 3.2.8.1 (Port 6667)**

* **Vulnerability:** Built-in backdoor enabling remote command execution
* **CVE:** CVE-2010-2075
* **Description:** An intentionally backdoored tarball allows sending a malicious `AB` command to execute system commands.
* **Metasploit Module:**
  `exploit/unix/irc/unreal_ircd_3281_backdoor`

---

### **Apache 2.2.8 / PHP 5.2.4**

* **Vulnerabilities:** Multiple RCE vulnerabilities in PHP and web applications
* **Relevant CVEs:**

  * CVE-2007-3374 (PHP CGI argument injection)
  * CVE-2008-2666 (PHP memory corruption)
  * Numerous vulnerable web apps bundled with Metasploitable2 (DVWA, Mutillidae, WebDAV, etc.)

---

### **Tomcat 5.5 (Port 8180)**

* **Vulnerability:** Default / weak credentials
* **CVE:** CVE-2009-3843
* **Description:** Tomcat Manager uses default login `tomcat:tomcat`, which allows remote WAR deployment.
* **Metasploit Modules:**
  `auxiliary/scanner/http/tomcat_mgr_login`
  `exploit/multi/http/tomcat_mgr_deploy`

---

### **MySQL 5.0.51**

* **Vulnerability:** Authentication bypass & privilege escalation
* **CVE:** CVE-2008-7247
* **Description:** MySQL allows unauthorized login under certain conditions.

---

### **OpenSSH 4.7p1**

* **Vulnerability:** User enumeration via timing differences
* **CVE:** CVE-2006-5051
* **Description:** Allows attackers to discover valid usernames on system before attempting password guessing.