# Security Baseline (Normative, Audit Level)

## 1. Mandatory controls

1. Replay protection with `message_id` and nonce.
2. Proof verification bound to domain separator.
3. Strict role separation (admin/verifier/operator).
4. Time validity checks (`not_before`, `expiry`).
5. Illegal transition blocking.
6. Payload/proof size limits.
7. Emergency pause and safe recovery.
8. Immutable audit logging.

## 2. Threat classes

- replay and duplication,
- forged or substituted proofs,
- relayer equivocation,
- adapter divergence,
- privilege escalation,
- denial of service.

## 3. Chain-specific guidance

### EVM
- reentrancy protection,
- CEI compliance,
- upgrade governance with timelock.

### Move
- capability leakage prevention,
- resource uniqueness enforcement,
- module upgrade review controls.

### Cardano
- datum/redeemer schema pinning,
- eUTxO double-consumption prevention,
- script context completeness checks.

## 4. Audit evidence

Audit package MUST include:

- control-to-test traceability,
- test artifacts,
- threat model and assumptions,
- incident response and key rotation runbooks.
