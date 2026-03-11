module Main where

import Aoxcon.Envelope
import Aoxcon.FNTTreasury
import Aoxcon.Types
import qualified Data.ByteString.Char8 as BS8
import qualified Data.Set as Set
import qualified Data.Text as T

main :: IO ()
main = do
  let payloadText = "aoxcon-message"
      payload = BS8.pack payloadText
      env =
        mkEnvelope
          "1.0"
          "msg-1"
          "evm:1"
          "cardano:mainnet"
          "bridge-src"
          "bridge-dst"
          "relayer-1"
          0
          1000
          1000
          2000
          (mkPayloadHash $ T.pack payloadText)
          "sigset"
          "proof-bytes"
      (code, _) = processEnvelope env payload 1200 emptyReplayStore (Set.fromList ["relayer-1"])
  print code

  let treasury0 = emptyTreasury
      treasury1 = depositTreasury 1000000 treasury0
  print treasury1

  let minted = treasury1 >>= mintFromTreasury "wallet1" 1000
  print minted
