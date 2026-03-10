# Audit & Conformance Checklist

Use this checklist in each implementation repository (`aoxcon-core`, adapters, relayer, SDK).

## A. Spec alignment

- [ ] Implements required interfaces from `compatibility-contract.md`.
- [ ] Emits required canonical events.
- [ ] Maps internal errors to canonical status/error codes.
- [ ] Documents implemented AOXCON spec version.

## B. Message handling

- [ ] Validates full envelope schema.
- [ ] Enforces monotonic nonce policy.
- [ ] Enforces message validity window.
- [ ] Verifies canonical payload hash.
- [ ] Supports idempotent success-noop for already processed messages.

## C. State machine correctness

- [ ] Prevents illegal transitions.
- [ ] Includes explicit tests for success, rejection and failure branches.
- [ ] Persists processed markers atomically with transition outcome.

## D. Security controls

- [ ] Replay controls tested.
- [ ] Proof verification tested for invalid and malformed cases.
- [ ] Role-based access control tested for unauthorized actors.
- [ ] Input limits (payload/proof size) tested.
- [ ] Pause/resume path tested.

## E. Evidence package for audits

- [ ] Test reports (unit/integration/fuzz where applicable).
- [ ] Threat model and assumptions.
- [ ] Change log with compatibility impact.
- [ ] Incident response and key management runbooks.
