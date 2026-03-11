# AOXCON Program Topology (3 dApp + 1 Governance/CLI Repo)

Bu doküman AOXCON ekosisteminin "tek protokol, çok proje" yaklaşımını tanımlar.

## 1) Hedef Topoloji

Toplamda 4 depo hedeflenir:

1. **dApp-1 (EVM odaklı DAO uygulaması)**
2. **dApp-2 (Move odaklı DAO uygulaması)**
3. **dApp-3 (Cardano/Plutus odaklı DAO uygulaması)**
4. **AOXCON Yönetim Deposu (orchestrator + CLI + panel arayüzü)**

AOXCON yönetim deposu, XLayer benzeri çok-zincir operasyon mantığını merkezi olmayan kurallarla koordine eder.

## 2) Repo Rolleri

### dApp depoları (3 adet)

Her dApp aşağıdaki ortak bileşenleri taşır:

- DAO yönetişim modülü (proposal, vote, execution),
- AOXCON uyumlu envelope üretimi ve tüketimi,
- chain-native adapter katmanı,
- canonical event/code map (AOXCON status/error ile birebir).

### AOXCON yönetim deposu (4. depo)

Zorunlu alt modüller:

- **Control Plane API**: ağlar arası komut/konfigürasyon yayınlama,
- **CLI**: operatör ve DAO temsilcileri için scriptable yönetim katmanı,
- **Relayer Orchestrator**: kuyruk, retry, proof lifecycle,
- **Governance Bridge**: zincirlerdeki DAO kararlarını normalize edip diğer zincirlere taşır,
- **Observability**: audit log + conformance raporu + alarm.

## 3) DAO Modeli (Her proje DAO gibi)

Her proje kendi DAO'suna sahip olabilir; ancak AOXCON seviyesinde şu kural geçerlidir:

- Lokal DAO kararı => `GovernanceEnvelope` olarak AOXCON'a aktarılır.
- AOXCON, kararın doğruluğunu/versiyonunu/doğrulama kanıtını kontrol eder.
- Hedef dApp DAO'su kararı kendi chain mantığına göre uygular.

Bu modelde:

- Yerel özerklik korunur,
- Protokol düzeyinde deterministik eşdeğerlik sağlanır,
- Çok-zincir yönetişimde audit izi kaybolmaz.

## 4) CLI Kapsamı

Önerilen CLI komutları:

- `aoxcon init` → proje bootstrap
- `aoxcon env validate` → envelope/proof doğrulama
- `aoxcon relay run` → relayer daemon başlatma
- `aoxcon dao submit` → DAO proposal yayını
- `aoxcon dao tally` → zincirler arası oy/sonuç mutabakatı
- `aoxcon treasury reconcile` → FNT hazine uzlaştırma

## 5) Protokol Uyumluluk Kuralları

Tüm depolar için non-negotiable alanlar:

- Envelope sıralı doğrulama adımları aynı olmalı,
- Error/status code sözlüğü aynı olmalı,
- Nonce/replay politikası aynı olmalı,
- DAO event semantiği aynı canonical event'e bağlanmalı.

## 6) Üretim Hazırlık Ölçütleri

- Conformance test vektörleri tüm depolarda yeşil,
- Güvenlik baseline maddeleri CI policy olarak enforce,
- Relayer için disaster-recovery runbook hazır,
- DAO emergency pause + timelock + multisig süreçleri tanımlı,
- Audit evidence paketleri sürüm bazlı arşivlenmiş.
