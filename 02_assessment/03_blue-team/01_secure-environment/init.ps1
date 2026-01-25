$ErrorActionPreference = "Stop"

Write-Host "=== Blue-Team Secure Lab Init (Windows) ==="

if (-not (Get-Command docker -ErrorAction SilentlyContinue)) {
    throw "Docker not found. Start Docker Desktop first."
}

$ROOT = (Get-Location).Path
Write-Host "Project root: $ROOT"

# Create required directories
$dirs = @(
    "certs\nginx",
    "certs\postfix",
    "secrets",
    "sftp\keys",
    "unbound"
)

foreach ($d in $dirs) {
    $p = Join-Path $ROOT $d
    if (-not (Test-Path $p)) {
        New-Item -ItemType Directory -Path $p | Out-Null
        Write-Host "[+] Created $d"
    }
}

function Assert-File($path) {
    if (-not (Test-Path $path)) {
        throw "Expected file not found: $path"
    }
}

Write-Host "[+] Generating HTTPS certificate (nginx)"
docker run --rm -v "${ROOT}\certs\nginx:/out" alpine:3.20 sh -lc `
  "apk add --no-cache openssl >/dev/null && \
   openssl req -x509 -newkey rsa:4096 -nodes \
     -keyout /out/server.key \
     -out /out/server.crt \
     -days 365 \
     -subj '/CN=secure-web' >/dev/null"

Assert-File (Join-Path $ROOT "certs\nginx\server.key")
Assert-File (Join-Path $ROOT "certs\nginx\server.crt")
Write-Host "    OK: certs\nginx\server.(key|crt)"

Write-Host "[+] Generating SMTP certificate (postfix)"
docker run --rm -v "${ROOT}\certs\postfix:/out" alpine:3.20 sh -lc `
  "apk add --no-cache openssl >/dev/null && \
   openssl req -x509 -newkey rsa:4096 -nodes \
     -keyout /out/server.key \
     -out /out/server.crt \
     -days 365 \
     -subj '/CN=secure-mail' >/dev/null"

Assert-File (Join-Path $ROOT "certs\postfix\server.key")
Assert-File (Join-Path $ROOT "certs\postfix\server.crt")
Write-Host "    OK: certs\postfix\server.(key|crt)"

Write-Host "[+] Generating SFTP SSH keys"
docker run --rm -v "${ROOT}\sftp\keys:/out" alpine:3.20 sh -lc `
  "apk add --no-cache openssh >/dev/null && \
   rm -f /out/client_key /out/client_key.pub && \
   ssh-keygen -t ed25519 -f /out/client_key -N '' >/dev/null"

Assert-File (Join-Path $ROOT "sftp\keys\client_key")
Assert-File (Join-Path $ROOT "sftp\keys\client_key.pub")
Write-Host "    OK: sftp\keys\client_key(.pub)"

Write-Host "[+] Generating DNSSEC root.key (unbound-anchor inside container)"
docker run --rm -v "${ROOT}\unbound:/out" mvance/unbound:latest sh -lc `
  "unbound-anchor -a /out/root.key >/dev/null"

Assert-File (Join-Path $ROOT "unbound\root.key")
Write-Host "    OK: unbound\root.key"

Write-Host "=== Init complete ==="
Write-Host "Next: docker compose up -d"
