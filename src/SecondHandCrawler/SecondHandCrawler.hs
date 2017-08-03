{-# LANGUAGE OverloadedStrings #-}

module SecondHandCrawler.SecondHandCrawler
  ( parseHtml
  ) where

import           Control.Applicative ()
import           CrawlerModels       (Offer(..))
import           Data.Maybe          (fromMaybe)
import           Data.Text           (pack, strip, unpack)
import           Text.HTML.Scalpel

trim :: String -> String
trim = unpack . strip . pack

parseHtml :: String -> [Offer]
parseHtml html =
 fromMaybe [] (scrapeStringLike html secondHandOffer)
   where
   secondHandOffer :: Scraper String [Offer]
   secondHandOffer = chroots ("div" @: [hasClass "gm_offer"]) offer

   offer :: Scraper String Offer
   offer = do
        title <- text $ "a" @: [hasClass "dtl"]
        imageSrc <- attr "src" "img"
        href <- chroot ("div" @: [hasClass "gm_offer_description"]) $ attr "href" "a"
        description <- text $ "div" @: [hasClass "bodytext"]
        return $ Offer (trim title) (host ++ imageSrc) (host ++ href) (trim description)
        where host = "http://www.dhv.de"
