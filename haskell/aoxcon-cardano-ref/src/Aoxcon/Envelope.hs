module Aoxcon.Envelope where

import Aoxcon.Errors
import Aoxcon.Types
import Crypto.Hash (Digest, SHA256, hash)
import qualified Data.ByteArray.Encoding as BA
import qualified Data.ByteString as BS
import qualified Data.ByteString.Char8 as BS8
import qualified Data.Map.Strict as Map
import qualified Data.Set as Set
import qualified Data.Text as T

isChainId :: String -> Bool
isChainId value =
  case break (== ':') value of
    ("", _) -> False
    (_, "") -> False
    (_, ':':rest) -> not (null rest) && all (/= ':') rest
    _ -> False

hashPayload :: BS.ByteString -> String
hashPayload payload =
  let digest :: Digest SHA256
      digest = hash payload
   in "0x" <> BS8.unpack (BA.convertToBase BA.Base16 digest)

validProofType :: String -> Bool
validProofType p = p `elem` ["merkle", "sigset", "lightclient"]

processEnvelope
  :: Envelope
  -> BS.ByteString
  -> Int
  -> ReplayStore
  -> Set.Set String
  -> (String, ReplayStore)
processEnvelope env payload nowTs replay authorizedActors
  | not (isChainId $ sourceChain env) || not (isChainId $ targetChain env) = (errInvalidChainId, replay)
  | Set.member (messageId env) (processed replay) = (okAlreadyProcessed, replay)
  | nonce env <= lastNonce = (errInvalidNonce, replay)
  | nowTs < notBefore env = (errStaleMessage, replay)
  | nowTs > expiry env = (errExpiredMessage, replay)
  | payloadHash env /= hashPayload payload = (errProcessingFailed, replay)
  | not (validProofType $ proofType env) || null (proof env) = (errInvalidProof, replay)
  | not (Set.member (actorId env) authorizedActors) = (errUnauthorizedActor, replay)
  | otherwise =
      let newReplay =
            ReplayStore
              { processed = Set.insert (messageId env) (processed replay)
              , nonces = Map.insert key (nonce env) (nonces replay)
              }
       in (okProcessed, newReplay)
  where
    key = (sourceChain env, actorId env)
    lastNonce = Map.findWithDefault (-1) key (nonces replay)

mkEnvelope
  :: String -> String -> String -> String -> String -> String -> String
  -> Int -> Int -> Int -> Int -> String -> String -> String
  -> Envelope
mkEnvelope ver mid srcChain trgChain srcApp trgApp actor nonceVal ts nb expTs pHash pType p =
  Envelope
    { version = ver
    , messageId = mid
    , sourceChain = srcChain
    , targetChain = trgChain
    , sourceApp = srcApp
    , targetApp = trgApp
    , actorId = actor
    , nonce = nonceVal
    , timestamp = ts
    , notBefore = nb
    , expiry = expTs
    , payloadHash = pHash
    , proofType = pType
    , proof = p
    }

mkPayloadHash :: T.Text -> String
mkPayloadHash = hashPayload . BS8.pack . T.unpack
