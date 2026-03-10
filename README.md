# AOXCON Protocol Specifications

AOXCON is a multi-chain protocol kernel specification that standardizes one interoperable system across:

- **EVM ecosystems** (Ethereum/L2/EVM chains)
- **Move ecosystems** (Aptos/Sui-style runtimes)
- **Cardano** (eUTxO + Plutus)

This repository is the **single normative source** for implementation repositories.

## Repository role

This repo defines the protocol, not production runtime code. It is authoritative for:

- canonical data models,
- deterministic state transitions,
- verification and relaying behavior,
- compatibility requirements across adapters,
- security controls and audit criteria,
- conformance suite expectations.

## Target repositories

- `aoxcon-core` — protocol state machine and canonical types
- `aoxcon-evm` — EVM adapter
- `aoxcon-move` — Move adapter
- `aoxcon-cardano` — Cardano adapter
- `aoxcon-relayer` — watcher, witness and submitter services
- `aoxcon-sdk` — client SDKs and tooling

## Documentation index

### Core
- [System Overview](docs/system-overview.md)
- [Core Architecture](docs/core-architecture.md)
- [Protocol State Machine](docs/protocol-state-machine.md)

### Interoperability
- [Message Specification](docs/message-spec.md)
- [Relayer Specification](docs/relayer-spec.md)
- [Compatibility Contract](docs/compatibility-contract.md)

### Security & Quality
- [Security Baseline](docs/security-baseline.md)
- [Audit Conformance Checklist](docs/audit-conformance-checklist.md)
- [Conformance Test Matrix](docs/conformance-test-matrix.md)

### Productization
- [SDK Specification](docs/sdk-spec.md)
- [Implementation Language Strategy](docs/implementation-language-strategy.md)
- [Roadmap](docs/roadmap.md)
- [Whitepaper (Markdown)](docs/whitepaper.md)
- [Whitepaper (PDF)](docs/whitepaper.pdf)

## Change governance

- Normative changes require pull requests.
- Any behavioral change must declare SemVer impact.
- Security-relevant changes must update security and conformance docs in the same PR.

## License

See [LICENSE](LICENSE).
