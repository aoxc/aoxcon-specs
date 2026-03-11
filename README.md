# AOXCON Protocol Specifications

AOXCON is an audit-oriented protocol specification for a deterministic interoperability kernel across:

- **EVM ecosystems**
- **Move ecosystems**
- **Cardano (eUTxO / Plutus)**

This repository is the **normative source of truth** for AOXCON behavior and conformance.

## Scope

This repository defines:

- canonical protocol data models,
- deterministic state machine and transition invariants,
- cross-chain message envelope and verification rules,
- adapter compatibility contract,
- relayer operating contract,
- security baseline and threat expectations,
- conformance requirements and audit evidence format.

## Implementation repositories

- `aoxcon-core`
- `aoxcon-evm`
- `aoxcon-move`
- `aoxcon-cardano`
- `aoxcon-relayer`
- `aoxcon-sdk`

## Document map

### Foundation
- [System Overview](docs/system-overview.md)
- [Core Architecture](docs/core-architecture.md)
- [Protocol State Machine](docs/protocol-state-machine.md)
- [Glossary](docs/glossary.md)

### Interoperability
- [Message Specification](docs/message-spec.md)
- [Relayer Specification](docs/relayer-spec.md)
- [Compatibility Contract](docs/compatibility-contract.md)
- [Implementation Language Strategy](docs/implementation-language-strategy.md)
- [Cardano Haskell Integration Blueprint](docs/cardano-haskell-reference.md)

### Security, Audit, Quality
- [Security Baseline](docs/security-baseline.md)
- [Conformance Test Matrix](docs/conformance-test-matrix.md)
- [Audit Conformance Checklist](docs/audit-conformance-checklist.md)

### Productization
- [SDK Specification](docs/sdk-spec.md)
- [Roadmap](docs/roadmap.md)
- [Governance](docs/governance.md)
- [Whitepaper (Markdown)](docs/whitepaper.md)
- [Whitepaper (PDF)](docs/whitepaper.pdf)

## Reference implementations

### Python deterministic kernel

Minimal executable reference implementation:

- `src/aoxcon_ref/` (envelope + state machine)
- `tests/` (protocol checks)

Run locally:

```bash
PYTHONPATH=src python -m unittest -v
```

### Haskell / Cardano compatibility reference

Production-oriented Cardano-compatible reference skeleton:

- `haskell/aoxcon-cardano-ref/src/Aoxcon/Envelope.hs`
- `haskell/aoxcon-cardano-ref/src/Aoxcon/StateMachine.hs`
- `haskell/aoxcon-cardano-ref/src/Aoxcon/FNTTreasury.hs`
- `haskell/aoxcon-cardano-ref/test/Spec.hs`

Run locally (if GHC/Cabal installed):

```bash
cd haskell/aoxcon-cardano-ref
cabal test
```

## Normative language

Terms **MUST**, **MUST NOT**, **SHOULD**, and **MAY** are interpreted as in RFC 2119.

## Change policy

- Normative changes require pull request review.
- Every behavior change must declare SemVer impact.
- Security-impacting changes MUST update security and conformance docs in the same change set.
- Conformance matrix MUST be updated when new error/status behavior is introduced.

## License

See [LICENSE](LICENSE).
