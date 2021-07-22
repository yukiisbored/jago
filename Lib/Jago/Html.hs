-- |
-- This module contains the intermediate generalized representation for
-- HTML and functions that is able to construct an HTML document from
-- the representation.
module Jago.Html
  ( HtmlAttribute
  , Html(..)
  , translateAttribute
  , translateAttributes
  , translateHtml
  , translateDocument
  ) where

import qualified Data.Text                     as T

-- | Representation of an HTML attribute
type HtmlAttribute = (T.Text, T.Text)

-- | Representation of a HTML tag or a text literal
data Html
  = HtmlTag T.Text [HtmlAttribute] [Html]
  | HtmlLiteral T.Text
  deriving (Show, Read)

-- | Translate HtmlAttribute representation to proper HTML attribute
translateAttribute :: HtmlAttribute -> T.Text
translateAttribute (k, v) = mconcat [k, "=", "\"", v, "\""]

-- | Translate a list of HtmlAttributes into proper HTML attributes
translateAttributes :: [HtmlAttribute] -> T.Text
translateAttributes = T.intercalate " " . map translateAttribute

-- | Translate a Html representation to proper HTML
translateHtml :: Html -> T.Text
translateHtml (HtmlLiteral t              ) = t
translateHtml (HtmlTag tagName attrs child) = mconcat [start, child', end]
 where
  start = case attrs of
    [] -> mconcat ["<", tagName, ">"]
    xs -> mconcat ["<", tagName, " ", translateAttributes xs, ">"]
  end    = mconcat ["</", tagName, ">"]
  child' = mconcat $ map translateHtml child

-- | Translate a document to proper HTML
translateDocument :: [Html] -> T.Text
translateDocument doc = mconcat [doc', "\n"]
  where doc' = mconcat $ map translateHtml doc
