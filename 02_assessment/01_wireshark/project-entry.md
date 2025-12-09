# **Projektantrag – Wireshark & Network Forensics: Credential Snooping in Unsicheren Protokollen**

## **1. Projekttitel**

**"Network Forensics: Analyse und Ausnutzung unsicherer Netzwerkprotokolle mit Wireshark & Autopsy"**

---

## **2. Ausgangslage & Motivation**

Viele klassische Netzwerkprotokolle (FTP, HTTP, SMTP, DNS u.a.) wurden entwickelt, bevor sichere Transportmechanismen wie TLS flächendeckend verfügbar waren. Dadurch übertragen sie **Passwörter, Nachrichten, Befehle und Metadaten im Klartext**.

Mit Tools wie **Wireshark**, **Kali Linux** und **Autopsy** lassen sich diese Protokolle analysieren, rekonstruieren und auf mögliche Sicherheitsrisiken überprüfen.

Das Projekt findet **in einer vollständig simulierten, isolierten Laborumgebung** statt.

---

## **3. Ziel des Projekts**

Das Ziel ist, ein **professionelles, lehrreiches Videotutorial (8–14 Minuten)** inkl. Dokumentation zu erstellen, das zeigt:

1. Wie Wireshark funktioniert
2. Wie man Netzwerkverkehr sichtbar macht
3. Wie Klartext-Passwörter und andere sensitive Daten aus unsicheren Protokollen extrahiert werden können
4. Wie man forensische Netzwerkdaten mit Autopsy analysiert
5. Wie man Risiken solcher Protokolle erkennt und mitigiert

---

## **4. Projektumfang gemäss Kriterien**

### **4.1 Formale Vorgaben**

Die Abgabe enthält:

* Projektplanung
* Drehbuch
* Screencast (8–14 Min, Standardsprache oder Englisch)
* Dokumentation mit Journal, Resilienz-Bezug, Quellen
* Präsentation inkl. Einleitung
  → **Alle formalen Anforderungen werden erfüllt.**

---

## **5. Geplante Inhalte (Komplexität & Tiefe)**

Das Projekt besteht aus **zwei Hauptteilen**:

---

## **Teil A – Grundlagen (Theorie & Praxis)**

### **1. Was ist Wireshark?**

* Packet Sniffer
* Protokollanalysator
* Einsatzgebiete (Troubleshooting, Forensik, Pentesting)

### **2. Bedienung von Wireshark**

* Interfaces auswählen
* Filtersyntax (display filter vs capture filter)
* Frames / Packets / Segments / Protocol Layers lesen
* TCP Streams folgen

### **3. Fähigkeiten von Wireshark**

* Live Traffic Capture
* File Import (PCAP)
* Protokoll-Rekonstruktion (z.B. HTML, FTP Files)
* Password Extraction in Legacy Protocols

---

## **Teil B – Komplexe Cybersecurity-Themen**

### **4. Credential Snooping in unsicheren Protokollen**

#### **4.1 FTP – Klartext-Passwörter**

* Setup: FTP Server + Client in LAB
* Capture login credentials (USER, PASS)
* Analyse des gesamten Transfers

#### **4.2 HTTP – Login Form Sniffing**

* Einfache unsichere Webseite (HTTP)
* Abfangen von Login-Daten via POST
* Rekonstruktion mittels „Follow TCP Stream“

#### **4.3 SMTP – Klartext-E-Mails**

* Simulierter SMTP-Server (Port 25)
* Emails im Klartext sichtbar (Header, Body)
* Identifizierung sensibler Informationen

#### **4.4 DNS – Sensitive Query Leaks**

* DNS Queries zeigen Struktur der Benutzeraktivitäten
* Mögliche Angriffe: DNS Hijacking, Data Exfiltration

---

### **5. Wireshark + Autopsy – Forensische Analyse**

Ein ungewöhnlich starker Mehrwert für dein Projekt.
Vorgehen:

