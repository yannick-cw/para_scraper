module Main where

import Client (getFbOffers)

main :: IO ()
main = do
 res <- getFbOffers "noWork"
 case res of
     Left err -> putStrLn $ "Error: " ++ show err
     Right offers -> do
       print offers
