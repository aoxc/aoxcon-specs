# AOXCON — Multi-Repo Interop Program (EVM + Move + Cardano)

AOXCON, çok-zincirli sistemlerde **tek protokol davranışı** sağlayan deterministik bir birlikte çalışabilirlik (interoperability) çekirdeğidir.

Bu depo bir uygulama reposu değil; tüm alt depoların aynı kurallarla ilerlemesini sağlayan **normatif spesifikasyon ve referans davranış** kaynağıdır.

## Program vizyonu

AOXCON ile hedeflenen model:

- 3 ayrı dApp (her biri DAO mantığıyla),
- 1 merkezi olmayan yönetim/orchestration deposu (CLI + panel + relayer control plane),
- zincir fark etmeksizin aynı envelope, aynı hata kodu, aynı geçiş semantiği.

Detaylı hedef topoloji: [Program Topology](docs/portfolio-topology.md).

## Ekosistem yapısı (önerilen)

### dApp katmanı (3 depo)

1. `aoxcon-evm` — EVM DAO dApp
2. `aoxcon-move` — Move DAO dApp
3. `aoxcon-cardano` — Cardano/Plutus DAO dApp

### Yönetim katmanı (4. depo)

4. `aoxcon-control` — AOXCON yönetim deposu
   - CLI
   - Operasyon paneli
   - Relayer orchestrator
   - Governance bridge

> Amaç: Her proje DAO gibi çalışırken, AOXCON protokolü bunların arası iletişimi deterministik ve denetlenebilir şekilde standardize eder.

## Bu depoda ne var?

- canonical protocol data modelleri,
- deterministic state machine kuralları,
- cross-chain envelope doğrulama sözleşmesi,
- adapter compatibility contract,
- relayer davranış sözleşmesi,
- security baseline + audit checklist,
- conformance matrix.

## Doküman haritası

### Foundation
- [System Overview](docs/system-overview.md)
- [Core Architecture](docs/core-architecture.md)
- [Protocol State Machine](docs/protocol-state-machine.md)
- [Glossary](docs/glossary.md)

### Interoperability
- [Message Specification](docs/message-spec.md)
- [Relayer Specification](docs/relayer-spec.md)
- [Compatibility Contract](docs/compatibility-contract.md)
- [Implementation Language Strategy](docs/implementation-language-strategy.md)
- [Cardano Haskell Integration Blueprint](docs/cardano-haskell-reference.md)
- [Program Topology (3 dApp + 1 control repo)](docs/portfolio-topology.md)

### Security / Audit / Quality
- [Security Baseline](docs/security-baseline.md)
- [Conformance Test Matrix](docs/conformance-test-matrix.md)
- [Audit Conformance Checklist](docs/audit-conformance-checklist.md)

### Productization
- [SDK Specification](docs/sdk-spec.md)
- [Roadmap](docs/roadmap.md)
- [Governance](docs/governance.md)
- [Whitepaper (Markdown)](docs/whitepaper.md)
- [Whitepaper (PDF)](docs/whitepaper.pdf)

## Referans implementasyonlar

### Python deterministic kernel

- `src/aoxcon_ref/` (envelope + state machine)
- `tests/` (protokol davranış testleri)

```bash
PYTHONPATH=src python -m unittest discover -s tests -v
```

### Haskell / Cardano uyumluluk referansı

- `haskell/aoxcon-cardano-ref/src/Aoxcon/Envelope.hs`
- `haskell/aoxcon-cardano-ref/src/Aoxcon/StateMachine.hs`
- `haskell/aoxcon-cardano-ref/src/Aoxcon/FNTTreasury.hs`
- `haskell/aoxcon-cardano-ref/test/Spec.hs`

```bash
cd haskell/aoxcon-cardano-ref
cabal test
```

## Üretime uygunluk prensibi

Bir depo AOXCON uyumlu sayılmak için minimumda şunları sağlamalıdır:

1. Canonical error/status kodlarını bozmaz.
2. Replay/nonce/idempotency kurallarını birebir uygular.
3. Conformance vektörlerini geçirir.
4. Audit evidence üretir (sürüm bazlı).
5. Security baseline kontrollerini CI politikası haline getirir.

## Normatif dil

**MUST**, **MUST NOT**, **SHOULD**, **MAY** terimleri RFC 2119 anlamıyla kullanılır.

## Değişiklik politikası

- Normatif değişiklikler PR review gerektirir.
- Her davranış değişikliği SemVer etkisi belirtir.
- Güvenlik etkili değişiklikler aynı değişim setinde security + conformance dokümanlarını günceller.

## Lisans

[Lisans](LICENSE)