1. Capture eines verdächtigen Netzwerkverkehrs
2. Export als PCAP
3. Import in Autopsy
4. Analyse:

   * Rekonstruktion illegaler oder custom Netzwerkprotokolle
   * Auffinden exfiltrierter Daten
   * Erkennen von C2-Traffic (Command & Control)

**Beispiel-Szenario:**
Ein kleiner Python-Server sendet verschleierte Daten über ein eigenes Protokoll. Die Aufgabe ist, die Struktur zu erkennen und die Payload offenzulegen.

---

### **6. Bonus: Kali Linux Integration (Erweitertes Engagement)**

→ Diese zusätzlichen Themen zeigen **hohe Kreativität und Risikobereitschaft**:

* **ARP-Poisoning (mit Ettercap oder arpspoof)**
  → Ermöglicht MITM und damit Sniffing von noch mehr Klartext-Protokollen

* **Weak Protocol Attack Showcase**
  → Beispiel: Telnet statt SSH (klartext credentials)
  → Beispiel: POP3 (Port 110 – Klartext Passwörter)

* **Re-Injection von Netzwerkpaketen**
  → Demonstration wie Angreifer Traffic manipulieren könnten

Diese Teile können als Bonus oder Erweiterung eingebunden werden, um **maximale Punktzahl bei Engagement** zu sichern.

---

## **6. Vorgehen / Projektmethodik**

### **6.1 Planung**

* Definition Lernziele
* Einrichtung LAB-Umgebung in VirtualBox / Proxmox
* Erstellung Drehbuch
* Erstellung Testnetzwerk (Client, Server, Kali Linux)

### **6.2 Umsetzung**

* Durchführung aller Capture-Szenarien
* Aufzeichnung des Screencasts
* Einbau grafischer Annotationen (Filter, TCP Streams, etc.)

### **6.3 Dokumentation**

* Journal (täglicher Fortschritt)
* Quellen (Wireshark Docs, RFCs)
* Resilienz-Bezug:
  → Warum Grundlagenwissen in Netzwerksicherheit entscheidend ist
  → Umgang mit Fehlern während Analyse
  → Frusttoleranz bei unerwartetem Netzwerkverhalten

---

## **7. Erwartete Resultate**

* Videopräsentation (8–14 Minuten)
* Wireshark Capture Files (PCAPs)
* Autopsy Analysis Report
* Ausführliche Dokumentation mit Screenshots
* Übersicht aller abgefangenen Credentials in klarer Darstellung
* Empfehlungen wie man diese Protokolle absichert (TLS, SMTPS, FTPS, DNSSEC usw.)

---

## **8. Bewertungsvorteile pro Kriterium**

### **Komplexität → 9 Punkte**

Du deckst:

* Mind. 6 realistische Cybersecurity-Szenarien
* Forensik (Autopsy)
* Angriffssimulation (Kali Linux)
  → Übertrifft deutlich das erwartete Niveau.

### **Qualität der Umsetzung → 9 Punkte**

Wireshark ist visuell und technisch perfekt geeignet für ein klar verständliches Tutorial.
Du erklärst Protokolle + Sicherheit + Forensik → top.

### **Machart → 3 Punkte**

Screencast wird strukturiert, professionell, mit klarer Stimme (du hast gute Präsentationsskills).
Zeitvorgabe wird eingehalten.

### **Dokumentation → 3 Punkte**

Drehbuch + Journal + Resilienzteil + Quellen → alles vollständig.

### **Engagement → 3 Punkte**

Bonus-Themen wie:

* Autopsy
* Kali Linux MITM
* Multiple insecure protocols
  → Aussergewöhnlich hoher Einsatz.

---

## **9. Optional: Weitere Protokolle, die wir integrieren könnten falls zeit**

### **Telnet (EXTREM unsicher)**

→ Passwörter komplett im Klartext

### **POP3 (110)**

→ Benutzername + Passwort im Klartext

### **IMAP (143)**

→ Klartext Zugriff auf E-Mails

### **SNMP v1/v2**

→ Community Strings im Klartext
→ Zugriff auf Netzwerkgeräte möglich
