# **📄 Projektantrag (Project Application)**

**Thema:** *Analyse von Netzwerkverkehr mit Wireshark – Von Grundlagen bis hin zur Cybersecurity-Forensik*
**Schüler:** Rayan
**Modul:** Cybersecurity
**Dauer:** 20 Lektionen
**Abgabe:** Projektplanung + Video (8–14 Minuten)

---

## **1. Projektbeschreibung**

In diesem Projekt analysiere ich Netzwerkkommunikation in einem vollständig simulierten und isolierten Umfeld mithilfe von Wireshark und ergänzenden Tools wie Kali Linux und Autopsy. Ziel ist es, sowohl grundlegende Funktionen von Wireshark zu verstehen als auch fortgeschrittene sicherheitsrelevante Analysen durchzuführen, inklusive Credential-Snooping, Protokollanalyse und digitaler Forensik.

Das Projekt kombiniert **Netzwerkanalyse**, **Cybersecurity**, und **Forensik**, und führt die Lernperson durch den gesamten Prozess: Von „Was ist Wireshark?“ bis hin zur Untersuchung illegaler Netzwerkaktivitäten.

---

## **2. Projektziele**

### **Fachliche Ziele**

* Grundlagenverständnis von Wireshark (GUI, Filter, Capture-Verfahren).
* Fähigkeit, Netzwerkverkehr zu erfassen, zu analysieren und sicherheitskritische Muster zu erkennen.
* Untersuchung realer Angriffsvektoren im simulierten Umfeld:

  * Passwort-Mitschnitte (HTTP, FTP)
  * DNS-Manipulation & DNS-Exfiltration
  * TCP-Handshake (SYN, ACK) zur Erkennung von Scanning-Aktivitäten
* Forensische Analyse einer illegalen Netzwerkaktivität mit *Autopsy*:

  * Import einer PCAP-Datei
  * Timeline-Analyse
  * Protokoll-Rekonstruktion
  * Identifikation verdächtiger Spuren

### **Medien-/Methodenziele**

* Erstellung eines strukturierten Screencasts (8–14 Minuten).
* Professionelle Projektdokumentation mit Drehbuch, Journal und Quellen.
* Verknüpfung des Themas mit dem Konzept *Resilienz* (Cyber Resilience → Fähigkeit, Angriffe zu erkennen und abzuwehren).

---

## **3. Projektinhalt & Themenübersicht**

### **A. Grundlagen – Basiswissen zur Orientierung**

1. **Was ist Wireshark?**

   * Paket-Sniffer
   * Einsatzbereiche
   * Relevanz in IT und Security

2. **Wie benutzt man Wireshark?**

   * Interfaces auswählen
   * Live Capture vs. Offline Capture
   * Display Filters & Capture Filters
   * Analysefunktionen, Statistiken

3. **Was kann Wireshark?**

   * Protokollanalyse
   * Fehlersuche
   * Sicherheitsüberwachung
   * Angriffserkennung

---

### **B. Komplexe Cybersecurity-Analysen – Praxis in simulierten Angriffen**

#### **1. FTP – Credential Snooping**

* Starten eines Fake-FTP-Servers
* Klartext-Passwörter auslesen
* Analyse der Login-Sequenz (USER / PASS)

#### **2. HTTP – Credential Snooping**

* Test-Webserver ohne HTTPS
* Abfangen eines Login-Vorgangs
* Decodieren der HTTP-Formulardaten

#### **3. DNS-Analyse**

* DNS-Request/Response-Path
* Identifikation von DNS-Tunneling
* Analyse verdächtiger Domains

#### **4. TCP SYN/ACK – Erkennen von Reconnaissance**

* Port-Scanning mittels Kali Linux (nmap)
* Wireshark erkennt SYN-Flooding, SYN-Scans
* Auswertung der Flags und Verbindungsversuche

#### **5. Forensische Analyse: "Illegale Netzwerkaktivität" mit Autopsy**

* Import einer PCAP-Datei mit simuliertem Schadverhalten
* Rekonstruktion:

  * HTTP-Exfiltration
  * Command & Control Traffic
  * FTP-Dropzones
* Erstellung eines forensischen Berichts

---

## **4. Erweiterungen (optional, je nach Zeit)**

Diese Themen erhöhen den **Komplexitätsgrad für Maximalpunktzahl (9/9)**:

### **+ Kali Linux Integration**

* Passiv vs. Aktiv Sniffing
* ARP-Spoofing → Wireshark-Analyse
* MITM-Angriff simulieren

### **+ Angriffserkennung**

* Analyse eines Brute-Force-Angriffs via PCAP
* Pattern Detection mit Wireshark-Filtern

### **+ Malware-behafteter Netzwerkverkehr**

* Analyse einer vorconstructeten PCAP aus Malware-Traffic (z. B. C2-Checkins)

---

## **5. Projektmethodik & Vorgehensweise**

### **1. Planung & Vorbereitung**

* Installation der virtuellen Umgebung (Kali Linux + Opfermaschine)
* Setup eines isolierten Netzwerks
* Tools: Wireshark, Autopsy, nmap, test-webserver

### **2. Durchführung**

* Schrittweise Analyse aller o.g. Protokolle
* Dokumentation jedes Testfalls
* Erstellung der finalen Screencast-Präsentation

### **3. Reflexion & Resilienz-Bezug**

* Bedeutung der Netzwerkanalyse für Cyber Resilience
* Was kann ein Unternehmen tun?
* Welche Kompetenzen entwickelt man durch Network Forensics?

---

## **6. Abzugebende Artefakte**

✔ Projektplanung (dieses Dokument)
✔ Drehbuch für Screencast
✔ Lernjournal
✔ Screencast (8–14 min, Standardsprache oder Englisch)
✔ Quellenverzeichnis
✔ Resilienz-Bezug (Cyber Resilience)

---

## **7. Erwartetes Ergebnis & Nutzen**

Am Ende entsteht ein **komplexes, praxisnahes Security-Analyseprojekt**, das realistische Angriffe untersucht, in professionellen Tools dokumentiert wird und ein hohes Level an fachlicher Tiefe zeigt—ideal für **Maximalpunktzahl** in allen Kategorien.

---

## **8. Engagement & Kreativität**

Das Projekt geht über die Standard-Wireshark-Theorie hinaus und kombiniert:

* Live-Angriffe
* Packet Forensics
* Autopsy-Analyse
* Kali Linux Integration
* Erstellung einer professionellen Video-Dokumentation