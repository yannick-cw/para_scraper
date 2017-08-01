module SecondHandCrawler.SecondHandParserSpec where

import           SecondHandCrawler.SecondHandCrawler (SecondHandOffer (..),
                                                      parseHtml)
import           Test.Hspec

htmlString :: String
htmlString =
  "<html>\
\  <body>\
\  <div class='gm_offer' id='gm_offer_id_58952'>\
\      <div class='gm_offer_image '>\
\          <a href='/db3/gebrauchtmarkt/anzeige/id/58952' title='Mntor 2 M'>\
\     <img src='/dbfiles/gm/images/2017/08/thumbnail/15016070316652img58952.jpg' alt='&raquo; Details' title='Mntor 2 M' />\
\     </a>\
\      </div>\
\      <div class='gm_offer_description '>\
\          <h2><a href='/db3/gebrauchtmarkt/anzeige/id/58952' title='Zu den Angebot Details' class = 'dtl'>Mentor 3 M |  Check neu/ Tuch neuwertig</a></h2>\
\          <div class='bodytext'>\
\              Gepflegten Mentor 3 M zu verkaufen. Der Schirm wurde im Juni 2017 gecheckt: Tuch neuwertig!  Der Schirm hat eine kleine Flickstelle im Segel (Rauch...\
\          </div>\
\      </div>\
\    </div>\
\  </body>\
\</html>"

spec :: Spec
spec =
  describe "SecondHandParser" $ do
    it "should parse html as string to result datatype" $ parseHtml htmlString `shouldBe` [SecondHandOffer "testOffer"]
