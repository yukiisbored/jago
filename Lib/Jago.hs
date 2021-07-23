-- |
-- This module contains the compiler which compiles a Jago
-- document to an HTML document.
module Jago
  ( compile
  ) where

import qualified Data.Text                     as T
import           Jago.Html                      ( compileDocument )
import           Jago.Parser                    ( parse )
import           Text.Parsec                    ( ParseError )

-- |
-- Compiles a Jago document to an HTML document
--
-- Uses the file path for error reporting
compile :: FilePath -> T.Text -> Either ParseError T.Text
compile path text = compileDocument <$> parse path text
