# frozen_string_literal: true

require_relative "smple/version"
require "lexer.rb"
require "parser.rb"

module Smple
  class Error < StandardError; end
  

  text = "print(\"Hello, World!\");"
  lexer = Lexer.new(text, "<stdin>")
  tokens, err = lexer.lex
  puts err if err
  
  # puts tokens

  parser = Parser.new(tokens, "<stdin>")
  ast, err = parser.parse
  puts err if err

  # puts ast

  # Code interpretation
  for node in ast
    if node.node_type == FUNCTION_CALL
      if node.node_val == "print"
        puts node.node_args[0]
      end
    end
  end
end
