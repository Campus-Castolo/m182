
# **Task 1: Risk Analysis for Three Systems**

### **Qualitative Risk Assessment Table**

| System                                                           | Threat                                                                | Vulnerability                                          | Likelihood     | Severity     | Impacted CIA Goals | Risk Level   |
| ---------------------------------------------------------------- | --------------------------------------------------------------------- | ------------------------------------------------------ | -------------- | ------------ | ------------------ | ------------ |
| **Web Server (public, hosts online shop)**                       | External attack (e.g., exploitation of web application vulnerability) | Outdated CMS / missing security patches                | **Frequent**   | **High**     | **C, I, A**        | **High**     |
| **Database Server (internal, contains sensitive customer data)** | Unauthorized access or data breach                                    | Insufficient access control, weak network segmentation | **Occasional** | **Critical** | **C, I**           | **Critical** |
| **Support Employee’s Notebook (mobile, VPN access)**             | Device theft leading to unauthorized network access                   | Missing full disk encryption; weak endpoint security   | **Occasional** | **High**     | **C, I**           | **High**     |

---

# **Task 2: Definition of Mitigation Measures**

| System               | Identified Risk                                                  | Security Measure                                                                                                                    | Expected Effect                                                                                                    |
| -------------------- | ---------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------ |
| **Database Server**  | Unauthorized access due to weak access controls and segmentation | Implement strict access control (role-based access), enforce MFA, improve network segmentation (separate DB subnet, firewall rules) | **Reduces probability** of unauthorized access; limits lateral movement; strengthens confidentiality and integrity |
| **Support Notebook** | Compromise of sensitive internal systems after device theft      | Enforce full-disk encryption, strong login policies, mandatory VPN with MFA, endpoint security (EDR), remote wipe capability        | **Reduces severity and likelihood** because stolen devices cannot easily be used to access the internal network    |

---

# **Task 3: Discussion & Evaluation**

### **1. Which system requires the most urgent action?**

The **database server** requires the highest priority.
It holds *sensitive customer data*, and a breach would cause:

* severe legal consequences (GDPR / data protection laws)
* major reputational damage
* possible financial penalties
* high impact on confidentiality and integrity

Because the risk is rated **critical**, mitigating it is essential.

---

### **2. How does the risk rating change if a vulnerability is fully fixed while the threat still exists?**

If the vulnerability is removed:

* The **likelihood** of successful exploitation is significantly reduced.
* Even if the threat still exists (e.g., hackers), the system is no longer easily exploitable.
* Therefore, the overall **risk rating decreases**, often dramatically.

Risk exists only where threat **and** vulnerability meet. Removing one side reduces risk.

---

### **3. Why are organizational measures (training, processes) also important?**

Technical controls alone cannot guarantee security. Organizational measures ensure that:

* employees understand risks and avoid unsafe behavior (e.g., phishing, weak passwords)
* security processes are consistently followed (e.g., incident reporting, patch management)
* responsibilities are clear and compliance is maintained
* secure use of devices and systems is supported by policies and awareness

Human factors are involved in more than 70% of incidents—organizational controls help address these.



---

# **1. Web Server (Public, Hosts Online Shop)**

**Threat**
External exploitation of web application vulnerabilities (e.g., SQLi, RCE)

**Vulnerability**
Outdated software stack, insufficient patch management

**Likelihood:** Frequent
**Severity:** High
**CIA Impact:** C / I / A
**Risk Level:** High

---

## **Combined Table (Risk + ISO + NIST + MITRE Columns)**

| Framework        | Mapping / Control                     | Description / Relevance                    | Likelihood | Severity | CIA Impact | Risk Level |
| ---------------- | ------------------------------------- | ------------------------------------------ | ---------- | -------- | ---------- | ---------- |
| **ISO 27001**    | A.8.8 Security of Information Systems | Secure configuration of web systems        | Frequent   | High     | C/I/A      | High       |
| **ISO 27001**    | A.8.9 Change Management               | Controls safe updates & patching           | Frequent   | High     | C/I/A      | High       |
| **ISO 27001**    | A.8.16 Monitoring Activities          | Detect malicious access attempts           | Frequent   | High     | C/I/A      | High       |
| **ISO 27001**    | A.8.28 Secure Coding                  | Prevents web vulnerabilities (OWASP)       | Frequent   | High     | C/I/A      | High       |
| **ISO 27001**    | A.5.23 Information Security Testing   | Vulnerability scanning, pentesting         | Frequent   | High     | C/I/A      | High       |
| **NIST CSF**     | PR.IP-12 Patch Management             | Ensures timely updates                     | Frequent   | High     | C/I/A      | High       |
| **NIST CSF**     | DE.CM-8 Vulnerability Monitoring      | Web scanning, SAST/DAST                    | Frequent   | High     | C/I/A      | High       |
| **NIST CSF**     | PR.AC-3 Access Control                | Secures authentication/authorization       | Frequent   | High     | C/I/A      | High       |
| **NIST CSF**     | RS.AN-1 Analysis                      | Incident analysis workflows                | Frequent   | High     | C/I/A      | High       |
| **MITRE ATT&CK** | T1190 Exploit Public-Facing App       | Main technique used to exploit web servers | Frequent   | High     | C/I/A      | High       |
| **MITRE ATT&CK** | T1059 Command Execution               | RCE after exploitation                     | Frequent   | High     | C/I/A      | High       |
| **MITRE ATT&CK** | T1136 Create Accounts                 | Persistence technique                      | Frequent   | High     | C/I/A      | High       |
| **MITRE ATT&CK** | T1041 Exfiltration Over C2            | Data theft                                 | Frequent   | High     | C/I/A      | High       |
| **MITRE ATT&CK** | T1499 Endpoint DoS                    | Denial-of-service attacks                  | Frequent   | High     | C/I/A      | High       |

