# Docker – Dokumentation der Simulated Environment Automation

Dieses Dokument beschreibt, wie die simulierte Docker-Umgebung automatisiert betrieben wird.  
Der Fokus liegt auf **Bedienbarkeit, Wiederholbarkeit und Verständlichkeit**, nicht auf der technischen Implementierung der einzelnen Dienste oder auf sicherheitsrelevanten Angriffen.

Die Automation stellt sicher, dass das Labor jederzeit **konsistent**, **reproduzierbar** und **einfach** gestartet werden kann – ein zentraler Punkt für Demonstrationen, Videoaufzeichnungen und forensische Analysen.

---

## 1. Ziel der Automatisierung

Die simulierte Netzwerkumgebung besteht aus mehreren Containern, die gemeinsam ein unsicheres Netzwerk abbilden.  
Ohne Automation wäre der manuelle Start und Stopp dieser Umgebung fehleranfällig und zeitaufwendig.

Die Automatisierung verfolgt folgende Ziele:

- Einheitlicher Start und Stopp aller Dienste
- Reproduzierbare Testbedingungen
- Schnelle Erzeugung von Netzwerktraffic
- Reduktion manueller Fehler
- Klare Trennung zwischen Betrieb und Analyse

Durch die Verwendung eines Makefiles und eines Traffic-Generator-Skripts wird der gesamte Ablauf standardisiert.

---

## 2. Rolle des Makefiles

Das Makefile dient als **zentrale Steuereinheit** für alle Docker-bezogenen Aufgaben.  
Anstatt mehrere `docker compose`-Befehle manuell auszuführen, werden diese in klar benannte Targets abstrahiert.

Vorteile dieses Ansatzes:

- Einfache Bedienung auch für Einsteiger
- Konsistente Befehlsnamen
- Geringere Fehlerquote
- Bessere Dokumentierbarkeit des Workflows

Das Makefile wird aus dem Docker-Root-Verzeichnis ausgeführt und steuert alle relevanten Container und Netzwerke.

---

## 3. Dokumentation der Makefile-Targets

### 3.1 `make up`

**Zweck:**  
Startet alle benötigten Container der simulierten Umgebung.

**Erwartetes Verhalten:**
- Docker-Netzwerk wird erstellt (falls nicht vorhanden)
- Alle Dienste (FTP, HTTP, SMTP, DNS, Client) werden gestartet
- Container sind im vorgesehenen Subnetz erreichbar

**Typische Nutzung:**  
Startpunkt für jede Analyse oder Demonstration.

---

### 3.2 `make down`

**Zweck:**  
Stoppt und entfernt alle laufenden Container der Umgebung.

**Erwartetes Verhalten:**
- Container werden sauber gestoppt
- Keine aktiven Services verbleiben

**Typische Nutzung:**  
Nach Abschluss einer Analyse oder zur Vorbereitung eines sauberen Neustarts.

---

### 3.3 `make rebuild`

**Zweck:**  
Erzwingt den Neuaufbau der Container.

**Erwartetes Verhalten:**
- Container werden neu erstellt
- Änderungen an Images oder Konfigurationen werden übernommen

**Typische Nutzung:**  
Nach Konfigurationsänderungen oder Image-Anpassungen.

---

### 3.4 `make traffic`

**Zweck:**  
Erzeugt definierten Netzwerktraffic innerhalb der Umgebung.

**Erwartetes Verhalten:**
- Das Traffic-Generator-Skript wird im Client-Container ausgeführt
- Es entstehen reproduzierbare FTP-, HTTP-, SMTP- und DNS-Verbindungen
- Der erzeugte Traffic kann direkt mit Wireshark aufgezeichnet werden

**Typische Nutzung:**  
Während eines laufenden Captures, um gezielt analysierbaren Traffic zu erzeugen.

---

### 3.5 `make logs`

**Zweck:**  
Zeigt Logs aller beteiligten Container an.

**Erwartetes Verhalten:**
- Zusammengefasste Ausgabe der Service-Logs
- Hilfreich zur Kontrolle, ob Dienste korrekt laufen

**Typische Nutzung:**  
Fehlersuche oder Verifikation des Systemzustands.

---

### 3.6 `make clean`

**Zweck:**  
Bereinigt die Umgebung vollständig.

**Erwartetes Verhalten:**
- Container werden entfernt
- Images und Netzwerke werden gelöscht
- Umgebung ist vollständig zurückgesetzt

**Typische Nutzung:**  
Vor einer Neuinstallation oder bei Problemen mit dem Docker-Zustand.

---

## 4. Traffic-Generator-Skript (`generate-traffic.sh`)

### 4.1 Zweck des Skripts

Das Skript dient dazu, **kontrollierten und vorhersehbaren Netzwerktraffic** zu erzeugen.  
Dieser Traffic bildet die Grundlage für forensische Analysen und Demonstrationen in Wireshark.

Ohne ein solches Skript wären die Tests:
- unstrukturiert
- schwer reproduzierbar
- abhängig von manuellen Eingaben

---

### 4.2 Erzeugte Protokolle

Das Skript initiiert gezielt:

- FTP Login und Dateiübertragung
- HTTP POST Request (Login-Simulation)
- SMTP Mailversand
- DNS-Anfragen

Jede dieser Aktionen ist klar getrennt und nachvollziehbar, sodass die entstehenden Netzwerkpakete eindeutig zugeordnet werden können.

---

### 4.3 Bedeutung für Forensik und Lehre

Automatisch erzeugter Traffic ist besonders wertvoll, weil:

- alle Analysen reproduzierbar sind
- Studierende wissen, **wonach sie suchen sollen**
- PCAPs konsistent aufgebaut sind
- Vergleich zwischen unsicherer und gesicherter Umgebung möglich ist

Dies ist essenziell für eine saubere forensische Auswertung.

---

## 5. Empfohlener Workflow

Ein typischer, bewährter Ablauf für Analyse oder Videoaufzeichnung:

1. Umgebung starten  
   → `make up`

2. Wireshark Capture starten  
   → korrektes Interface auswählen

3. Traffic erzeugen  
   → `make traffic`

4. Capture stoppen und speichern  
   → PCAP sauber benennen

5. Umgebung stoppen oder bereinigen  
   → `make down` oder `make clean`

Dieser Workflow stellt sicher, dass jede Analyse unter identischen Bedingungen durchgeführt wird.

---

## 6. Abgrenzung: Automation vs. Angriff

Die hier beschriebene Automation:
- **vereinfacht den Betrieb**
- **unterstützt Analyse und Lehre**
- **führt keine Angriffe aus**

Sie stellt lediglich die technische Grundlage bereit, auf der spätere Red- und Blue-Team-Aktivitäten aufbauen.

---

## 7. Zusammenfassung

Die Automatisierung der simulierten Docker-Umgebung ist ein zentraler Bestandteil des Projekts.  
Sie sorgt für Stabilität, Wiederholbarkeit und Effizienz und ermöglicht eine saubere Trennung zwischen Infrastruktur, Analyse und Dokumentation.

Durch Makefile und Traffic-Generator ist das Labor jederzeit mit wenigen Befehlen einsatzbereit – ein entscheidender Faktor für eine professionelle forensische Arbeitsweise.
