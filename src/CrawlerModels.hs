module CrawlerModels
  ( Offer(..)
  ) where

data Offer = Offer
  { title       :: String
  , imgSrc      :: String
  , href        :: String
  , description :: String
  } deriving (Eq, Show)
