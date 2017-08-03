module Client
  ( getFbOffers
  , getSecondHandOffer
  ) where

import           CrawlerModels                         (Offer)
import           FacebookConnector                     (facebookRequest)
import           Network.HTTP.Client                   (newManager)
import           Network.HTTP.Client.TLS               (tlsManagerSettings)
import           SecondHandCrawler.SecondHandConnector (secondHandRequest)
import           Servant.Client
import           Servant.Common.Req                    (ServantError)

clientExecute :: String -> ClientM a -> IO (Either ServantError a)
clientExecute host query = do
  manager <- newManager tlsManagerSettings
  runClientM query (ClientEnv manager (BaseUrl Https host 443 ""))

getFbOffers :: String -> IO (Either ServantError [Offer])
getFbOffers token = clientExecute "graph.facebook.com" (facebookRequest token)

getSecondHandOffer :: IO (Either ServantError [Offer])
getSecondHandOffer = clientExecute "www.dhv.de" secondHandRequest
