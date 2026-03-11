# AOXCON Whitepaper

## Abstract

AOXCON defines a deterministic, auditable interoperability kernel for EVM, Move, and Cardano systems.

## Core thesis

A multi-chain system should not mean multiple incompatible protocol behaviors. AOXCON introduces one canonical protocol contract and enforces it across chain-native adapters.

## Architecture

AOXCON is organized into:

1. chain-agnostic core logic,
2. chain-native adapters,
3. relayer orchestration,
4. SDK interface layer.

## Canonical processing model

Each message follows fixed validation order:

- schema,
- chain namespace,
- time window,
- replay checks,
- payload hash,
- proof verification,
- authorization,
- transition execution.

Determinism is mandatory: equivalent inputs MUST yield equivalent outputs.

## Compatibility model

Adapters are free to use runtime-native idioms but MUST preserve canonical AOXCON outcomes, statuses, and event semantics.

## Security model

The protocol baseline mandates replay resistance, proof integrity checks, strict role boundaries, bounded inputs, and emergency controls.

## Conformance

Conformance is measured by shared matrix-driven test vectors and mandatory publication of implementation evidence.

## Conclusion

AOXCON is designed to be the protocol kernel for fully aligned EVM + Move + Cardano interoperability with audit-grade guarantees.


## Program-level deployment model (3 dApp + 1 control)

AOXCON program hedefinde 4 repo topolojisi bulunur:

1. EVM DAO dApp,
2. Move DAO dApp,
3. Cardano/Plutus DAO dApp,
4. AOXCON control repo (CLI + orchestration + governance bridge).

Bu modelde her dApp yerel DAO olarak özerktir; zincirler arası karar/mesaj aktarımı AOXCON canonical envelope ile normalize edilir.

## DAO interoperability thesis

Her bir proje DAO gibi yönetilebilir. AOXCON bu yapıda:

- governance kararlarını denetlenebilir zarf (envelope) biçiminde taşır,
- zincirler arası karar tutarlılığını korur,
- relayer katmanında retry/idempotency güvence altına alır,
- audit izini tüm zincirlerde eşlenebilir tutar.
