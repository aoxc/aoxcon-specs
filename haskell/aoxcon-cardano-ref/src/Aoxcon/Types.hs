module Aoxcon.Types where

import Data.Map.Strict (Map)
import qualified Data.Map.Strict as Map
import Data.Set (Set)
import qualified Data.Set as Set

data Envelope = Envelope
  { version :: String
  , messageId :: String
  , sourceChain :: String
  , targetChain :: String
  , sourceApp :: String
  , targetApp :: String
  , actorId :: String
  , nonce :: Int
  , timestamp :: Int
  , notBefore :: Int
  , expiry :: Int
  , payloadHash :: String
  , proofType :: String
  , proof :: String
  } deriving (Eq, Show)

data ReplayStore = ReplayStore
  { processed :: Set String
  , nonces :: Map (String, String) Int
  } deriving (Eq, Show)

emptyReplayStore :: ReplayStore
emptyReplayStore = ReplayStore Set.empty Map.empty

data TransitionResult = TransitionResult
  { ok :: Bool
  , code :: String
  , fromState :: String
  , toState :: String
  } deriving (Eq, Show)

data TreasuryState = TreasuryState
  { totalSupply :: Integer
  , treasuryVault :: Integer
  , balances :: Map String Integer
  } deriving (Eq, Show)

emptyTreasury :: TreasuryState
emptyTreasury = TreasuryState 0 0 Map.empty
