import hashlib
import unittest

from aoxcon_ref.envelope import InMemoryReplayStore, process_envelope
from aoxcon_ref.state_machine import transition
from aoxcon_ref import errors


def h(payload: bytes) -> str:
    return "0x" + hashlib.sha256(payload).hexdigest()


class ProtocolTests(unittest.TestCase):
    def base_envelope(self):
        return {
            "version": "1.0.0",
            "message_id": "0xabc",
            "source_chain": "evm:1",
            "target_chain": "cardano:mainnet",
            "source_app": "0xsource",
            "target_app": "aoxcon-core",
            "actor_id": "did:aoxcon:actor:1",
            "nonce": 1,
            "timestamp": 100,
            "not_before": 100,
            "expiry": 200,
            "payload_hash": h(b"payload"),
            "proof_type": "merkle",
            "proof": "ZGF0YQ==",
        }

    def test_success_then_idempotent(self):
        store = InMemoryReplayStore()
        env = self.base_envelope()
        code1 = process_envelope(env, b"payload", 150, store, {"did:aoxcon:actor:1"})
        code2 = process_envelope(env, b"payload", 150, store, {"did:aoxcon:actor:1"})
        self.assertEqual(code1, errors.OK_PROCESSED)
        self.assertEqual(code2, errors.OK_ALREADY_PROCESSED)

    def test_nonce(self):
        store = InMemoryReplayStore()
        env = self.base_envelope()
        self.assertEqual(process_envelope(env, b"payload", 150, store, {"did:aoxcon:actor:1"}), errors.OK_PROCESSED)
        env2 = self.base_envelope()
        env2["message_id"] = "0xdef"
        env2["nonce"] = 1
        self.assertEqual(process_envelope(env2, b"payload", 150, store, {"did:aoxcon:actor:1"}), errors.ERR_INVALID_NONCE)

    def test_state_machine(self):
        self.assertTrue(transition("Queued", "Verified").ok)
        self.assertFalse(transition("Executed", "Queued").ok)


if __name__ == "__main__":
    unittest.main()
