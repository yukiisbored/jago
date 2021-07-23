-- |
-- This module contains the Jago compiler
module Jago.Compiler
  ( compile
  ) where

import qualified Data.Text                     as T
import           Jago.Parser                    ( parse )
import           Jago.Render.Html               ( render )
import           Text.Parsec                    ( ParseError )

-- |
-- Compiles a Jago document to an HTML document
--
-- The file path is used for error messages during parsing.
compile :: FilePath -> T.Text -> Either ParseError T.Text
compile path text = render <$> parse path text
