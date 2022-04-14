# frozen_string_literal: true

require_relative "smple/version"
require "lexer.rb"

module Smple
  class Error < StandardError; end
  

  text = "print(\"Hello, World!\")"
  lexer = Lexer.new(text, "<stdin>")
  tokens, err = lexer.lex

  puts err if err
  puts tokens


end
