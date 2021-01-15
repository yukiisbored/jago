module Cock.Parser where

import Text.Megaparsec (Parsec)
import Data.Void (Void)
import Cock.Internal.Html (HtmlAttribute, Html)
import qualified Data.Text as T

type Parser = Parsec Void T.Text

attribute :: Parser HtmlAttribute
attribute = undefined

attributes :: Parser [HtmlAttribute]
attributes = undefined

literal :: Parser Html
literal = undefined

tag :: Parser Html
tag = undefined

document :: Parser [Html]
document = undefined
