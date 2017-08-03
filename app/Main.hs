module Main where

import           Client             (getFbOffers, getSecondHandOffer)
import           System.Environment (getEnv)

main :: IO ()
main = do
  accessToken <- getEnv "USER_ACCESS_TOKEN"
  fbOffers <- getFbOffers accessToken
  secondOffers <- getSecondHandOffer
  case secondOffers of
    Left err -> putStrLn $ "Error: " ++ show err
    Right offers -> do
      print $ offers
