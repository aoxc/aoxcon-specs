# Core Architecture

## 1) Katmanlar

AOXCON mimarisi 4 ana katmandan oluşur:

1. **Domain Core**
   - Zincir bağımsız iş kuralları
   - Durum makinesi ve geçiş kuralları

2. **Chain Adapter**
   - EVM / Move / Cardano için uygulama farkları
   - Event ve storage eşleştirmesi

3. **Verification & Relayer**
   - Mesaj taşıma
   - Kanıt doğrulama
   - Tekrar saldırısı engelleme

4. **SDK & API**
   - DApp/backend için standart istemci
   - Zincirler arası tek API yüzeyi

## 2) Domain Çekirdeği

Temel varlıklar:

- `Actor` (kullanıcı/servis)
- `AssetRef` (zincir üzerinde varlık referansı)
- `Action` (işlem niyeti)
- `Proof` (doğrulama kanıtı)
- `StateCommitment` (durum özeti/hash)

Durum geçişi örneği:

`Initialized -> Pending -> Verified -> Finalized`

Her geçişte:
- Girdi doğrulaması
- Yetki kontrolü
- Nonce güncellemesi
- Olay (event) üretimi

## 3) Zincir Adaptör Stratejisi

### EVM
- ABI sabitliği
- Event topic standardı
- Reentrancy koruması

### Move
- Resource güvenliği
- Capability tabanlı yetki
- Deterministik module API

### Cardano
- eUTxO datum/redeemer modeli
- Script context doğrulamaları
- UTxO tüketim kuralları

## 4) Veri Akışı

1. Uygulama `Action` üretir.
2. Kaynak zincirde adapter aksiyonu işler ve event çıkarır.
3. Relayer event'i alır, canonical mesaja dönüştürür.
4. Hedef zincirde mesaj doğrulanır.
5. Domain state yeni duruma geçer ve final event yazılır.

## 5) Tasarım Kısıtları

- Her kritik event'te `message_id` zorunlu
- Bütün adapterlerde ortak hata kodları
- Mesaj boyutu limitleri (DoS koruması)
- Saat/zaman penceresi toleransı açık belirtilmeli
