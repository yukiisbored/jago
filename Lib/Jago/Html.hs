-- |
-- This module contains an abstract syntax tree which compiles to a
-- HTML document
module Jago.Html
  ( Attribute
  , Html(..)
  , compileDocument
  ) where

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

-- | Compile Html attributes to used by an element
compileAttributes :: [Attribute] -> T.Text
compileAttributes = T.intercalate " " . map compileAttribute
  where compileAttribute (k, v) = mconcat [k, "=", "\"", v, "\""]

-- | Compile either literal text or an element
compileHtml :: Html -> T.Text
compileHtml (Text t                  ) = t
compileHtml (Element name attrs child) = mconcat [start, child', end]
 where
  start = case attrs of
    [] -> mconcat ["<", name, ">"]
    xs -> mconcat ["<", name, " ", compileAttributes xs, ">"]
  end    = mconcat ["</", name, ">"]
  child' = mconcat $ map compileHtml child

-- | Compile document
compileDocument :: [Html] -> T.Text
compileDocument doc = mconcat [doc', "\n"]
  where doc' = mconcat $ map compileHtml doc
