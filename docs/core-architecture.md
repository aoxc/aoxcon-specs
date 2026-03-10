# Core Architecture (Normative)

## 1. Layered architecture

1. **Domain Layer**
   - Canonical entities, transitions, and policy checks.
2. **Adapter Layer**
   - Chain-specific encoding, storage and event mapping.
3. **Verification Layer**
   - Proof validation and trust model enforcement.
4. **Orchestration Layer**
   - Relayer workflows and delivery guarantees.
5. **Interface Layer**
   - SDK and API contracts.

## 2. Canonical entities

- `ActorId`
- `MessageId`
- `ChainId`
- `Envelope`
- `Payload`
- `ProofBundle`
- `ProcessResult`

## 3. Determinism contract

Given `(Envelope, Payload, ProofBundle, CurrentState)`, conforming implementations MUST produce equivalent:

- acceptance/rejection decision,
- status code,
- state transition,
- event semantics.

## 4. Adapter boundaries

Adapters MUST NOT alter core decision semantics. Adapter logic is limited to:

- chain-native serialization and decoding,
- chain-native persistence,
- chain-native event emission,
- runtime-specific failure handling mapped to canonical errors.

## 5. Persistence requirements

Implementations MUST atomically persist:

- processed marker,
- next nonce,
- resulting state,
- event emission metadata.
