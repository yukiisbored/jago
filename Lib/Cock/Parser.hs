-- | Parser that parses cock
module Cock.Parser
  ( parser
  ) where

import           Cock.Html                      ( Html(HtmlLiteral, HtmlTag)
                                                , HtmlAttribute
                                                )
import qualified Data.Text                     as T
import           Text.Parsec                    ( (<|>)
                                                , alphaNum
                                                , anyChar
                                                , between
                                                , char
                                                , eof
                                                , many
                                                , many1
                                                , manyTill
                                                , option
                                                , sepBy
                                                , spaces
                                                )
import           Text.Parsec.Indent             ( IndentParser
                                                , indented
                                                , withPos
                                                )

-- | Parser definition which uses Text as stream
type Parser a = IndentParser T.Text () a

-- | Definition for "identifier characters"
identifierChar :: Parser Char
identifierChar = alphaNum <|> char '-'

string :: Parser T.Text
string = string' (char '"') <|> string' (char '`')
 where
  string' :: Parser Char -> Parser T.Text
  string' g = do
    str <- g *> manyTill anyChar g
    return $ T.pack str

-- | Parse attribute
attribute :: Parser HtmlAttribute
attribute = do
  k <- manyTill identifierChar (char '=')
  v <- string

  return (T.pack k, v)

-- | Parse attributes
attributes :: Parser [HtmlAttribute]
attributes = between (char '[') (char ']') (sepBy attribute spaces)

-- | Parse literals
literal :: Parser Html
literal = HtmlLiteral <$> string

-- | Parse tags
tag :: Parser Html
tag = withPos $ do
  name  <- many1 identifierChar <* spaces
  attrs <- option [] attributes <* spaces
  child <- many $ indented *> html <* spaces

  return $ HtmlTag (T.pack name) attrs child

-- | Parse html
html :: Parser Html
html = tag <|> literal <* spaces

-- | Parse cock documents
parser :: Parser [Html]
parser = spaces *> many html <* eof
