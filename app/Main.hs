module Main where

import           Client                      (getFbOffers, getSecondHandOffer)
import           CrawlerModels               (Offer (..))
import           ElasticWriter.ElasticWriter (writer)
import           System.Environment          (getEnv)

main :: IO ()
main
--  accessToken <- getEnv "USER_ACCESS_TOKEN"
--  fbOffers <- getFbOffers accessToken
 = do
  secondOffers <- getSecondHandOffer
  case secondOffers of
    Left err     -> putStrLn $ "Error: " ++ show err
    Right offers -> writer offers
