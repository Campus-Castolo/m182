# Master Video Script & Recording Guide
> Note this is only a draft, after discussion with the teacher this may be become obsolete

**Project:** Wireshark & Network Forensics – Credential Snooping in Unsicheren Protokollen
**Target length:** 8–14 minutes (≈10–12 min optimal)
**Tone:** calm, precise, professional, explanatory
**Audience:** teacher / examiner with IT background

---

## 🎬 Overall Structure (Scene Overview)

| Scene | Topic                                     | Approx. Time |
| ----- | ----------------------------------------- | ------------ |
| 0     | Introduction & Infrastructure Context     | 0:20–0:30    |
| 1     | What Wireshark Is & Why It Matters        | 1:00–1:30    |
| 2     | Traffic Capture & Forensic Methodology    | 1:00         |
| 3     | FTP – Plaintext Credential Snooping       | 1:00         |
| 4     | HTTP – Login Form Interception            | 1:15         |
| 5     | SMTP – Klartext E-Mail Exposure           | 1:15         |
| 6     | DNS – Metadata & Intelligence Leakage     | 1:00         |
| 7     | Attacker Workflow & PCAP Handling         | 1:00         |
| 8     | Forensic Continuation (Autopsy Reference) | 1:00         |
| 9     | Defensive Wrap-Up & Conclusion            | 0:30–0:45    |

---

## 0️⃣ Infrastructure Context (20–25s)

> **Spoken:**
> “This lab simulates a **flat internal network** using Docker.
> Multiple services are running deliberately with **insecure, legacy protocols** such as FTP, HTTP, SMTP, and DNS.
>
> The attacker model here is very simple: **network visibility only**.
> That could mean being on the same LAN, a shared Wi-Fi, a bridged container network, or a compromised network device.
>
> I am using Wireshark to **passively capture traffic**.
> There is no exploitation, no authentication bypass, and no active manipulation.
>
> Everything you will see is caused purely by **lack of encryption**.”

🎬 **Action:** Start capture on Docker / bridge interface

---

## 1️⃣ What Wireshark Is & Why It Matters (1:00–1:30)

> **Spoken:**
> “Wireshark is a **packet sniffer and protocol analyzer**.
> It allows us to inspect network traffic at every layer, from Ethernet frames up to application protocols.
>
> Wireshark is used in:
> troubleshooting,
> network forensics,
> and security analysis.
>
> It’s important to understand that Wireshark does not break encryption.
> If traffic is encrypted correctly, Wireshark can only see metadata — not content.
>
> So whenever we can read credentials or messages, that already tells us something is wrong.”

🎬 **Annotation:** Show protocol layer breakdown in packet details

---

## 2️⃣ Traffic Capture & Forensic Methodology (1:00)

> **Spoken:**
> “Before analyzing anything, we need proper evidence handling.
>
> I select the correct network interface — in this case the Docker bridge — and start a capture.
>
> While traffic is generated, Wireshark records **timestamps, streams, and protocol data**.
> This capture can later be exported as a PCAP file and treated as forensic evidence.
>
> From this point on, all analysis is read-only.”

🎬 **Action:** Show active capture, packets scrolling

---

## 3️⃣ FTP — Plaintext Credential Capture (≈1:00)

> **Spoken:**
> “Let’s start with FTP.
> I apply a display filter for FTP traffic.”

```
ftp
```

🎬 **Action:** Open packet → Follow → TCP Stream

> **Spoken:**
> “Here we see the authentication sequence.
> The `USER` command contains the username.
> The `PASS` command contains the password — both in plaintext.
>
> This is critical.
> FTP does not encrypt authentication.
> Anyone who can capture packets can immediately steal valid credentials.
>
> This attack works in shared networks, public Wi-Fi, insider scenarios, or compromised infrastructure.”

📸 **Screenshot:** USER / PASS visible

---

## 4️⃣ HTTP — POST Login Interception (≈1:15)

> **Spoken:**
> “Next, HTTP.
> I filter for HTTP traffic.”

```
http
```

🎬 **Action:** Click POST request → Follow TCP Stream

> **Spoken:**
> “This is a login request sent over plain HTTP.
> Inside the request body, we can see the username and password.
>
> This happens because HTTP provides no encryption.
> Attackers can read credentials, reconstruct sessions, and even steal cookies.
>
> This is why HTTPS is not optional for authentication — it is mandatory.”

📸 **Screenshot:** POST body with credentials

---

## 5️⃣ SMTP — Email Content Exposure (≈1:15)

> **Spoken:**
> “Now SMTP.
> I filter for SMTP traffic.”

```
smtp
```

🎬 **Action:** Follow TCP Stream

> **Spoken:**
> “Here we can see the full email conversation.
>
> The sender address,
> the recipient,
> the subject,
> and the entire message body are visible in plaintext.
>
> This is dangerous because attackers can read private communication,
> harvest sensitive information,
> or prepare targeted phishing attacks.”

📸 **Screenshot:** Email headers + body

---

## 6️⃣ DNS — Metadata Leakage (≈1:00)

> **Spoken:**
> “DNS is different.
> It usually doesn’t expose passwords, but it exposes **metadata**.
>
> I apply a DNS filter.”

```
dns
```

> **Spoken:**
> “Here we can see which domains and services are being accessed and when.
>
> This allows attackers to profile user behavior and map internal infrastructure.
> Even without payload data, DNS leaks valuable intelligence.”

---

## 7️⃣ Attacker Workflow & PCAP Export (≈1:00)

> **Spoken:**
> “From an attacker’s perspective, the workflow is simple.
>
> Capture traffic.
> Filter by protocol.
> Follow TCP streams.
> Extract credentials or content.
>
> The captured traffic can then be exported as PCAP files for later analysis or reporting.”

🎬 **Action:** File → Export Specified Packets

> **Spoken:**
> “All captures are stored in a structured analysis directory to preserve evidence integrity.”

---

## 8️⃣ Forensic Continuation – Autopsy (≈1:00)

> **Spoken:**
> “Network captures don’t stop at Wireshark.
>
> Exported artifacts can be imported into forensic tools like Autopsy.
> There, investigators can perform keyword searches, timeline correlation, and pattern analysis.
>
> This allows reconstruction of attacker behavior even after the traffic was captured.”

🎬 **Annotation:** Show Autopsy screenshots briefly

---

## 9️⃣ Final Wrap-Up (30–45s)

> **Spoken:**
> “This demonstration shows why plaintext protocols are insecure.
>
> FTP, HTTP, SMTP, and unprotected DNS leak credentials, content, and intelligence.
> Modern security relies on encryption like HTTPS, SFTP, SMTPS, and encrypted DNS.
>
> When encryption is enforced correctly, this entire class of attack disappears.
>
> Understanding these weaknesses is essential for building secure and resilient networks.”

🎬 **Action:** Stop capture
