require "tokens.rb"

# ERROR CLASSES #
class InvalidCharacterError
  def initialize(row, col, invalid_char, file)
    @row = row
    @col = col
    @invalid_char = invalid_char
    @file = file
  end

  def to_s
    "Invalid Character Error: Invalid Character \"#{@invalid_char}\"\n    Error At #{@row}:#{@col} In File #{@file}"
  end
end

# LEXER CLASS #
class Lexer 
  def initialize(text, file)
    @text = text
    @index = -1
    @current_char = nil
    @col = 0
    @row = 0
    @file = file
    advance
  end

  def advance()
    @index += 1
    @col += 1
    # if index is out of range it will automatically set @current_char to nil
    @current_char = @text[@index..@index]
    if @current_char == '\n'
      @col = 0
      @row += 1
      advance
    end
  end

  def make_word()
    word = ""
    while @current_char =~ /[a-zA-Z0-9_-]/
      word = word + @current_char
      advance
    end
    return word
  end
  
  def make_string()
    string = "\""
    advance
    while @current_char != "\""
      string = string + @current_char
      advance
    end
    string = string + "\""
    advance
    return string
  end

  def lex
    token_arr = []
    err = nil
    while @current_char != ""
      if @current_char == " " or @current_char == "\t"
        advance
      elsif @current_char == "\""
        token_arr.append(Token.new(STRING, make_string))
      elsif @current_char == "("
        token_arr.append(Token.new(LPAREN))
        advance
      elsif @current_char == ")"
        token_arr.append(Token.new(RPAREN))
        advance
      elsif @current_char =~ /[a-zA-Z]/
        token_arr.append(Token.new(KEYWORD, make_word))
      else
        return [], InvalidCharacterError.new(@row, @col, @current_char, @file)
      end
    end
    return token_arr, nil
  end
end