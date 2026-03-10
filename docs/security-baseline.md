# Security Baseline (Audit-Oriented)

## 1. Mandatory security controls

1. Replay protection with both `message_id` and actor-scoped nonce.
2. Proof/signature verification bound to domain separator and chain context.
3. Role separation for admin, verifier and operator actions.
4. Time-window enforcement (`not_before`, `expiry`) with bounded skew policy.
5. Illegal state transition prevention.
6. Input size limits and rate controls.
7. Emergency pause and controlled recovery path.
8. Immutable audit trail for security-relevant actions.

## 2. Threat model scope

- Replay attacks
- Proof forgery / signature substitution
- Relayer equivocation or censorship
- Adapter logic divergence across chains
- Serialization ambiguity and hash mismatch
- Privilege escalation and key compromise
- Denial of service via oversized payloads

## 3. Chain-specific controls

### 3.1 EVM
- Reentrancy protection for external-call paths.
- CEI pattern adherence.
- Explicit proxy upgrade authorization and timelock policy.

### 3.2 Move
- Capability leakage prevention.
- Resource duplication impossibility checks.
- Module upgrade policy and compatibility checks.

### 3.3 Cardano
- Datum/redeemer schema validation and version pinning.
- eUTxO race-condition handling for one-time message consumption.
- Script context checks for signer, validity interval and expected value flow.

## 4. Operational security

- Key rotation runbook and maximum key age.
- Multi-party controls (multisig/threshold) for privileged actions.
- Deterministic build and release attestations where available.
- Incident response path with rollback/containment rules.

## 5. Audit readiness criteria

An implementation is audit-ready only if it provides:

- traceability from every normative rule to code/tests,
- reproducible conformance run outputs,
- documented assumptions and trust boundaries,
- critical-path unit/integration/fuzz test evidence.
