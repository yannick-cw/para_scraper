module CrawlerModels where

data FacebookOffer = FacebookOffer
  { msg       :: String
  , link      :: String
  , imageLink :: String
  } deriving Show
