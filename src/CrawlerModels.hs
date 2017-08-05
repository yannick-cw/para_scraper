{-# LANGUAGE DeriveGeneric     #-}


module CrawlerModels
  ( Offer(..)
  ) where


import           Data.Aeson             (ToJSON)
import           GHC.Generics           (Generic)

data Offer = Offer
  { title       :: String
  , imgSrc      :: String
  , href        :: String
  , description :: String
  } deriving (Eq, Show, Generic)

instance ToJSON Offer
