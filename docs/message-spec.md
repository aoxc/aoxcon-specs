# Cross-Chain Message Specification (Normative)

## 1. Canonical Envelope v1

```json
{
  "version": "1.0.0",
  "message_id": "0x...",
  "source_chain": "evm:1",
  "target_chain": "cardano:mainnet",
  "source_app": "0x...",
  "target_app": "aoxcon-core",
  "actor_id": "did:aoxcon:...",
  "nonce": 1024,
  "timestamp": 1710000000,
  "not_before": 1710000000,
  "expiry": 1710003600,
  "payload_hash": "0x...",
  "proof_type": "merkle|sigset|lightclient",
  "proof": "base64..."
}
```

## 2. Field requirements

- `version`: semantic version for envelope schema.
- `message_id`: globally unique immutable id.
- `source_chain` / `target_chain`: canonical namespace identifiers.
- `nonce`: monotonically increasing per `(source_chain, actor_id)`.
- `timestamp`: creation timestamp at source system.
- `not_before` / `expiry`: validity window.
- `payload_hash`: hash of canonical payload bytes.
- `proof_type`: verifier strategy class.
- `proof`: serialized proof bytes.

## 3. Canonical processing algorithm

1. Validate envelope schema and required fields.
2. Enforce time window (`not_before <= now <= expiry`).
3. Check replay controls (`message_id`, `nonce`).
4. Recompute payload hash and compare.
5. Validate proof under `proof_type`.
6. Validate authorization and policy constraints.
7. Apply deterministic state transition.
8. Emit required events.
9. Mark message as processed.

## 4. Idempotency and replay policy

If `message_id` is already processed, the system MUST return success-noop with `ERR_ALREADY_PROCESSED` semantics and MUST NOT apply state changes again.

If nonce is stale or non-monotonic, the system MUST reject with `ERR_INVALID_NONCE`.

## 5. Canonical status / error codes

- `OK_PROCESSED`
- `OK_ALREADY_PROCESSED`
- `ERR_INVALID_SCHEMA`
- `ERR_INVALID_NONCE`
- `ERR_STALE_MESSAGE`
- `ERR_EXPIRED_MESSAGE`
- `ERR_INVALID_PROOF`
- `ERR_UNAUTHORIZED_ACTOR`
- `ERR_INVALID_STATE_TRANSITION`
- `ERR_PROCESSING_FAILED`

## 6. Hashing and canonicalization

Implementations MUST document canonical payload serialization rules. Any chain-specific binary format MUST map deterministically to canonical payload bytes prior to hashing.
