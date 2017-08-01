{-# LANGUAGE OverloadedStrings #-}

module SecondHandCrawler.SecondHandCrawler
  ( parseHtml
  , SecondHandOffer(..)
  ) where

import           Control.Applicative
import           Text.HTML.Scalpel

newtype SecondHandOffer = SecondHandOffer
  { title :: String
  } deriving (Eq, Show)

parseHtml :: String -> [SecondHandOffer]
parseHtml html = [SecondHandOffer "testOffer"]
