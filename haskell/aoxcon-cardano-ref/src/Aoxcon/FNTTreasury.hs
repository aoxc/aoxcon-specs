module Aoxcon.FNTTreasury where

import Aoxcon.Errors
import Aoxcon.Types
import qualified Data.Map.Strict as Map

depositTreasury :: Integer -> TreasuryState -> Either String TreasuryState
depositTreasury amount st
  | amount <= 0 = Left errInvalidMintAmount
  | otherwise = Right st {treasuryVault = treasuryVault st + amount}

mintFromTreasury :: String -> Integer -> TreasuryState -> Either String TreasuryState
mintFromTreasury recipient amount st
  | amount <= 0 = Left errInvalidMintAmount
  | amount > treasuryVault st = Left errInsufficientTreasury
  | otherwise =
      let newBalances = Map.insertWith (+) recipient amount (balances st)
       in Right st
            { treasuryVault = treasuryVault st - amount
            , totalSupply = totalSupply st + amount
            , balances = newBalances
            }

burnFromWallet :: String -> Integer -> TreasuryState -> Either String TreasuryState
burnFromWallet holder amount st
  | amount <= 0 = Left errInvalidMintAmount
  | amount > current = Left errInsufficientTreasury
  | otherwise =
      let updatedHolder = current - amount
          updatedBalances = if updatedHolder == 0 then Map.delete holder (balances st) else Map.insert holder updatedHolder (balances st)
       in Right st
            { totalSupply = totalSupply st - amount
            , balances = updatedBalances
            }
  where
    current = Map.findWithDefault 0 holder (balances st)
