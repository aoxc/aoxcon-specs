# AOXCON Specifications

AOXCON is a **chain-agnostic interoperability core** designed to run with full compatibility across:

- EVM-based ecosystems (Ethereum, L2s, EVM sidechains)
- Move-based ecosystems (Aptos/Sui-style execution models)
- Cardano (eUTxO + Plutus)

This repository is the **normative specification source** for all AOXCON implementation repositories.

## Why this repository exists

Implementations in different repositories must behave identically at the protocol level. This repository defines:

- canonical data structures,
- deterministic state machine rules,
- cross-chain message verification requirements,
- compatibility contracts,
- security and audit baselines,
- conformance expectations.

## Target implementation repositories

1. `aoxcon-core` — chain-agnostic domain kernel
2. `aoxcon-evm` — Solidity / EVM adapter
3. `aoxcon-move` — Move adapter
4. `aoxcon-cardano` — Cardano / Plutus adapter
5. `aoxcon-relayer` — transport, witness and submission layer
6. `aoxcon-sdk` — client SDKs (TypeScript/Rust/etc.)

## Core requirements

- **Deterministic execution**: same input, same state transition, same result code.
- **Provable processing**: every critical transition emits verifiable evidence.
- **Replay resistance**: strict `message_id` and `nonce` semantics.
- **Versioned interoperability**: SemVer + compatibility policy.
- **Auditability**: requirements are testable and traceable.

## Documentation map

- [Core Architecture](docs/core-architecture.md)
- [Cross-Chain Message Specification](docs/message-spec.md)
- [Compatibility Contract](docs/compatibility-contract.md)
- [Security Baseline](docs/security-baseline.md)
- [Audit & Conformance Checklist](docs/audit-conformance-checklist.md)
- [Protocol Whitepaper (Markdown)](docs/whitepaper.md)
- [Protocol Whitepaper (PDF)](docs/whitepaper.pdf)
- [Roadmap](docs/roadmap.md)

## Change control

- All normative changes must be made via pull request.
- PRs must include compatibility impact (`major`, `minor`, `patch`).
- Security-affecting changes must update security and audit docs in the same PR.

## License

See [LICENSE](LICENSE).
