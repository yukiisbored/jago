module Main where

import           Cock.Html                      ( Html
                                                , translateDocument
                                                )
import           Cock.Parser                    ( parser )
import           Control.Applicative            ( (<**>) )
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
import           Text.Parsec.Indent             ( runIndentParser )

data Config = Config
  { inputFile  :: FilePath
  , outputFile :: FilePath
  }

config :: Parser Config
config =
  Config
    <$> strOption
          (long "input" <> short 'i' <> metavar "INPUT" <> help
            "Cock file as to compile"
          )
    <*> strOption
          (long "output" <> short 'o' <> metavar "OUTPUT" <> help
            "Resulting html output"
          )

readCock :: FilePath -> IO [Html]
readCock path = do
  file <- TIO.readFile path

  let documentMaybe = runIndentParser parser () path file

  case documentMaybe of
    Left  err      -> fail (show err)
    Right document -> return document

compile :: Config -> IO ()
compile (Config inputPath outputPath) = do
  document <- readCock inputPath
  let document' = translateDocument document
  TIO.writeFile outputPath document'

main :: IO ()
main = compile =<< execParser opts
 where
  opts = info
    (config <**> helper)
    (  fullDesc
    <> progDesc "Compile cock to html"
    <> header "cock - simplified markup language to author HTML pages"
    <> footer "https://git.yukiisbo.red/yuki/cock"
    )
