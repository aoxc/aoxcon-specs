# AOXCON Protocol Specifications

AOXCON is a full, audit-oriented protocol specification for a deterministic interoperability kernel across:

- **EVM ecosystems**
- **Move ecosystems**
- **Cardano (eUTxO)**

This repository is the **single normative source of truth** for AOXCON behavior.

## Scope

This repository defines:

- canonical protocol data models,
- deterministic state machine and transition invariants,
- cross-chain message envelope and verification rules,
- adapter compatibility contract,
- relayer operating contract,
- security baseline and threat expectations,
- conformance requirements and audit evidence format.

## Implementation repositories

- `aoxcon-core`
- `aoxcon-evm`
- `aoxcon-move`
- `aoxcon-cardano`
- `aoxcon-relayer`
- `aoxcon-sdk`

## Document map

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

### Security, Audit, Quality
- [Security Baseline](docs/security-baseline.md)
- [Conformance Test Matrix](docs/conformance-test-matrix.md)
- [Audit Conformance Checklist](docs/audit-conformance-checklist.md)

### Productization
- [SDK Specification](docs/sdk-spec.md)
- [Roadmap](docs/roadmap.md)
- [Governance](docs/governance.md)
- [Whitepaper (Markdown)](docs/whitepaper.md)
- [Whitepaper (PDF)](docs/whitepaper.pdf)


## Reference implementation (code)

This repository now includes a minimal executable reference implementation under `src/aoxcon_ref/` with deterministic envelope processing and state transitions, plus tests under `tests/`.

Run locally:

```bash
PYTHONPATH=src python -m unittest -v
```

## Normative language

Terms **MUST**, **MUST NOT**, **SHOULD**, and **MAY** are interpreted as in RFC 2119.

## Change policy

- Normative changes require pull request review.
- Every behavior change must declare SemVer impact.
- Security-impacting changes MUST update security and conformance docs in the same change set.
- Conformance matrix MUST be updated when new error/status behavior is introduced.

## License

See [LICENSE](LICENSE).
=======
# AOXCON Specs

AOXCON; **EVM, Move ve Cardano** ekosistemleriyle yerel uyumlu çalışan, çok-zincirli bir çekirdek protokol ve geliştirici standardı tanımıdır.

Bu repo, uygulama kodu değil; farklı depoların aynı kurallarla ilerlemesini sağlayan **spesifikasyon kaynağıdır**.

## Vizyon

- EVM ağları (Ethereum, L2'ler, EVM sidechain'ler),
- Move tabanlı ağlar (Aptos/Sui benzeri modeller),
- Cardano ekosistemi (eUTxO + Plutus yaklaşımı)

için tek bir çekirdek domain modeli, ortak mesaj formatı, güvenlik prensipleri ve entegrasyon sözleşmeleri tanımlamak.

## Kapsam

AOXCON çekirdeği aşağıdaki depolar için “tek doğruluk kaynağı” olacak şekilde tasarlanır:

1. `aoxcon-core` → Domain modelleri ve protokol kuralları
2. `aoxcon-evm` → Solidity/EVM adaptörü
3. `aoxcon-move` → Move adaptörü
4. `aoxcon-cardano` → Plutus/Cardano adaptörü
5. `aoxcon-relayer` → Zincirler arası mesaj taşıma ve doğrulama katmanı
6. `aoxcon-sdk` → TypeScript/Rust SDK

> Bu repo, yukarıdaki tüm depoların referans aldığı teknik spesifikasyonları içerir.

## Çekirdek Tasarım İlkeleri

1. **Chain-agnostic Domain Core**
   - İş kuralları zincirden bağımsız tanımlanır.
   - Zincire özgü farklılıklar adaptör katmanına taşınır.

2. **Deterministik Mesajlaşma**
   - Zincirler arası mesajlar tek tip envelope ile tanımlanır.
   - Idempotent işleme ve replay koruması zorunludur.

3. **Doğrulanabilir Durum Geçişi**
   - Her kritik aksiyon için doğrulanabilir event/state delili üretilir.
   - Off-chain relayer davranışı denetlenebilir olmalıdır.

4. **Güvenlik Önceliği**
   - Yetki modeli, nonce yönetimi, imza doğrulama ve zaman pencereleri standarttır.
   - Zincir-özel güvenlik açıklarına karşı ayrı kontrol listesi bulunur.

5. **Sürüm Uyumluluğu**
   - SemVer ile sürümlenir.
   - Geriye dönük uyumluluk kuralları net tanımlanır.

## Doküman Haritası

- [Core Architecture](docs/core-architecture.md)
- [Cross-Chain Message Spec](docs/message-spec.md)
- [Compatibility Contract](docs/compatibility-contract.md)
- [Security Baseline](docs/security-baseline.md)
- [Roadmap](docs/roadmap.md)

## Hızlı Başlangıç

Yeni bir repo AOXCON uyumlu sayılması için:

1. `compatibility-contract.md` içindeki zorunlu interface ve event adlarını birebir uygulayın.
2. `message-spec.md` formatında mesaj üretip doğrulayın.
3. `security-baseline.md` maddelerinden kritik olanları CI'da test edin.
4. Bu repodaki sürüm numarasını bağımlılık metadata’sında belirtin.

## Katkı

- Değişiklikler PR ile yapılır.
- Her değişiklikte sürüm etkisi (`major`, `minor`, `patch`) açıklanır.
- Zincir-özel öneriler genel çekirdeği bozmayacak şekilde eklenir.
