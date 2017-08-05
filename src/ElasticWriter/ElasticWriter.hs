{-# LANGUAGE OverloadedStrings #-}

module ElasticWriter.ElasticWriter
  ( writer
  ) where

import           Control.Monad.IO.Class (liftIO)
import           CrawlerModels          (Offer (..))
import           Data.Text              (pack)
import           Data.UUID              (toString)
import           Data.UUID.V4           (nextRandom)
import           Database.Bloodhound
import           Network.HTTP.Client    (defaultManagerSettings)

writer :: [Offer] -> IO ()
writer offers =
  runBH' $
   -- set up index
   do
    offersWithId <- liftIO $ traverse addId offers
    _ <- createIndex indexSettings indexName
    True <- indexExists indexName
    _ <- traverse (uncurry indexIt) offersWithId
    return ()
  where
    testServer = (Server "http://localhost:9200")
    runBH' = withBH defaultManagerSettings testServer
    indexName = IndexName "offer"
    mapping = MappingName "offers"
    indexSettings = IndexSettings (ShardCount 1) (ReplicaCount 0)
    indexIt = indexDocument indexName mapping defaultIndexDocumentSettings

addId :: Offer -> IO (Offer, DocId)
addId offer = fmap (\uuid -> (offer, DocId $ pack (toString uuid))) nextRandom
