# Relayer Specification (Normative)

## 1. Responsibilities

Relayer components MUST:

- observe source-chain events,
- collect required witness/proof material,
- construct canonical envelopes,
- submit to target adapters,
- track finality and retries.

## 2. Pipeline

1. **Observe** source finalized events.
2. **Normalize** event data into canonical envelope fields.
3. **Attach** proof bundle.
4. **Submit** to target adapter.
5. **Confirm** terminal status.
6. **Record** immutable audit log.

## 3. Delivery guarantees

- At-least-once transport is allowed.
- Exactly-once effect is enforced by target idempotency.
- Retry policy MUST use bounded exponential backoff.

## 4. Fault handling

Relayer MUST classify faults:

- transient infra errors (retry),
- permanent schema/policy errors (dead-letter),
- suspicious proof mismatch (security alert + halt route).
