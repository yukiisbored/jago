module Main where

import           Cock.Html                      ( Html
                                                , translateDocument
                                                )
import           Cock.Parser                    ( parser )
import           Control.Applicative            ( (<**>) )
import           Data.Maybe                     ( fromMaybe )
import qualified Data.Text                     as T
import qualified Data.Text.IO                  as TIO
import           Options.Applicative            ( Parser
                                                , execParser
                                                , footer
                                                , fullDesc
                                                , header
                                                , help
                                                , helper
                                                , info
                                                , long
                                                , metavar
                                                , progDesc
                                                , short
                                                , strOption
                                                )
import           Options.Applicative            ( optional )
import           Text.Parsec                    ( ParseError )
import           Text.Parsec.Indent             ( runIndentParser )

data Config = Config
  { inputFile  :: Maybe FilePath
  , outputFile :: Maybe FilePath
  }

config :: Parser Config
config =
  Config
    <$> optional
          (strOption
            (long "input" <> short 'i' <> metavar "INPUT" <> help
              "Cock file acting as input"
            )
          )
    <*> optional
          (strOption
            (long "output" <> short 'o' <> metavar "OUTPUT" <> help
              "Output html file"
            )
          )

compile :: FilePath -> T.Text -> Either ParseError T.Text
compile path cock = translateDocument <$> documentMaybe
  where documentMaybe = runIndentParser parser () path cock

compileIO :: FilePath -> T.Text -> IO T.Text
compileIO path cock = case compile path cock of
  Left  err      -> fail $ show err
  Right document -> return document

cli :: Config -> IO ()
cli (Config inMaybe outMaybe) = do
  cock <- maybe TIO.getContents TIO.readFile inMaybe
  let inPath = fromMaybe "stdin" inMaybe
  compiled <- compileIO inPath cock

  case outMaybe of
    Just outPath -> TIO.writeFile outPath compiled
    Nothing      -> TIO.putStr compiled

main :: IO ()
main = cli =<< execParser opts
 where
  opts = info
    (config <**> helper)
    (  fullDesc
    <> progDesc "Compile cock to html"
    <> header "cock - simplified markup language to author HTML pages"
    <> footer "https://git.yukiisbo.red/yuki/cock"
    )
