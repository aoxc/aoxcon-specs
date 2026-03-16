import json
from pathlib import Path
from typing import Any

from .errors import ALL_CODES


REQUIRED_TOP_LEVEL_KEYS = {
    "profile",
    "version",
    "repository",
    "compatibility",
    "environments",
    "aoxcon_control_plane",
}


class ProfileValidationError(ValueError):
    pass


def load_profile(path: str | Path) -> dict[str, Any]:
    with open(path, "r", encoding="utf-8") as fp:
        return json.load(fp)


def validate_profile(profile: dict[str, Any]) -> None:
    missing = REQUIRED_TOP_LEVEL_KEYS - set(profile.keys())
    if missing:
        raise ProfileValidationError(f"Missing top-level keys: {sorted(missing)}")

    repository = profile["repository"]
    if repository.get("canonical_repo") != "https://github.com/aoxc/aoxchain":
        raise ProfileValidationError("canonical_repo must point to aoxchain")

    if repository.get("compatibility_repo") != "https://github.com/aoxc/aoxcon":
        raise ProfileValidationError("compatibility_repo must point to aoxcon")

    if repository.get("chain_family") != "cardano" or repository.get("stack") != "plutus":
        raise ProfileValidationError("Repository must be configured as cardano/plutus")

    compatibility = profile["compatibility"]
    if compatibility.get("protocol") != "AOXCON":
        raise ProfileValidationError("protocol must be AOXCON")

    required_error_codes = set(compatibility.get("required_error_codes", []))
    missing_codes = required_error_codes - ALL_CODES
    if missing_codes:
        raise ProfileValidationError(
            f"Profile references unknown error codes: {sorted(missing_codes)}"
        )

    environments = profile["environments"]
    for env_name in ("development", "staging", "production"):
        if env_name not in environments:
            raise ProfileValidationError(f"Missing environment: {env_name}")

    proof_modes = set(profile["aoxcon_control_plane"].get("proof_modes", []))
    if not proof_modes.issubset({"merkle", "sigset", "lightclient"}):
        raise ProfileValidationError("Unsupported proof mode found in profile")
