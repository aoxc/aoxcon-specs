module Aoxcon.StateMachine where

import Aoxcon.Errors (errInvalidStateTransition, okProcessed)
import Aoxcon.Types (TransitionResult(..))
import qualified Data.Map.Strict as Map
import qualified Data.Set as Set

validTransitions :: Map.Map String (Set.Set String)
validTransitions =
  Map.fromList
    [ ("Initialized", Set.fromList ["Queued"])
    , ("Queued", Set.fromList ["Verified", "Rejected"])
    , ("Verified", Set.fromList ["Executed", "FailedExecution"])
    , ("Executed", Set.fromList ["Finalized"])
    , ("Finalized", Set.empty)
    , ("Rejected", Set.empty)
    , ("FailedExecution", Set.empty)
    ]

transition :: String -> String -> TransitionResult
transition fromS toS =
  let allowed = Map.findWithDefault Set.empty fromS validTransitions
   in if Set.member toS allowed
        then TransitionResult True okProcessed fromS toS
        else TransitionResult False errInvalidStateTransition fromS toS
