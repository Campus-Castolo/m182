# Wireshark Basics – Referenzdokumentation

Dieses Dokument ist als kompakte, aber vollständige Referenz gedacht. Es erklärt die Grundlagen von Wireshark so, dass man bei späteren Analysen (z. B. Credential Snooping oder Forensik mit PCAPs) schnell nachschlagen kann.

---

## 1. Was ist Wireshark?

Wireshark ist ein **Packet Sniffer** und **Protokoll-Analyzer**. Es kann Netzwerkverkehr mitschneiden (Capture) oder bereits aufgezeichnete Mitschnitte (PCAP/PCAPNG) öffnen und analysieren.  

Typische Einsatzgebiete:

- **Troubleshooting:** Warum kommt eine Verbindung nicht zustande? Wo hängt der TCP-Handshake?
- **Security / Forensics:** Was ist passiert? Welche Hosts kommunizieren? Welche Inhalte sind sichtbar?
- **Pentesting (rein analytisch):** Welche Protokolle laufen unverschlüsselt? Welche Metadaten lassen sich ableiten?

Wichtig: Wireshark „hackt“ nichts. Es macht Daten sichtbar, die sowieso über ein Interface laufen oder aus einer Datei stammen.

---

## 2. Grundbegriffe: Frame, Packet, Segment

Die Begriffe werden oft gemischt, in Wireshark lohnt sich aber die korrekte Einordnung:

- **Frame (Layer 2 / Ethernet):**  
  Das „Paket“ auf der Netzwerkkarte. Enthält z. B. MAC-Adressen, VLAN-Infos.

- **Packet (Layer 3 / IP):**  
  IP-Paket innerhalb des Frames. Enthält Quell-/Ziel-IP, TTL, Fragmentierung usw.

- **Segment (Layer 4 / TCP) bzw. Datagram (UDP):**  
  TCP-Segment oder UDP-Datagram innerhalb des IP-Pakets. Enthält Ports, Sequenznummern, Flags usw.

In Wireshark sieht man diese Schichten im **Packet Details** Bereich als Baumstruktur (Ethernet → IP → TCP/UDP → Application).

---

## 3. Capture vs. Display Filter (sehr wichtig)

### 3.1 Capture Filter
- Filtert **beim Mitschneiden** (weniger Daten werden überhaupt gespeichert).
- Vorteil: kleinere PCAPs, weniger Rauschen.
- Nachteil: Wenn man zu eng filtert, fehlen später evtl. wichtige Pakete.

Capture Filter Syntax ist BPF (Berkeley Packet Filter), z. B.:
- `tcp port 80`
- `udp port 53`
- `host 192.168.10.20`

### 3.2 Display Filter
- Filtert **nach dem Mitschneiden** (Analyse-Filter).
- Vorteil: Man kann jederzeit umstellen, ohne Daten zu verlieren.
- Wireshark-eigene Syntax, deutlich mächtiger.

Beispiele:
- `http`
- `dns`
- `ftp`
- `smtp`
- `tcp.port == 80`
- `ip.addr == 192.168.10.20`

**Merksatz:**  
Capture Filter = „Was wird aufgenommen?“  
Display Filter = „Was wird angezeigt?“

---

## 4. Interface auswählen und Capture starten

### 4.1 Interface-Wahl
Beim Start zeigt Wireshark verfügbare Interfaces an. Typische Hinweise:

- **Hohe Aktivität (laufender Graph)** = wahrscheinlich richtiges Interface
- Bei Docker/VM-Setups ist oft ein virtuelles Interface relevant (z. B. Docker bridge, vEthernet, etc.)

### 4.2 Start/Stop
- Start: blaues Haifischflossen-Symbol oder Doppelklick auf Interface
- Stop: rotes Quadrat

Für reproduzierbare Ergebnisse empfiehlt sich:
1. Capture starten
2. Traffic generieren (z. B. durch Testclient / Skript)
3. Capture stoppen
4. PCAP sauber speichern (Name + Datum + Kontext)

---

## 5. Wireshark-Ansicht richtig lesen

Wireshark ist in drei Hauptbereiche unterteilt:

1. **Packet List (oben):**  
   Jede Zeile = ein Frame. Wichtige Spalten: Zeit, Source, Destination, Protocol, Length, Info.

2. **Packet Details (mitte):**  
   Protokollbaum (Ethernet/IP/TCP/HTTP…).

3. **Packet Bytes (unten):**  
   Rohdaten in Hex + ASCII. Sehr nützlich, wenn Inhalte nicht sauber decodiert werden.

Tipp: Wenn man in Packet Details ein Feld anklickt, wird im Byte-Fenster der passende Bereich markiert.

---

