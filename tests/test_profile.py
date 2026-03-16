import unittest

from aoxcon_ref.profile import ProfileValidationError, load_profile, validate_profile


class ProfileTests(unittest.TestCase):
    def test_profile_is_valid(self):
        profile = load_profile("config/aoxcon-chain-profile.json")
        validate_profile(profile)

    def test_profile_requires_aoxchain_repo(self):
        profile = load_profile("config/aoxcon-chain-profile.json")
        profile["repository"]["canonical_repo"] = "https://example.com/other"
        with self.assertRaises(ProfileValidationError):
            validate_profile(profile)


if __name__ == "__main__":
    unittest.main()
