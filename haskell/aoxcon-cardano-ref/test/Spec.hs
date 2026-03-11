module Main where

import Aoxcon.Envelope
import Aoxcon.Errors
import Aoxcon.FNTTreasury
import Aoxcon.StateMachine
import Aoxcon.Types
import qualified Data.ByteString.Char8 as BS8
import qualified Data.Map.Strict as Map
import qualified Data.Set as Set
import qualified Data.Text as T
import Test.HUnit

caseValidTransition :: Test
caseValidTransition =
  TestCase $ do
    let r = transition "Initialized" "Queued"
    assertEqual "valid transition" True (ok r)

caseValidEnvelope :: Test
caseValidEnvelope =
  TestCase $ do
    let payloadText = "payload"
        payload = BS8.pack payloadText
        env = mkEnvelope "1" "m1" "evm:1" "cardano:mainnet" "a" "b" "relayer" 1 100 100 200 (mkPayloadHash $ T.pack payloadText) "sigset" "proof"
        (code, store1) = processEnvelope env payload 150 emptyReplayStore (Set.fromList ["relayer"])
    assertEqual "processed" okProcessed code
    assertBool "message stored" (Set.member "m1" (processed store1))

caseTreasuryMint :: Test
caseTreasuryMint =
  TestCase $ do
    let result = do
          t1 <- depositTreasury 100 emptyTreasury
          mintFromTreasury "wallet" 70 t1
    case result of
      Left e -> assertFailure e
      Right t -> do
        assertEqual "vault reduced" 30 (treasuryVault t)
        assertEqual "balance updated" (Just 70) (Map.lookup "wallet" (balances t))

main :: IO Counts
main = runTestTT $ TestList [caseValidTransition, caseValidEnvelope, caseTreasuryMint]
