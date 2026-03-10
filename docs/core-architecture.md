# AOXCON Core Architecture (Normative)

## 1. Architecture layers

AOXCON uses a strict layered architecture.

1. **Domain Core Layer**
   - Defines protocol entities and state transition rules.
   - Must be independent of chain runtime details.

2. **Chain Adapter Layer**
   - Encodes/decodes chain-specific transactions, events and storage layout.
   - Must not change domain-level decision logic.

3. **Verification & Relayer Layer**
   - Watches source-chain evidence, assembles canonical messages, submits to target chain.
   - Provides witness/proof material required by target verifier.

4. **SDK/API Layer**
   - Provides application-facing APIs.
   - Must preserve canonical envelope and error semantics.

---

## 2. Canonical domain entities

- `ActorId`: globally unique actor identity reference.
- `ChainId`: canonical chain namespace (e.g., `evm:1`, `cardano:mainnet`, `move:aptos-mainnet`).
- `MessageId`: globally unique immutable identifier.
- `Action`: chain-agnostic requested operation.
- `ProofBundle`: proof/witness package for validation.
- `StateCommitment`: hash commitment to protocol state.

### 2.1 State machine

Canonical flow:

`Initialized -> Queued -> Verified -> Executed -> Finalized`

Failed flow:

`Queued -> Rejected` or `Verified -> FailedExecution`

Illegal transitions are forbidden and MUST return `ERR_INVALID_STATE_TRANSITION`.

---

## 3. Determinism requirements

For the same tuple `(envelope, payload, proof, current_state)` each implementation MUST output:

1. identical acceptance/rejection result,
2. identical status code,
3. identical state transition,
4. semantically equivalent emitted event set.

Adapters may differ in encoding details, but not in decision outcomes.

---

## 4. Chain adapter responsibilities

### 4.1 EVM adapter
- Stable ABI surface for required interfaces.
- Event signatures fixed across major versions.
- Reentrancy-safe processing path.

### 4.2 Move adapter
- Resource-safe storage model for processed messages.
- Capability-scoped admin and verifier actions.
- Deterministic module API semantics.

### 4.3 Cardano adapter
- Datum/redeemer layout versioning.
- eUTxO constraints for one-time processing of `message_id`.
- Script context validation for signer/time/nonce constraints.

---

## 5. Cross-repository compatibility model

- `aoxcon-core` owns normative state machine behavior.
- Adapter repositories MUST implement the same state and status semantics.
- `aoxcon-relayer` MUST produce canonical envelope fields and preserve source evidence.
- SDKs MUST expose canonical error codes without lossy remapping.

---

## 6. Non-functional requirements

- Message processing complexity MUST be bounded.
- Maximum envelope size and payload size MUST be enforced.
- All critical operations MUST be observable via structured events.
- Time-window checks MUST tolerate bounded clock skew (implementation-defined, documented).
