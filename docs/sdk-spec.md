# SDK Specification

## 1. Goals

SDKs provide a unified developer API while preserving canonical protocol semantics.

## 2. Required SDK surface

- envelope builder and validator,
- canonical status/error decoder,
- typed process result model,
- adapter-specific transport connectors.

## 3. API requirements

SDKs MUST expose:

- raw canonical fields without renaming,
- deterministic serialization utility,
- stable error enums aligned with `message-spec.md`.

## 4. Compatibility requirements

SDK versioning MUST follow protocol compatibility:

- breaking protocol behavior requires SDK major bump,
- additive backward-compatible fields require minor bump,
- patch updates MUST not alter canonical behavior.
