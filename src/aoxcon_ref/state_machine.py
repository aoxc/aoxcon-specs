from dataclasses import dataclass
from .errors import ERR_INVALID_STATE_TRANSITION

VALID_TRANSITIONS = {
    "Initialized": {"Queued"},
    "Queued": {"Verified", "Rejected"},
    "Verified": {"Executed", "FailedExecution"},
    "Executed": {"Finalized"},
    "Finalized": set(),
    "Rejected": set(),
    "FailedExecution": set(),
}


@dataclass(frozen=True)
class TransitionResult:
    ok: bool
    code: str
    from_state: str
    to_state: str


def transition(from_state: str, to_state: str) -> TransitionResult:
    if to_state in VALID_TRANSITIONS.get(from_state, set()):
        return TransitionResult(True, "OK_PROCESSED", from_state, to_state)
    return TransitionResult(False, ERR_INVALID_STATE_TRANSITION, from_state, to_state)
