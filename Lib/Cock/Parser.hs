-- | Parser that parses cock
module Cock.Parser
  ( parser
  ) where

import           Cock.Html                      ( Html(HtmlLiteral, HtmlTag)
                                                , HtmlAttribute
                                                )
import           Control.Monad                  ( void )
import qualified Data.Text                     as T
import           Text.Parsec                    ( (<?>)
                                                , (<|>)
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

-- | Lexeme definition
lexeme :: Parser a -> Parser a
lexeme p = p <* spaces

-- | Helper to identify symbols
symbol :: Char -> Parser ()
symbol = void . lexeme . char

-- | Parse identifier
identifier :: Parser T.Text
identifier = do
  id <- many1 ch
  return $ T.pack id
  where ch = alphaNum <|> char '-'

-- | Parse string with backticks or double-quotes
string :: Parser T.Text
string = string' (symbol '"') <|> string' (symbol '`') <?> "string"
 where
  string' :: Parser () -> Parser T.Text
  string' g = do
    str <- g *> manyTill anyChar g
    return $ T.pack str

-- | Parse attribute
attribute :: Parser HtmlAttribute
attribute = do
  k <- identifier <* symbol '=' <?> "attribute name"
  v <- string <?> "attribute value"

  return (k, v) <?> "attribute"

-- | Parse attributes
attributes :: Parser [HtmlAttribute]
attributes =
  between (symbol '[') (symbol ']') (sepBy attribute spaces) <?> "attributes"

-- | Parse literals
literal :: Parser Html
literal = HtmlLiteral <$> string <?> "literal text"

-- | Parse tags
tag :: Parser Html
tag = withPos $ do
  name  <- lexeme identifier <?> "tag name"
  attrs <- lexeme $ option [] attributes
  child <- lexeme $ many $ indented *> html

  return (HtmlTag name attrs child) <?> "tag"

-- | Parse html
html :: Parser Html
html = lexeme $ tag <|> literal

-- | Parse cock documents
parser :: Parser [Html]
parser = spaces *> many html <* eof