---

# **2. Database Server (Internal, Sensitive Customer Data)**

## **Risk Assessment (Formatted as Requested)**
**Threat**
Unauthorized access / data breach

**Vulnerability**
Weak access controls, insufficient network segmentation

**Likelihood:** Occasional
**Severity:** Critical
**CIA Impact:** C / I
**Risk Level:** Critical

---

## **Combined Table (Risk + ISO + NIST + MITRE Columns)**

| Framework        | Mapping / Control              | Description / Relevance            | Likelihood | Severity | CIA Impact | Risk Level |
| ---------------- | ------------------------------ | ---------------------------------- | ---------- | -------- | ---------- | ---------- |
| **ISO 27001**    | A.5.15 Access Control Policy   | Restricts DB access                | Occasional | Critical | C/I        | Critical   |
| **ISO 27001**    | A.5.16 Identity Management     | Unique DB accounts                 | Occasional | Critical | C/I        | Critical   |
| **ISO 27001**    | A.7.4 Privileged Access Rights | Protection of admin access         | Occasional | Critical | C/I        | Critical   |
| **ISO 27001**    | A.8.9 Secure Configuration     | Hardened DB configuration          | Occasional | Critical | C/I        | Critical   |
| **ISO 27001**    | A.8.20 Network Security        | Proper segmentation                | Occasional | Critical | C/I        | Critical   |
| **ISO 27001**    | A.8.23 Firewalls               | DB subnet protection               | Occasional | Critical | C/I        | Critical   |
| **NIST CSF**     | PR.AC-4 Access Enforcement     | RBAC for DB                        | Occasional | Critical | C/I        | Critical   |
| **NIST CSF**     | PR.DS-5 Data Protection        | Encryption at rest & transit       | Occasional | Critical | C/I        | Critical   |
| **NIST CSF**     | DE.AE-1 Anomaly Detection      | Detects unusual DB behavior        | Occasional | Critical | C/I        | Critical   |
| **NIST CSF**     | DE.CM-7 Monitoring             | Database activity monitoring (DAM) | Occasional | Critical | C/I        | Critical   |
| **MITRE ATT&CK** | T1003 Credential Dumping       | Access DB credentials              | Occasional | Critical | C/I        | Critical   |
| **MITRE ATT&CK** | T1021 Remote Services          | Lateral movement to DB             | Occasional | Critical | C/I        | Critical   |
| **MITRE ATT&CK** | T1020 Automated Exfiltration   | Large data theft                   | Occasional | Critical | C/I        | Critical   |
| **MITRE ATT&CK** | T1485 Data Destruction         | Corrupt / delete DB data           | Occasional | Critical | C/I        | Critical   |

---

# **3. Support Notebook (Mobile, VPN Access)**

**Threat**
Device theft leading to unauthorized internal access

**Vulnerability**
Weak endpoint security; missing full disk encryption

**Likelihood:** Occasional
**Severity:** High
**CIA Impact:** C / I
**Risk Level:** High

---

## **Combined Table (Risk + ISO + NIST + MITRE Columns)**

