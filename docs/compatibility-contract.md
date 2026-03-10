# Compatibility Contract (Normative)

## 1. Required interfaces

Every adapter MUST expose canonical-equivalent operations:

- `protocolVersion() -> string`
- `domainSeparator() -> bytes32`
- `processMessage(envelope, payload, proof) -> ProcessResult`
- `isProcessed(message_id) -> bool`
- `latestNonce(actor_id) -> uint64`

## 2. Required events

- `MessageQueued(message_id, source_chain, target_chain, actor_id)`
- `MessageVerified(message_id, verifier, proof_type)`
- `MessageProcessed(message_id, status_code, state_from, state_to)`

## 3. Behavioral equivalence

For the same canonical input tuple `(envelope, payload, proof, current_state)`, all adapters MUST produce equivalent:

- status code,
- state transition,
- idempotency decision,
- emitted semantic event set.

## 4. Error/status compatibility

Internal runtime errors MUST map to canonical AOXCON result codes from `message-spec.md`.

## 5. Version compatibility

- major mismatch => incompatible,
- minor upgrade => backward-compatible only,
- patch update => no behavior change.

## 6. Mandatory publication in each implementation repo

- supported spec version,
- conformance test report,
- known deviations,
- migration notes.
