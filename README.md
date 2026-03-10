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