## 6. Follow TCP Stream (eine der wichtigsten Funktionen)

### 6.1 Was macht das?
„Follow TCP Stream“ setzt die einzelnen TCP-Segmente zu einem lesbaren Datenstrom zusammen.  
Das ist besonders hilfreich bei:
- HTTP POST Requests
- FTP Logins
- SMTP Konversationen
- generell Textprotokollen über TCP

### 6.2 Vorgehen (konzeptionell)
1. Passendes Paket auswählen (z. B. HTTP-Request)
2. Rechtsklick → **Follow → TCP Stream**
3. Wireshark zeigt den gesamten Gesprächsverlauf Client ↔ Server

Typische Beobachtung:
- Man sieht Inhalte oft „menschlich lesbar“ (z. B. Parameter, Credentials, Header)
- Wireshark setzt automatisch einen Display Filter wie `tcp.stream eq X`

### 6.3 Limitationen
- Funktioniert nur sinnvoll, wenn der Stream vollständig im Capture enthalten ist
- Bei TLS/HTTPS sieht man den Stream, aber **nicht den Klartext** (nur verschlüsselte Daten)

---

## 7. Protokoll-Layer inspizieren

Wireshark erlaubt sauberes „Schichten-Denken“:

### 7.1 Ethernet (L2)
- MAC-Adressen
- VLAN (falls vorhanden)
- Hinweis auf Broadcasts / ARP

### 7.2 IP (L3)
- Source/Destination IP
- TTL (kann Routing-Hops andeuten)
- Fragmentierung (selten, aber wichtig in Forensik)

### 7.3 TCP/UDP (L4)
**TCP:**
- Ports, Flags (SYN, ACK, FIN, RST)
- Sequence/Ack Nummern
- Retransmissions (Hinweis auf Netzwerkprobleme)

**UDP:**
- Ports, keine Session-Logik
- DNS läuft typischerweise über UDP (aber auch TCP möglich)

### 7.4 Application Layer (L7)
- HTTP: Requests, Responses, Header, Body
- FTP: USER/PASS, Commands
- SMTP: EHLO/MAIL FROM/RCPT TO/DATA
- DNS: Queries, Responses, Record Types

---

## 8. PCAP exportieren und sauber ablegen

### 8.1 Ganze Aufnahme speichern
- File → Save As → `.pcapng` (Standard bei Wireshark)

### 8.2 Nur gefilterte Pakete exportieren
Wenn man z. B. nur HTTP oder nur einen Stream abgeben möchte:
- Display Filter setzen (z. B. `tcp.stream eq 3` oder `http`)
- File → Export Specified Packets
  - „Displayed“ wählen, damit nur gefilterte Pakete exportiert werden

Das ist praktisch für Doku/Abgaben, weil die Datei kleiner und fokussierter ist.

---

## 9. Häufig genutzte Display Filter (für dieses Projekt)

### 9.1 Protokollfilter
- `ftp`
- `http`
- `smtp`
- `dns`

### 9.2 Streamfilter
- `tcp.stream eq 0`  
  (Index je nach Capture anders)

### 9.3 IP/Hostfilter
- `ip.addr == 192.168.10.20`
- `ip.src == 192.168.10.50`
- `ip.dst == 192.168.10.10`

### 9.4 Portfilter
- `tcp.port == 21` (FTP Control)
- `tcp.port == 80` (HTTP)
- `tcp.port == 1025` (SMTP im Lab, falls so konfiguriert)
- `udp.port == 53` (DNS)

---

## 10. Typische Analyse-Checks (kleine Routine)

Wenn man ein PCAP öffnet und schnell verstehen will, was los ist:

1. **Was sind die Top-Talker?**  
   Statistics → Conversations (IP/TCP/UDP)

2. **Welche Protokolle kommen vor?**  
   Statistics → Protocol Hierarchy

3. **Gibt es auffällige Fehler?**  
   - TCP Retransmissions
   - RST/FIN Häufungen
   - ICMP Errors (falls vorhanden)

4. **Gibt es Streams mit Klartext?**  
   - `http` / `ftp` / `smtp`
   - Follow TCP Stream prüfen

---

## 11. Kurze Zusammenfassung für Anfänger

- Wireshark zeigt dir, was „über die Leitung“ geht.
- Capture Filter sind fürs Aufnehmen, Display Filter fürs Analysieren.
- „Follow TCP Stream“ ist der schnellste Weg, Textprotokolle zu verstehen.
- PCAPs immer so speichern, dass sie reproduzierbar sind (Namen, Datum, Kontext).

Damit ist die Basis gelegt, um später gezielt unsichere Protokolle zu analysieren oder bei forensischen PCAPs Auffälligkeiten zu finden.
