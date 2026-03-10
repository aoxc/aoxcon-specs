# Protocol State Machine (Normative)

## 1. States

- `Initialized`
- `Queued`
- `Verified`
- `Executed`
- `Finalized`
- `Rejected`
- `FailedExecution`

## 2. Valid transitions

- `Initialized -> Queued`
- `Queued -> Verified`
- `Verified -> Executed`
- `Executed -> Finalized`
- `Queued -> Rejected`
- `Verified -> FailedExecution`

Any other transition MUST return `ERR_INVALID_STATE_TRANSITION`.

## 3. Transition preconditions

### Queue
- envelope schema valid
- actor format valid

### Verify
- nonce valid and monotonic
- time window valid
- proof valid
- authorization valid

### Execute
- payload hash matched
- target action policy allowed

### Finalize
- all execution effects committed
- processed marker persisted

## 4. Transition postconditions

Each successful transition MUST emit:

- `message_id`
- previous state
- next state
- status code
- deterministic timestamp source
