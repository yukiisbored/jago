-- |
-- This module contains an abstract syntax tree which represents an
-- HTML document
module Jago.AST where

import qualified Data.Text                     as T

-- |
-- Representation of attribute used within the list of attributes of
-- an element
type Attribute = (T.Text, T.Text)

-- | Representation of element and literal text
data Html
  = Element T.Text [Attribute] [Html]
  | Text T.Text
  deriving (Show, Read)

-- | Representation of document
type Document = [Html]
