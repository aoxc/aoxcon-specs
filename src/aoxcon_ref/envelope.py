import hashlib
from dataclasses import dataclass
from typing import Dict, Any, Set, Tuple

from . import errors

REQUIRED_FIELDS = {
    "version",
    "message_id",
    "source_chain",
    "target_chain",
    "source_app",
    "target_app",
    "actor_id",
    "nonce",
    "timestamp",
    "not_before",
    "expiry",
    "payload_hash",
    "proof_type",
    "proof",
}


@dataclass
class InMemoryReplayStore:
    processed: Set[str]
    nonces: Dict[Tuple[str, str], int]

    def __init__(self) -> None:
        self.processed = set()
        self.nonces = {}


def _is_chain_id(value: str) -> bool:
    return isinstance(value, str) and ":" in value and len(value.split(":")) == 2


def _hash_payload(payload: bytes) -> str:
    return "0x" + hashlib.sha256(payload).hexdigest()


def process_envelope(
    envelope: Dict[str, Any],
    payload: bytes,
    now_ts: int,
    replay: InMemoryReplayStore,
    authorized_actors: Set[str],
) -> str:
    if not REQUIRED_FIELDS.issubset(set(envelope.keys())):
        return errors.ERR_INVALID_SCHEMA

    if not _is_chain_id(envelope["source_chain"]) or not _is_chain_id(envelope["target_chain"]):
        return errors.ERR_INVALID_CHAIN_ID

    message_id = envelope["message_id"]
    if message_id in replay.processed:
        return errors.OK_ALREADY_PROCESSED

    key = (envelope["source_chain"], envelope["actor_id"])
    last_nonce = replay.nonces.get(key, -1)
    if envelope["nonce"] <= last_nonce:
        return errors.ERR_INVALID_NONCE

    if now_ts < envelope["not_before"]:
        return errors.ERR_STALE_MESSAGE
    if now_ts > envelope["expiry"]:
        return errors.ERR_EXPIRED_MESSAGE

    if envelope["payload_hash"] != _hash_payload(payload):
        return errors.ERR_PROCESSING_FAILED

    if envelope["proof_type"] not in {"merkle", "sigset", "lightclient"} or not envelope["proof"]:
        return errors.ERR_INVALID_PROOF

    if envelope["actor_id"] not in authorized_actors:
        return errors.ERR_UNAUTHORIZED_ACTOR

    replay.processed.add(message_id)
    replay.nonces[key] = envelope["nonce"]
    return errors.OK_PROCESSED
