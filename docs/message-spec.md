# Cross-Chain Message Spec

## Envelope v1

```json
{
  "version": "1.0.0",
  "message_id": "0x...",
  "source_chain": "evm:1",
  "target_chain": "cardano:mainnet",
  "source_contract": "0x...",
  "target_app": "aoxcon-core",
  "nonce": 1024,
  "timestamp": 1710000000,
  "payload_hash": "0x...",
  "proof_type": "merkle|sigset|lightclient",
  "proof": "base64..."
}
```

## Kurallar

- `message_id`: global benzersiz olmalı
- `nonce`: kaynak + aktör bazında monoton artmalı
- `timestamp`: geçerlilik penceresi içinde olmalı
- `payload_hash`: hedefte tekrar hesaplanıp karşılaştırılmalı
- `proof`: zincire özel ama doğrulama sonucu standart hata kodlarına map edilir

## Idempotency

Hedef zincirde `message_id` daha önce işlendi ise işlem **başarılı-noop** olarak sonuçlanmalı.

## Hata Kodları

- `ERR_INVALID_NONCE`
- `ERR_STALE_MESSAGE`
- `ERR_INVALID_PROOF`
- `ERR_UNAUTHORIZED_ACTOR`
- `ERR_ALREADY_PROCESSED`
