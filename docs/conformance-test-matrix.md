# Conformance Test Matrix

| Area | ID | Scenario | Expected Code |
|---|---|---|---|
| Schema | CT-001 | Missing required envelope field | `ERR_INVALID_SCHEMA` |
| Schema | CT-002 | Wrong field type in envelope | `ERR_INVALID_SCHEMA` |
| Chain | CT-003 | Invalid chain namespace | `ERR_INVALID_CHAIN_ID` |
| Replay | CT-004 | Duplicate `message_id` | `OK_ALREADY_PROCESSED` |
| Nonce | CT-005 | Non-monotonic nonce | `ERR_INVALID_NONCE` |
| Time | CT-006 | Before `not_before` | `ERR_STALE_MESSAGE` |
| Time | CT-007 | After `expiry` | `ERR_EXPIRED_MESSAGE` |
| Hash | CT-008 | Payload hash mismatch | `ERR_PROCESSING_FAILED` |
| Proof | CT-009 | Invalid proof | `ERR_INVALID_PROOF` |
| AuthZ | CT-010 | Unauthorized actor | `ERR_UNAUTHORIZED_ACTOR` |
| State | CT-011 | Illegal transition | `ERR_INVALID_STATE_TRANSITION` |
| Success | CT-012 | Fully valid message | `OK_PROCESSED` |

## Cross-repo requirement

All adapters MUST pass the full matrix with canonical-equivalent outcomes.
