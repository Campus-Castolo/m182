# Blue-Team Secure Simulated Environment (Hardened)

This stack replaces the insecure Red-Team lab with **encrypted-only** services and container hardening.

## What’s secured

- **FTP → SFTP (SSH, key auth only)**: no passwords, no plaintext.
- **HTTP → HTTPS-only**: TLS-only (self-signed CA acceptable for lab).
- **SMTP → STARTTLS-required / SMTPS**: TLS required + auth required (secrets).
- **DNS → DNSSEC-validating resolver**: Unbound with DNSSEC validation + DoT upstreams.
- **Client baseline**: non-root, no extra caps, generates encrypted traffic.
- **Container hardening**: cap-drop, no-new-privileges, read-only, tmpfs, resource limits.
- **Network isolation**: separate networks per service + dedicated capture-net.

## Quickstart

1) Install prerequisites on host:
- Docker + Docker Compose v2
- `openssl`, `ssh-keygen`
- `unbound-anchor` (to generate the DNSSEC trust anchor `root.key`)

2) Initialize PKI + keys

```bash
make init
```

3) Build + start

```bash
make up
```

4) Run the encrypted traffic generator (client)

```bash
make test
```

## Access

- HTTPS page: https://127.0.0.1:8443/  (self-signed; browser warning expected)
- SFTP (from host): `sftp -P 2222 -i ./pki/ssh/client_keys/demo demo@127.0.0.1`
- Wireshark UI: http://127.0.0.1:3000

## Wireshark validation

- You should **not** see credentials in plaintext.
- You should see TLS handshakes and encrypted payloads for web + SMTP.
- You should see SSH for SFTP.

## Notes

- The Wireshark container needs `NET_ADMIN` and `NET_RAW` to capture packets. Everything else runs with minimal privileges.
