# Security Baseline

## Kritik Kontroller

1. Replay koruması (`nonce`, `message_id`)
2. İmza/kanıt doğrulama
3. Yetki ayrımı ve rol yönetimi
4. Zaman penceresi (`not_before`, `expiry`)
5. Durum geçiş doğrulama (illegal transition engeli)
6. Rate limit / message size limiti
7. Acil durdurma (`pause`) ve güvenli devam prosedürü

## Zincir-Özel Notlar

### EVM
- Reentrancy guard
- CEI (checks-effects-interactions)
- Upgradeable proxy risk analizi

### Move
- Capability sızıntısı kontrolü
- Resource duplication engeli

### Cardano
- Datum/redeemer doğrulama kapsamı
- UTxO race condition modellemesi

## Operasyonel Güvenlik

- Anahtar rotasyonu
- Relayer çoklu imza desteği
- Denetim loglarının değişmez saklanması
