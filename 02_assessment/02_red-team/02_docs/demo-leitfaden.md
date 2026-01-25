

# 🎥 Red Team — Credential Snooping (Wireshark)

**Quick but Detailed Runthrough (~3 min)**

---

## 0️⃣ Infrastructure Context (20–25s)

> “This Docker lab simulates a **flat internal network** with multiple insecure services.
> The attacker has **network visibility only**, for example by being on the same LAN or bridge.
>
> I’m using Wireshark to passively capture traffic — no exploitation, no authentication bypass.”

👉 Start capture on Docker / bridge interface.

> “Everything you’ll see is caused by **insecure protocols**, not misconfiguration.”

---

## 1️⃣ FTP — Plaintext Credential Capture (30–35s)

> “Look here.
> Filter for FTP traffic.”

```
ftp
```

👉 Open packet → Follow → TCP Stream

> “You can see the **USER and PASS commands in plaintext**.”

> “This is bad because FTP does not encrypt authentication.
> Any attacker with packet access can steal valid credentials instantly.”

👉 One sentence attack vector:

> “This works in shared networks, Wi-Fi, compromised routers, or insider attacks.”

📸 Screenshot.

---

## 2️⃣ HTTP — POST Login Interception (40–45s)

> “Look here.
> Filter for HTTP.”

```
http
```

👉 Click POST request → Follow TCP Stream

> “You can see the login form data — username and password — inside the request body.”

> “This is bad because HTTP does not protect credentials in transit.
> Attackers can reconstruct sessions and reuse credentials or cookies.”

👉 Quick real-world note:

> “This is why HTTPS is mandatory for authentication.”

📸 Screenshot.

---

## 3️⃣ SMTP — Email Content Exposure (40–45s)

> “Look here.
> Filter for SMTP.”

```
smtp
```

👉 Follow TCP Stream

> “Here you can see:
>
> * sender
> * recipient
> * subject
> * and the full email body”

> “This is bad because attackers can read private communication or use emails for phishing and impersonation.”

📸 Screenshot.

---

## 4️⃣ DNS — Metadata Leakage (30–35s)

> “Look here.
> Filter for DNS.”

```
dns
```

> “DNS doesn’t expose passwords, but it **exposes behavior**.”

> “You can see which domains and services are accessed and when.”

> “This is bad because attackers can profile users and map internal infrastructure.”

---

## 5️⃣ Attacker Workflow + PCAP Export (25–30s)

> “From an attacker’s perspective, the workflow is simple:
> capture traffic, filter by protocol, follow TCP streams, extract data.”

👉 File → Export Specified Packets

> “All PCAPs are exported to `/analysis/pcap/` for documentation.”

---

## 6️⃣ Wrap-Up (15–20s)

> “This demonstrates why **plaintext protocols are insecure**.
> Encryption like HTTPS, SFTP, SMTPS, and encrypted DNS prevents this attack completely.”

Stop capture.
