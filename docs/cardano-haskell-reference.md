# Cardano Haskell Integration Blueprint (FNT Treasury)

This document defines how the Cardano-side implementation (`aoxcon-cardano`) aligns with the AOXCON core behavior while implementing a treasury-backed FNT token flow.

## Objectives

- Keep cross-chain behavior deterministic and identical to AOXCON core.
- Provide a Haskell-first model suitable for Plutus-oriented development.
- Model FNT mint distribution via a treasury vault with explicit error codes.

## Compatibility guarantees

The Cardano implementation MUST remain compatible with the shared protocol surface:

1. Envelope validation outputs the same status/error codes.
2. Replay and nonce semantics are idempotent.
3. State transitions keep canonical AOXCON lifecycle boundaries.
4. Treasury failures use stable machine-readable error identifiers.

## Haskell reference package

Reference source tree:

- `haskell/aoxcon-cardano-ref/src/Aoxcon/Errors.hs`
- `haskell/aoxcon-cardano-ref/src/Aoxcon/Types.hs`
- `haskell/aoxcon-cardano-ref/src/Aoxcon/Envelope.hs`
- `haskell/aoxcon-cardano-ref/src/Aoxcon/StateMachine.hs`
- `haskell/aoxcon-cardano-ref/src/Aoxcon/FNTTreasury.hs`

This package is intended as a conformance anchor for Cardano adapters. The same behavior can then be ported into on-chain/off-chain Plutus boundaries.

## FNT treasury model

`TreasuryState` tracks:

- `totalSupply`: total FNT minted into circulation.
- `treasuryVault`: unissued reserve available for distribution.
- `balances`: wallet ledger snapshot.

Supported operations:

- `depositTreasury`: increases reserve (pre-mint inventory funding).
- `mintFromTreasury`: issues FNT from reserve to recipient wallet.
- `burnFromWallet`: burns held tokens and reduces supply.

Error contracts:

- `ERR_INVALID_MINT_AMOUNT`
- `ERR_INSUFFICIENT_TREASURY`

## Production hardening checklist

Before mainnet deployment, `aoxcon-cardano` SHOULD additionally implement:

- validator-level policy checks for mint/burn authorization,
- script-context checks for datum/redeemer integrity,
- deterministic serialization fixtures shared with `aoxcon-core`,
- integration tests against relayer proof envelopes,
- audit traces mapped to `docs/audit-conformance-checklist.md`.
