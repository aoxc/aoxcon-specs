# Compatibility Contract (Normative)

## 1. Required adapter interface

Each adapter MUST provide equivalent operations:

- `protocolVersion() -> string`
- `domainSeparator() -> bytes32`
- `processMessage(envelope, payload, proof) -> ProcessResult`
- `isProcessed(message_id) -> bool`
- `latestNonce(actor_id) -> uint64`

## 2. Required canonical events

- `MessageQueued(message_id, source_chain, target_chain, actor_id)`
- `MessageVerified(message_id, verifier, proof_type)`
- `MessageProcessed(message_id, status_code, state_from, state_to)`

## 3. Behavior compatibility

For equivalent canonical input tuples, adapters MUST return equivalent canonical outcomes.

## 4. Version policy

- Major mismatch is incompatible.
- Minor upgrades MUST be backward compatible.
- Patch upgrades MUST preserve behavior.

## 5. Conformance declaration

Every implementation repository MUST publish:

- implemented spec version,
- conformance report,
- deviations list (if any),
- migration notes.