| Framework        | Mapping / Control             | Description / Relevance       | Likelihood | Severity | CIA Impact | Risk Level |
| ---------------- | ----------------------------- | ----------------------------- | ---------- | -------- | ---------- | ---------- |
| **ISO 27001**    | A.6.1 Clear Desk/Screen       | Prevents unauthorized viewing | Occasional | High     | C/I        | High       |
| **ISO 27001**    | A.7.5 Authentication Info     | MFA, strong passwords         | Occasional | High     | C/I        | High       |
| **ISO 27001**    | A.8.3 Mobile Device Security  | Secure mobile policies        | Occasional | High     | C/I        | High       |
| **ISO 27001**    | A.8.4 Cryptographic Controls  | Full disk encryption          | Occasional | High     | C/I        | High       |
| **ISO 27001**    | A.8.15 Logging                | Endpoint monitoring           | Occasional | High     | C/I        | High       |
| **ISO 27001**    | A.8.25 Secure Disposal        | Remote wipe                   | Occasional | High     | C/I        | High       |
| **NIST CSF**     | PR.AC-1 Identity Management   | Secure VPN access             | Occasional | High     | C/I        | High       |
| **NIST CSF**     | PR.AC-6 Least Privilege       | Minimum-access device config  | Occasional | High     | C/I        | High       |
| **NIST CSF**     | PR.DS-1 Data at Rest          | Encryption                    | Occasional | High     | C/I        | High       |
| **NIST CSF**     | DE.CM-7 Continuous Monitoring | EDR agent                     | Occasional | High     | C/I        | High       |
| **MITRE ATT&CK** | T1200 Stolen Device           | Physical access               | Occasional | High     | C/I        | High       |
| **MITRE ATT&CK** | T1110 Password Cracking       | Attempt to access device      | Occasional | High     | C/I        | High       |
| **MITRE ATT&CK** | T1078 Valid Accounts          | Stolen VPN credentials        | Occasional | High     | C/I        | High       |
| **MITRE ATT&CK** | T1005 Local Data Access       | Cached or local files         | Occasional | High     | C/I        | High       |

# Risk Graph

| ID    | Affected System            | Cause / Threat                                     | Impact (1–5) | Severity (1–5) | Risk Score | Risk Level   |
| ----- | -------------------------- | -------------------------------------------------- | ------------ | -------------- | ---------- | ------------ |
| **1** | Web Server (Public)        | Outdated CMS leads to exploitation                 | 5            | 4              | **20**     | **Critical** |
| **2** | Web Server (Public)        | DDoS attack disrupts availability                  | 3            | 4              | **12**     | Medium       |
| **3** | Web Server (Public)        | Misconfigured firewall exposes admin panel         | 4            | 3              | **12**     | Medium       |
| **4** | Database Server (Internal) | Weak network segmentation enables lateral movement | 5            | 5              | **25**     | **Critical** |
| **5** | Database Server (Internal) | Missing encryption → data exposure                 | 5            | 4              | **20**     | **Critical** |
| **6** | Database Server (Internal) | Backup misconfiguration → data loss                | 4            | 4              | **16**     | High         |
| **7** | Support Notebook (Mobile)  | Device theft with no full-disk encryption          | 4            | 4              | **16**     | High         |
| **8** | Support Notebook (Mobile)  | Weak VPN authentication → unauthorized access      | 3            | 4              | **12**     | Medium       |
| **9** | Support Notebook (Mobile)  | Malware infection due to missing EDR               | 3            | 3              | **9**      | Medium       |

<img width="1290" height="1027" alt="image" src="https://github.com/user-attachments/assets/a1bd9209-ca2f-4bf0-bd8a-729bebb7f944" />

| Factor              | What It Measures                                                                           | Key Question                                            | Why It Is Important                                                                                   | Interaction With Others                                                                                                    |
| ------------------- | ------------------------------------------------------------------------------------------ | ------------------------------------------------------- | ----------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------- |
| **Impact**          | Business consequences of the risk (financial, legal, customer trust, service loss)         | *“How bad is it for the business if this risk occurs?”* | Shows how much damage the organization suffers; helps prioritize risks that threaten critical assets. | High Impact × High Likelihood = **major priority**; High Impact × Low Likelihood = **long-term monitoring risk**.          |
| **Severity**        | Technical and operational damage to systems, processes, and IT infrastructure              | *“How deeply does this affect systems and operations?”* | Identifies how critical the technical failure is; reveals whether recovery is easy or complex.        | High Severity + High Impact = **business & technical crisis**; High Severity + Low Impact = **operational inconvenience**. |
| **Likelihood**      | Probability that the risk will occur based on exposure, vulnerabilities, and threat actors | *“How likely is it that this event will happen?”*       | Helps forecast real-world events; prevents over- or underestimating risks that rarely happen.         | High Likelihood × Medium Impact becomes **more dangerous** than low-likelihood high-impact risks.                          |
| **Combined Effect** | Full 3D risk perspective by combining all three                                            | *“What is the real risk level?”*                        | Enables objective prioritization and supports ISO/NIST-compliant risk scoring.                        | Impact × Severity × Likelihood = **comprehensive risk score** allowing comparison and ranking of risks.                    |
