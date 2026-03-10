# Governance

## 1. Versioning policy

AOXCON uses SemVer:

- **Major**: breaking normative behavior.
- **Minor**: additive backward-compatible semantics.
- **Patch**: clarifications/fixes with no normative behavior changes.

## 2. Change classes

1. **Normative behavior changes**
2. **Security baseline changes**
3. **Conformance artifact changes**
4. **Editorial/non-normative changes**

## 3. Approval requirements

- Normative behavior changes require at least one adapter maintainer approval.
- Security changes require explicit security review sign-off.
- Conformance matrix changes require CI fixture updates in downstream repos.

## 4. Release criteria

A release is valid only if:

- docs are internally consistent,
- conformance matrix is up to date,
- compatibility contract and message spec versioning align,
- roadmap impact is documented.
