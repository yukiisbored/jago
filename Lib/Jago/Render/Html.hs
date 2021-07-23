module Jago.Render.Html
  ( render
  ) where

import qualified Data.Text                     as T
import           Jago.AST                       ( Attribute
                                                , Document
                                                , Html(..)
                                                )

-- | Render Html attributes to used by an element
renderAttributes :: [Attribute] -> T.Text
renderAttributes = T.intercalate " " . map renderAttribute
  where renderAttribute (k, v) = mconcat [k, "=", "\"", v, "\""]

-- | Render either literal text or an element
renderHtml :: Html -> T.Text
renderHtml (Text t                  ) = t
renderHtml (Element name attrs child) = mconcat [start, child', end]
 where
  start = case attrs of
    [] -> mconcat ["<", name, ">"]
    xs -> mconcat ["<", name, " ", renderAttributes xs, ">"]
  end    = mconcat ["</", name, ">"]
  child' = mconcat $ map renderHtml child

-- | Render document
render :: Document -> T.Text
render doc = mconcat [doc', "\n"] where doc' = mconcat $ map renderHtml doc
