{-# LANGUAGE DataKinds             #-}
{-# LANGUAGE FlexibleInstances     #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE ScopedTypeVariables   #-}
{-# LANGUAGE TypeOperators         #-}

module SecondHandCrawler.SecondHandConnector
  ( secondHandRequest
  ) where

import           Control.Arrow                       (left)
import           Data.Proxy
import           Data.Text.Lazy                      (unpack)
import qualified Data.Text.Lazy                      as TextL
import qualified Data.Text.Lazy.Encoding             as TextL
import           Network.HTTP.Media                  ((//), (/:))
import           SecondHandCrawler.SecondHandCrawler (SecondHandOffer,
                                                      parseHtml)
import           Servant.API                         ((:>), Accept, Get,
                                                      MimeUnrender (..),
                                                      PlainText, contentType, QueryParam)
import           Servant.Client

data HTML

instance MimeUnrender HTML TextL.Text where
  mimeUnrender _ = left show . TextL.decodeUtf8'

instance Accept HTML where
  contentType _ = "text" // "html" /: ("charset", "utf-8")

type SecondHandApi
   = "db3/gebrauchtmarkt/anzeigen" :> QueryParam "itemsperpage" Int :> QueryParam "order" Int :> Get '[ HTML] TextL.Text

shApi :: Proxy SecondHandApi
shApi = Proxy

shClient :: Int -> ClientM String
shClient limit = unpack <$> client shApi (Just limit) (Just 1)

secondHandRequest :: ClientM [SecondHandOffer]
secondHandRequest = parseHtml <$> shClient 1000
