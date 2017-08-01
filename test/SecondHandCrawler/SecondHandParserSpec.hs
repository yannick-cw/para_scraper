module SecondHandCrawler.SecondHandParserSpec where

import           SecondHandCrawler.SecondHandCrawler (SecondHandOffer (..),
                                                      parseHtml)
import           Test.Hspec

htmlString :: String -> String
htmlString divs = "<html><body>" ++ divs ++ "</body></html>"

offerHtml =
  "  <div class='gm_offer' id='gm_offer_id_58952'>\
\      <div class='gm_offer_image '>\
\          <a href='/offer' title='Mntor 2 M'>\
\     <img src='/src.jpg' alt='&raquo; Details' title='Mntor 2 M' />\
\     </a>\
\      </div>\
\      <div class='gm_offer_description '>\
\          <h2><a href='/offer' title='Zu den Angebot Details' class = 'dtl'>Mentor for test</a></h2>\
\          <div class='bodytext'>TestDescription                </div>\
\      </div>\
\    </div>"

spec :: Spec
spec =
  describe "SecondHandParser" $ do
    it "should parse html as string to result datatype" $ parseHtml (htmlString offerHtml) `shouldBe` [offer]
    it "should parse html as string to result datatype" $
      parseHtml (htmlString $ offerHtml ++ offerHtml) `shouldBe` [offer, offer]
  where
    offer =
      SecondHandOffer
      { title = "Mentor for test"
      , imgSrc = "http://www.dhv.de/src.jpg"
      , href = "http://www.dhv.de/offer"
      , description = "TestDescription"
      }
