# Red Team – Attack Test Cases (Simulated / Insecure Environment)

## 1. Ziel und Umfang der Red-Team-Tests

Die Red-Team-Aktivitäten in diesem Projekt dienen nicht der realen Ausnutzung von Systemen, sondern verfolgen einen **didaktischen Zweck**. Ziel ist es, aufzuzeigen, welche Risiken durch unsichere Netzwerkprotokolle entstehen und welche Informationen ein Angreifer allein durch passives Beobachten des Netzwerkverkehrs gewinnen kann.

Die Tests bilden eine **unsichere Ausgangsbasis**, welche später von der Blue Team Seite abgesichert und validiert wird. Alle Tests wurden ausschließlich innerhalb der isolierten Docker-Laborumgebung durchgeführt.

---

## 2. Angreiferannahmen (Threat Model)

Für die Red-Team-Tests wurden folgende realistische Angreiferannahmen getroffen:

- **Passiver Netzwerkbeobachter (Sniffer)**  
  Der Angreifer kann den Netzwerkverkehr im selben Subnetz mitlesen, ohne aktiv Pakete zu manipulieren.

- **Interner Zugriff auf das Netzwerk**  
  Der Angreifer befindet sich im gleichen logischen Netzwerk (z. B. kompromittierter Client oder Container).

- **Keine privilegierten Rechte auf den Zielsystemen**  
  Es werden keine administrativen Zugriffe oder Exploits vorausgesetzt.

Nicht im Scope:
- Denial-of-Service-Angriffe
- Exploits auf Betriebssystemebene
- Angriffe auf externe Netzwerke oder reale Systeme

---

## 3. Definition von „Angreifer-Erfolg“

Ein Red-Team-Test gilt als **erfolgreich**, wenn mindestens eines der folgenden Ziele erreicht wird:

- Offenlegung von Zugangsdaten im Klartext
- Lesbarkeit sensibler Inhalte (z. B. E-Mails, Login-Daten)
- Gewinn von Metadaten über Nutzeraktivitäten oder Zielsysteme
- Möglichkeit zur Weiterverwendung der gewonnenen Informationen (z. B. Replay)

---

## 4. Dokumentierte Red-Team-Testfälle

### RT-FTP-01 – FTP Credential Sniffing

**Zielsystem:** FTP-Server  
**Angriffsvektor:** Passives Mitschneiden von FTP-Verkehr  
**Relevanz:**  
FTP überträgt Authentifizierungsdaten standardmäßig unverschlüsselt. Dies stellt ein hohes Risiko dar, insbesondere in internen Netzen.

**Erwartetes Ergebnis (Angreifer-Sicht):**  
Benutzername und Passwort sind im Netzwerkverkehr im Klartext sichtbar.

**Beobachtetes Ergebnis:**  
Die FTP-Kommandos `USER` und `PASS` waren vollständig im Netzwerkverkehr lesbar. Die Authentifizierung konnte eindeutig nachvollzogen werden.

**Status:** Erfolgreich  
**Blue-Team-Referenz:** BT-FTP-01

---

### RT-HTTP-01 – HTTP POST Credential Exposure

**Zielsystem:** HTTP-Webserver (Login-Seite)  
**Angriffsvektor:** Analyse von HTTP POST Requests  
**Relevanz:**  
Login-Formulare ohne TLS führen zur Offenlegung sensibler Daten im Klartext.

**Erwartetes Ergebnis:**  
Login-Daten sind im HTTP-Body sichtbar.

**Beobachtetes Ergebnis:**  
Benutzername und Passwort konnten durch Rekonstruktion des TCP-Streams vollständig ausgelesen werden.

**Status:** Erfolgreich  
**Blue-Team-Referenz:** BT-HTTP-01

---

### RT-SMTP-01 – SMTP Plaintext Mail Interception

**Zielsystem:** SMTP-Server  
**Angriffsvektor:** Mitschneiden von SMTP-Kommunikation  
**Relevanz:**  
Unverschlüsseltes SMTP ermöglicht das Mitlesen von E-Mail-Inhalten und Metadaten.

**Erwartetes Ergebnis:**  
Header und Body der E-Mail sind lesbar.

**Beobachtetes Ergebnis:**  
Die vollständige SMTP-Konversation inklusive Inhalt der E-Mail war im Klartext sichtbar.

**Status:** Erfolgreich  
**Blue-Team-Referenz:** BT-SMTP-01

---

### RT-DNS-01 – DNS Intelligence Gathering

**Zielsystem:** DNS-Server  
**Angriffsvektor:** Analyse von DNS-Queries  
**Relevanz:**  
DNS-Anfragen verraten Zielsysteme, Dienste und Nutzerverhalten.

**Erwartetes Ergebnis:**  
Abgefragte Domains sind sichtbar.

**Beobachtetes Ergebnis:**  
Alle DNS-Queries und Responses waren im Klartext nachvollziehbar und erlaubten Rückschlüsse auf das Kommunikationsverhalten.

**Status:** Erfolgreich  
**Blue-Team-Referenz:** BT-DNS-01

---

### RT-AUTH-01 – Credential Replay Feasibility

**Zielsystem:** Mehrere Dienste  
**Angriffsvektor:** Wiederverwendung abgefangener Zugangsdaten  
**Relevanz:**  
Abgefangene Credentials ermöglichen Folgeangriffe ohne weitere Exploits.

**Erwartetes Ergebnis:**  
Abgefangene Zugangsdaten sind prinzipiell wiederverwendbar.

**Beobachtetes Ergebnis:**  
Die gewonnenen Zugangsdaten konnten theoretisch für erneute Authentifizierungsversuche genutzt werden, da keine zusätzlichen Schutzmechanismen vorhanden waren.

**Status:** Erfolgreich  
**Blue-Team-Referenz:** BT-AUTH-01

---

## 5. Zusammenfassung

Die Red-Team-Tests zeigen deutlich, dass unsichere Protokolle bereits durch **reines Beobachten des Netzwerkverkehrs** erhebliche Informationen preisgeben.  
Diese Ergebnisse bilden die Grundlage für die nachfolgenden Blue-Team-Maßnahmen zur Härtung der Umgebung und dienen als Referenz für die spätere Validierung der Sicherheitsmaßnahmen.
