# 🧪 Autopsy Analysis — Simulated Command & Control (C2) Traffic

## Scope & Integrity Statement

This analysis documents a **simulated Command & Control (C2) communication pattern** created for educational and forensic purposes. The simulation mirrors **real-world malware behavior** without using live malware or restricted datasets. This approach avoids legal/DMCA issues while preserving methodological realism.

All findings below are derived from **PCAP-derived artifacts** exported from Wireshark and analyzed in **Autopsy**.

---

## 1️⃣ Artifact Import (Forensic Intake)

### Evidence Preparation

From the network capture, the following artifacts were exported in a read-only manner:

* Reconstructed TCP streams representing periodic client→server callbacks
* Decoded payload extracts (textual blobs recovered from streams)
* Session metadata (timestamps, endpoints, stream identifiers)

Each artifact was checksum-verified before ingestion to preserve evidential integrity.

### Autopsy Case Setup

* Case Type: Network Artifact Analysis (PCAP-derived)
* Timezone: Local system time (aligned with capture)
* Data Sources: Exported artifacts only (no direct PCAP parsing claim)

Autopsy indexed all artifacts for **strings, metadata, and timelines**.

---

## 2️⃣ Keyword Hits on Payload Fragments

### Keyword Strategy

A tiered keyword list was used to surface suspicious content commonly associated with C2 traffic:

* **Control semantics:** `cmd`, `exec`, `task`, `resp`, `ok`
* **Transfer semantics:** `data`, `chunk`, `upload`, `exfil`
* **Encoding indicators:** `base64`, padding patterns (`=`), high-entropy strings

### Findings

* Multiple payload fragments contained short, high-entropy strings consistent with **encoded command or data blobs**
* Repeated structural markers appeared at the start of payloads, suggesting a **fixed message format**
* Decoded samples revealed benign placeholder content used to simulate command responses

**Forensic value:** Even without malware, **keyword clustering** across multiple artifacts is a strong indicator of coordinated control traffic.

---

## 3️⃣ Timeline Analysis — Beacon Interval Detection

### Method

Autopsy’s timeline view was used to correlate artifact timestamps.

### Observed Pattern

* Client-to-server communications occurred at **regular, fixed intervals**
* Intervals were consistent across multiple sessions (low jitter)
* Each callback was followed by a short server response

### Interpretation

Regular beaconing is a classic C2 indicator:

* Normal applications show bursty or user-driven timing
* Fixed intervals strongly suggest **automated polling**

**Conclusion:** Temporal regularity alone is sufficient to flag the traffic as suspicious during incident response.

---

## 4️⃣ Pattern Recognition — Structural Consistency

Across all analyzed artifacts, the following consistencies were observed:

* Identical payload framing (header → body → terminator)
* Stable payload size ranges
* Repeating request/response sequence

Such uniformity is atypical for human-driven protocols and aligns with **malware framework design**, where simplicity and predictability reduce development complexity.

---

## 5️⃣ Reconstruction of Exfiltrated Data

### Reconstruction Approach

Payload fragments were concatenated chronologically based on timestamps and sequence identifiers.

### Results

* Reassembled data formed a coherent, readable dataset (simulated)
* Chunk boundaries aligned with transport segmentation
* No corruption observed, indicating reliable transport logic

### Forensic Implication

This demonstrates that:

* Partial captures can still yield **complete exfiltrated content**
* Attackers do not require large bandwidth to leak meaningful data

---

## 6️⃣ Mapping to Real-World Malware Behavior

The simulated traffic exhibits multiple characteristics observed in real malware families:

| Observed Trait            | Real-World Equivalent                    |
| ------------------------- | ---------------------------------------- |
| Periodic beaconing        | Botnet heartbeat (e.g., HTTP/S polling)  |
| Encoded payloads          | Obfuscation to evade signature detection |
| Small, frequent transfers | Low-and-slow exfiltration                |
| Fixed message format      | Custom C2 protocol                       |

**Key Insight:** Forensic detection relies on **behavioral patterns**, not malware samples.

---

## 7️⃣ Forensic Conclusion

This Autopsy-based analysis demonstrates that:

* C2-like behavior can be reliably identified post-capture
* Keyword analysis, timelines, and structure are sufficient indicators
* Ethical simulation is a valid and professional teaching method

Even without live malware, the investigation replicates **real incident response workflows** and provides high evidential value.
