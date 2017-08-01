{-# LANGUAGE OverloadedStrings #-}

module SecondHandCrawler.SecondHandCrawler
  ( parseHtml
  , SecondHandOffer(..)
  ) where

import           Control.Applicative ()
import           Data.Maybe          (fromMaybe)
import           Data.Text           (pack, strip, unpack)
import           Text.HTML.Scalpel

data SecondHandOffer = SecondHandOffer
  { title       :: String
  , imgSrc      :: String
  , href        :: String
  , description :: String
  } deriving (Eq, Show)

trim :: String -> String
trim = unpack . strip . pack

parseHtml :: String -> [SecondHandOffer]
parseHtml html = fromMaybe [] (scrapeStringLike html secondHandOffer)
   where
   secondHandOffer :: Scraper String [SecondHandOffer]
   secondHandOffer = chroots ("div" @: [hasClass "gm_offer"]) offer

   offer :: Scraper String SecondHandOffer
   offer = do
        title <- text $ "a" @: [hasClass "dtl"]
        imageSrc <- attr "src" "img"
        href <- chroot ("div" @: [hasClass "gm_offer_description"]) $ attr "href" "a"
        description <- text $ "div" @: [hasClass "bodytext"]
        return $ SecondHandOffer (trim title) (host ++ imageSrc) (host ++ href) (trim description)
        where host = "http://www.dhv.de"
