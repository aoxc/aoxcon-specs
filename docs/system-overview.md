# System Overview (Normative)

## 1. Purpose

AOXCON defines a single protocol system where independent implementations on EVM, Move, and Cardano produce equivalent results for equivalent canonical inputs.

## 2. Design principles

1. **Chain-agnostic domain logic**
2. **Deterministic processing**
3. **Proof-based verification**
4. **Idempotent execution**
5. **Audit-first operability**

## 3. System modules

- **Core Engine**: canonical types, validation and transition rules.
- **Chain Adapters**: chain-native transaction/event/storage mapping.
- **Relayer Network**: source observation, witness collection, target submission.
- **SDK Layer**: unified developer interface.

## 4. Global invariants

- Each `message_id` is processed at most once per target chain.
- Nonce progression is monotonic per `(source_chain, actor_id)`.
- All accepted transitions emit canonical events.
- All adapter implementations map internal errors to canonical codes.

## 5. Normative language

Keywords **MUST**, **MUST NOT**, **SHOULD**, and **MAY** are to be interpreted as RFC 2119.
