module Main where

import Client (getFbOffers)
import System.Environment (getEnv)

main :: IO ()
main = do
 accessToken <- getEnv "USER_ACCESS_TOKEN"
 res <- getFbOffers accessToken
 case res of
     Left err -> putStrLn $ "Error: " ++ show err
     Right offers -> do
       print offers
