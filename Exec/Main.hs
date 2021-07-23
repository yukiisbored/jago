module Main where

import           Control.Applicative            ( (<**>) )
import           Data.Maybe                     ( fromMaybe )
import qualified Data.Text                     as T
import qualified Data.Text.IO                  as TIO
import           Jago                           ( compile )
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
                                                , optional
                                                , progDesc
                                                , short
                                                , strOption
                                                )
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
              "Jago file acting as input"
            )
          )
    <*> optional
          (strOption
            (long "output" <> short 'o' <> metavar "OUTPUT" <> help
              "Output html file"
            )
          )

compileIO :: FilePath -> T.Text -> IO T.Text
compileIO path jago = case compile path jago of
  Left  err      -> fail $ show err
  Right document -> return document

cli :: Config -> IO ()
cli (Config inMaybe outMaybe) = do
  jago <- maybe TIO.getContents TIO.readFile inMaybe
  let inPath = fromMaybe "stdin" inMaybe
  compiled <- compileIO inPath jago

  case outMaybe of
    Just outPath -> TIO.writeFile outPath compiled
    Nothing      -> TIO.putStr compiled

main :: IO ()
main = cli =<< execParser opts
 where
  opts = info
    (config <**> helper)
    (  fullDesc
    <> progDesc "Compile jago to html"
    <> header "jago - simplified markup language to author HTML pages"
    <> footer "https://git.sr.ht/~yuki_is_bored/jago"
    )
