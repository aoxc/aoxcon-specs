module Aoxcon.Errors where

okProcessed, okAlreadyProcessed :: String
okProcessed = "OK_PROCESSED"
okAlreadyProcessed = "OK_ALREADY_PROCESSED"

errInvalidSchema, errInvalidChainId, errInvalidNonce, errStaleMessage :: String
errInvalidSchema = "ERR_INVALID_SCHEMA"
errInvalidChainId = "ERR_INVALID_CHAIN_ID"
errInvalidNonce = "ERR_INVALID_NONCE"
errStaleMessage = "ERR_STALE_MESSAGE"

errExpiredMessage, errProcessingFailed, errInvalidProof, errUnauthorizedActor :: String
errExpiredMessage = "ERR_EXPIRED_MESSAGE"
errProcessingFailed = "ERR_PROCESSING_FAILED"
errInvalidProof = "ERR_INVALID_PROOF"
errUnauthorizedActor = "ERR_UNAUTHORIZED_ACTOR"

errInvalidStateTransition :: String
errInvalidStateTransition = "ERR_INVALID_STATE_TRANSITION"

errInsufficientTreasury, errInvalidMintAmount :: String
errInsufficientTreasury = "ERR_INSUFFICIENT_TREASURY"
errInvalidMintAmount = "ERR_INVALID_MINT_AMOUNT"
