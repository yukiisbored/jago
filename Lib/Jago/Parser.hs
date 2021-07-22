-- | Parser that parses jago
module Jago.Parser
  ( parser
  ) where

import           Jago.Html                      ( Html(HtmlLiteral, HtmlTag)
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
                                                , choice
                                                , eof
                                                , many
                                                , many1
                                                , manyTill
                                                , oneOf
                                                , option
                                                , sepBy
                                                , try
                                                )
import           Text.Parsec.Indent             ( IndentParser
                                                , indented
                                                , withPos
                                                )

-- | Parser definition which uses Text as stream
type Parser a = IndentParser T.Text () a

-- | Whitespace and comment definition
sc :: Parser ()
sc = choice [whitespace *> sc, comment *> sc, return ()]
 where
  comment =
    try (char '#') *> manyTill anyChar (void (char '\n') <|> eof) <?> "comment"
  whitespace = void (many1 (oneOf " \t\n") <?> "whitespace")

-- | Lexeme definition
lexeme :: Parser a -> Parser a
lexeme p = p <* sc

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
string = string' (char '"') <|> string' (char '`') <?> "string"
 where
  string' :: Parser Char -> Parser T.Text
  string' g = do
    str <- g *> manyTill anyChar (lexeme g)
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
  between (symbol '[') (symbol ']') (sepBy attribute sc) <?> "attributes"

-- | Parse literals
literal :: Parser Html
literal = lexeme (HtmlLiteral <$> string) <?> "literal text"

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

-- | Parse jago documents
parser :: Parser [Html]
parser = sc *> many html <* eof
