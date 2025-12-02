 #!/bin/bash

echo "==============================================="
echo "      Unicity Alpha Miner – Docker Setup       "
echo "==============================================="
echo ""

# --- Krok 1: zapytaj o adres portfela ---
read -p "Podaj adres swojego portfela Alpha (alpha1q...): " WALLET

if [ -z "$WALLET" ]; then
    echo "Nie podano adresu portfela. Przerywam."
    exit 1
fi

echo ""
echo "Używam portfela: $WALLET"
echo ""

# --- Krok 2: sprawdzenie czy Docker już jest ---
if command -v docker &> /dev/null
then
    echo "Docker jest już zainstalowany. Pomijam instalację."
else
    echo "Docker nie jest zainstalowany – instaluję..."

    apt update -y
    apt install -y ca-certificates curl gnupg lsb-release

    install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.gpg
    chmod a+r /etc/apt/keyrings/docker.gpg

    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
      $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
      tee /etc/apt/sources.list.d/docker.list > /dev/null

    apt update -y
    apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

    echo "Docker został pomyślnie zainstalowany."
fi

echo ""

# --- Krok 3: katalog na minera ---
mkdir -p /root/alpha-miner
cd /root/alpha-miner

# --- Krok 4: docker-compose.yml zgodny z README alpha-miner ---
cat <<EOF > docker-compose.yml
services:
  alpha-miner:
    image: ghcr.io/unicitynetwork/alpha-miner:latest
    container_name: alpha-miner
    restart: unless-stopped
    command: >
      -o stratum+tcp://unicity-pool.com:3054
      -u ${WALLET}
      --no-affinity
EOF

echo "Plik docker-compose.yml został przygotowany."
echo ""

# --- Krok 5: uruchomienie kopania ---
echo "Uruchamiam kontener z minerem..."
docker compose down 2>/dev/null || true
docker compose up -d

echo ""
echo "==============================================="
echo "  Kopanie Alpha próbuje wystartować."
echo "  docker ps           – status kontenera"
echo "  docker logs -f alpha-miner   – logi minera"
echo "==============================================="
