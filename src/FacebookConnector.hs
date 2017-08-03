{-# LANGUAGE DataKinds             #-}
{-# LANGUAGE DeriveGeneric         #-}
{-# LANGUAGE FlexibleInstances     #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE ScopedTypeVariables   #-}
{-# LANGUAGE TypeOperators         #-}

module FacebookConnector
  ( facebookRequest
  ) where

import           CrawlerModels
import           Data.Aeson     (FromJSON, parseJSON, withObject, (.:))
import           Data.Maybe     (mapMaybe)
import           Data.Proxy
import           GHC.Generics   (Generic)

import           Servant.API    ((:>), Capture, Get, JSON, QueryParam)
import           Servant.Client

newtype FacebookResults = FacebookResults
  { rootFbData :: [FacebookResult]
  } deriving (Show)

instance FromJSON FacebookResults where
  parseJSON = withObject "FacebookResults" $ \jsonResponse -> FacebookResults <$> (jsonResponse .: "data")

data FacebookResult = FbRes
  { message       :: Maybe String
  , permalink_url :: Maybe String
  , picture       :: Maybe String
  } deriving (Generic, Show)

instance FromJSON FacebookResult

type FacebookApi
   = Capture "groupId" Int :> Capture "action" String :> QueryParam "access_token" String :> QueryParam "limit" String :> QueryParam "fields" String :> Get '[ JSON] FacebookResults

fbApi :: Proxy FacebookApi
fbApi = Proxy

fbClient :: Int -> String -> Maybe String -> Maybe String -> Maybe String -> ClientM FacebookResults
fbClient = client fbApi

facebookRequest :: String -> ClientM [Offer]
facebookRequest token =
  fmap
    facebookResultsToOffers
    (fbClient 129251540443443 "feed" (Just token) (Just "100") (Just "created_time,message,permalink_url,picture"))

facebookResultsToOffers :: FacebookResults -> [Offer]
facebookResultsToOffers results = mapMaybe fbResultToOffer (rootFbData results)

fbResultToOffer :: FacebookResult -> Maybe Offer
fbResultToOffer fb = do
  msg <- message fb
  link <- permalink_url fb
  imageLink <- picture fb
  Just $ Offer msg link imageLink ""
