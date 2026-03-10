# Implementation Language Strategy (Normative Guidance)

## Decision

AOXCON should be implemented as a **hybrid (multi-language) system**, not a single-language stack.

Reason: EVM, Move and Cardano are runtime-specific ecosystems with different smart contract languages and execution models.

## Recommended stack by repository

### `aoxcon-core`
- **Rust** (recommended)
- Purpose: canonical types, envelope validation, shared deterministic logic, test vectors.

### `aoxcon-evm`
- **Solidity**
- Purpose: on-chain adapter for EVM ecosystems.

### `aoxcon-move`
- **Move**
- Purpose: on-chain adapter for Move-based chains.

### `aoxcon-cardano`
- **Aiken** or **Plutus (Haskell)**
- Purpose: on-chain adapter for Cardano eUTxO model.

### `aoxcon-relayer`
- **Rust** (primary)
- Purpose: performance, reliability, safe concurrency, long-running daemon operations.

### `aoxcon-sdk`
- **TypeScript** (primary developer SDK)
- **Rust** (optional high-performance/native SDK)

## Non-negotiable protocol rule

Different implementation languages are allowed, but protocol behavior MUST be identical:

- canonical envelope format,
- canonical status/error codes,
- deterministic state transitions,
- idempotent replay behavior.

## Build recommendation

- Keep protocol spec language-agnostic.
- Keep chain adapters in native chain language.
- Use Rust as the cross-repo reference engine for conformance fixtures.
- Enforce compatibility with shared conformance vectors in CI.
