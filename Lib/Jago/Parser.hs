-- |
-- This module parses a Jago document to an HTML representation
-- defined in @Jago.AST@
module Jago.Parser
  ( parse
  ) where

import           Control.Monad                  ( void )
import qualified Data.Text                     as T
import           Jago.AST                       ( Attribute
                                                , Document
                                                , Html(Element, Text)
                                                )
import           Text.Parsec                    ( (<?>)
                                                , (<|>)
                                                , ParseError
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
                                                , runIndentParser
                                                , withPos
                                                )

-- | Indentation-sensitive parser for Jago
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

-- | Symbol helper
symbol :: Char -> Parser ()
symbol = void . lexeme . char

-- | Identifier definition
identifier :: Parser T.Text
identifier = do
  id <- many1 ch
  return $ T.pack id
  where ch = alphaNum <|> char '-'

-- | String definition
string :: Parser T.Text
string = string' (char '"') <|> string' (char '`') <?> "string"
 where
  string' :: Parser Char -> Parser T.Text
  string' g = do
    str <- g *> manyTill anyChar (lexeme g)
    return $ T.pack str

-- | Attribute definition
attribute :: Parser Attribute
attribute = do
  k <- identifier <* symbol '=' <?> "attribute name"
  v <- string <?> "attribute value"

  return (k, v) <?> "attribute"

-- | Attributes definition
attributes :: Parser [Attribute]
attributes =
  between (symbol '[') (symbol ']') (sepBy attribute sc) <?> "attributes"

-- | Literal definition
literal :: Parser Html
literal = lexeme (Text <$> string) <?> "literal text"

-- | Tag definition
element :: Parser Html
element = withPos $ do
  name  <- lexeme identifier <?> "tag name"
  attrs <- lexeme $ option [] attributes
  child <- lexeme $ many $ indented *> html

  return (Element name attrs child) <?> "tag"

-- | Html definition
html :: Parser Html
html = lexeme $ element <|> literal

-- | Document definition
document :: Parser Document
document = sc *> many html <* eof

-- | Parse jago document to AST representation defined in @Jago.AST@
parse :: FilePath -> T.Text -> Either ParseError Document
parse = runIndentParser document ()
