# Audit Conformance Checklist

## A. Protocol conformance

- [ ] Required interfaces implemented.
- [ ] Canonical events emitted.
- [ ] Canonical status/error mapping complete.
- [ ] Implemented spec version documented.

## B. Message processing

- [ ] Envelope schema checks complete.
- [ ] Nonce monotonicity enforced.
- [ ] Time-window checks enforced.
- [ ] Payload hash recomputation validated.
- [ ] Idempotent replay behavior verified.

## C. State machine correctness

- [ ] Only valid transitions allowed.
- [ ] Transition tests cover success/reject/failure paths.
- [ ] Processed marker persistence is atomic.

## D. Security validation

- [ ] Access control tests for unauthorized actors.
- [ ] Invalid proof tests.
- [ ] Oversized payload/proof tests.
- [ ] Pause/resume behavior tests.

## E. Delivery and operations

- [ ] Relayer retry and dead-letter paths tested.
- [ ] Monitoring and alerting configured.
- [ ] Key rotation procedure validated.
