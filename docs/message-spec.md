# Cross-Chain Message Specification (Normative)

## 1. Envelope schema v1

```json
{
  "version": "1.0.0",
  "message_id": "0x...",
  "source_chain": "evm:1",
  "target_chain": "move:aptos-mainnet",
  "source_app": "0x...",
  "target_app": "aoxcon-core",
  "actor_id": "did:aoxcon:actor:...",
  "nonce": 42,
  "timestamp": 1710000000,
  "not_before": 1710000000,
  "expiry": 1710003600,
  "payload_hash": "0x...",
  "proof_type": "merkle|sigset|lightclient",
  "proof": "base64..."
}
```

## 2. Mandatory validation order

1. schema validation,
2. chain namespace validation,
3. time window validation,
4. replay checks (`message_id` + nonce),
5. payload hash check,
6. proof verification,
7. authorization policy,
8. state transition execution.

## 3. Canonical codes

### Success
- `OK_PROCESSED`
- `OK_ALREADY_PROCESSED`

### Errors
- `ERR_INVALID_SCHEMA`
- `ERR_INVALID_CHAIN_ID`
- `ERR_INVALID_NONCE`
- `ERR_STALE_MESSAGE`
- `ERR_EXPIRED_MESSAGE`
- `ERR_INVALID_PROOF`
- `ERR_UNAUTHORIZED_ACTOR`
- `ERR_INVALID_STATE_TRANSITION`
- `ERR_PROCESSING_FAILED`

## 4. Idempotency rules

If a previously processed `message_id` is submitted again, implementation MUST:

- return success semantics as `OK_ALREADY_PROCESSED`,
- perform no new side effects,
- preserve previous completion record.
