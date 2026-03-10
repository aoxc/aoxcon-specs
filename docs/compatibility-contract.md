# Compatibility Contract

Bu doküman, diğer AOXCON depolarının bu repo ile tam uyumlu olması için zorunlu sözleşmeyi tanımlar.

## 1) Zorunlu Interface Alanları

Her adapter aşağıdaki alanları expose etmelidir:

- `protocolVersion() -> string`
- `domainSeparator() -> bytes32`
- `processMessage(envelope, payload, proof) -> result`
- `isProcessed(message_id) -> bool`

## 2) Zorunlu Event'ler

- `MessageQueued(message_id, source_chain, target_chain)`
- `MessageVerified(message_id, verifier, proof_type)`
- `MessageProcessed(message_id, status_code)`

## 3) Deterministik Davranış Şartı

Aynı giriş için aynı sonucu üretme zorunludur.

- Zincirler arası farklar yalnızca adapter seviyesinde kalmalı.
- Domain kararları (izin/ret) chain-agnostic kurallara göre verilmelidir.

## 4) Sürüm Eşleştirme

- Major sürüm farklıysa uyumsuz kabul edilir.
- Minor farkı için adapter geriye dönük alanları tolere etmelidir.
- Patch farkı davranış değiştirmemelidir.
