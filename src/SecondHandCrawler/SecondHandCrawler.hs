{-# LANGUAGE OverloadedStrings #-}

module SecondHandCrawler.SecondHandCrawler
  ( parseHtml
  , SecondHandOffer(..)
  ) where

import           Control.Applicative
import           Text.HTML.Scalpel

data SecondHandOffer = SecondHandOffer
  { title  :: String
  , imgSrc :: String
  } deriving (Eq, Show)

parseHtml :: String -> Maybe [SecondHandOffer]
parseHtml html = scrapeStringLike html secondHandOffer
   where
   secondHandOffer :: Scraper String [SecondHandOffer]
   secondHandOffer = chroots ("div" @: [hasClass "gm_offer"]) offer

   offer :: Scraper String SecondHandOffer
   offer = do
        title      <- text $ "a" @: [hasClass "dtl"]
        imageSrc <- attr "src" "img"
        return $ SecondHandOffer title imageSrc
