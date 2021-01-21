module Main where

import Cock.Parser (parser)
import Cock.Html (translateDocument, Html)

import Control.Applicative ((<**>))

import Text.Parsec.Indent (runIndentParser)
import Options.Applicative ( header
                           , progDesc
                           , fullDesc
                           , execParser
                           , helper
                           , info
                           , help
                           , metavar
                           , short
                           , long
                           , strOption
                           , Parser)

import qualified Data.Text.IO as TIO

data Config = Config { inputFile :: FilePath
                     , outputFile :: FilePath }

config :: Parser Config
config = Config
      <$> strOption
          ( long "input"
         <> short 'i'
         <> metavar "INPUT"
         <> help "Cock file as to compile")
      <*> strOption
          ( long "output"
         <> short 'o'
         <> metavar "OUTPUT"
         <> help "Resulting html output")

readCock :: FilePath -> IO [Html]
readCock path = do
  file <- TIO.readFile path

  let documentMaybe = runIndentParser parser () path file

  case documentMaybe of
    Left err -> fail (show err)
    Right document -> return document

compile :: Config -> IO ()
compile (Config inputPath outputPath) = do
  document <- readCock inputPath
  let document' = translateDocument document
  TIO.writeFile outputPath document'

main :: IO ()
main = compile =<< execParser opts
  where opts = info (config <**> helper)
                    ( fullDesc
                   <> progDesc "Compile cock to html"
                   <> header "cock - A simplified markup language that compiles to HTML")
