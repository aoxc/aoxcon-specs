# Conformance Test Matrix

| Area | Test ID | Description | Expected Result |
|---|---|---|---|
| Schema | CT-001 | Missing required envelope field | `ERR_INVALID_SCHEMA` |
| Chain ID | CT-002 | Invalid `source_chain` format | `ERR_INVALID_CHAIN_ID` |
| Replay | CT-003 | Duplicate `message_id` | `OK_ALREADY_PROCESSED` |
| Nonce | CT-004 | Non-monotonic nonce | `ERR_INVALID_NONCE` |
| Time | CT-005 | `now > expiry` | `ERR_EXPIRED_MESSAGE` |
| Hash | CT-006 | Payload hash mismatch | `ERR_PROCESSING_FAILED` |
| Proof | CT-007 | Invalid proof bytes | `ERR_INVALID_PROOF` |
| AuthZ | CT-008 | Unauthorized actor | `ERR_UNAUTHORIZED_ACTOR` |
| State | CT-009 | Illegal transition request | `ERR_INVALID_STATE_TRANSITION` |
| Success | CT-010 | Fully valid message | `OK_PROCESSED` |

## Cross-adapter requirement

All adapter repositories MUST pass all matrix cases with canonical-equivalent outputs.
