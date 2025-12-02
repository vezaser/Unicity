🪙 Unicity Alpha Miner – Docker Setup

Ten projekt zawiera w pełni automatyczny skrypt, który uruchamia kopanie kryptowaluty Alpha (Unicity Network) w kontenerze Docker.

Skrypt:
	•	wykrywa, czy Docker jest zainstalowany (jeśli nie – instaluje),
	•	tworzy katalog alpha-miner/,
	•	generuje plik docker-compose.yml,
	•	uruchamia minera w tle,
	•	łączy się z oficjalnym poolem.

Działa na Ubuntu 20.04 / 22.04 / 24.04.

⸻

📦 Wymagania
	•	Ubuntu 20.04 / 22.04 / 24.04
	•	CPU z minimum 4 rdzeniami (RandomX = kopanie CPU)
	•	Stałe połączenie internetowe
	•	Uprawnienia root
	•	Adres portfela Alpha (UQ1…)

⸻

🚀 Instalacja i uruchomienie

1️⃣ Pobierz skrypt (RAW)

wget -O alpha_docker_miner.sh \
  https://raw.githubusercontent.com/vezaser/Unicity/main/alpha_docker_miner.sh

2️⃣ Nadaj uprawnienia

chmod +x alpha_docker_miner.sh

3️⃣ Uruchom

./alpha_docker_miner.sh

