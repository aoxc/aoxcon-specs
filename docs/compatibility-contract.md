# Compatibility Contract (Normative)

This document defines strict compatibility requirements for all AOXCON implementation repositories.

## 1. Required interfaces

Each chain adapter MUST expose equivalent operations:

- `protocolVersion() -> string`
- `domainSeparator() -> bytes32`
- `processMessage(envelope, payload, proof) -> ProcessResult`
- `isProcessed(message_id) -> bool`
- `latestNonce(actor_id) -> uint64`

## 2. Required events

Implementations MUST emit equivalent events:

- `MessageQueued(message_id, source_chain, target_chain, actor_id)`
- `MessageVerified(message_id, verifier, proof_type)`
- `MessageProcessed(message_id, status_code, state_from, state_to)`

## 3. Compatibility guarantees

### 3.1 Behavioral compatibility

For identical canonical inputs, all adapters MUST produce equivalent:

- status code,
- transition result,
- processed flag behavior,
- idempotency behavior.

### 3.2 Version compatibility

- Major mismatch (`X.*.*` vs `Y.*.*`, `X != Y`) is incompatible.
- Minor upgrades MUST preserve backward compatibility.
- Patch releases MUST not change normative behavior.

### 3.3 Error compatibility

Adapter-specific internal errors MUST map to canonical AOXCON status/error codes.

## 4. Cross-repo synchronization requirements

- `aoxcon-core` changes to state machine or codes require synchronized adapter updates.
- `aoxcon-relayer` must reject constructing envelopes that violate canonical schema.
- SDKs must expose canonical envelope fields and status codes without renaming.

## 5. Mandatory conformance evidence

Each implementation repo MUST publish:

- supported spec version,
- conformance test results,
- known deviations (if any),
- migration notes for breaking changes.
