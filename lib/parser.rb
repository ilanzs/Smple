require "tokens.rb"

# ERROR CLASS #
class InvalidSyntaxError
  def initialize(expected, file)
    @expected = expected
    @file = file
  end

  def to_s
    return "Invalid Syntax Error: Expected #{@expected}\n Error in #{@file}!"
  end
end

# NODE TYPES #
FUNCTION_CALL = "FUNCTION_CALL"

# NODE CLASSES #
class FunctionNode
  attr_reader :node_type, :node_val, :node_args
  def initialize(node_type, node_val, node_args)
    @node_type = node_type
    @node_val = node_val
    @node_args = node_args
  end

  def to_s
    return "(#{@node_type} #{@node_val} #{@node_args})"
  end
end

# PARSER CLASS #
class Parser
  # TODO: Parse token array generated in the lexer and validate it's grammatical correctness
  def initialize(tok_arr, file)
    @tok_arr = tok_arr
    @index = -1
    @current_tok = nil
    @file = file
    advance
  end

  def advance()
    @index += 1
    @current_tok = @tok_arr[@index]
  end

  def parse()
    ast = []
    while @current_tok != nil 
      # this only includes function calls at this moment
      if @current_tok.tok_type == KEYWORD
        func_name = @current_tok.tok_val
        advance
        if @current_tok.tok_type != LPAREN
          return [], InvalidSyntaxError.new("Left Parentheses", @file)
        end
        advance
        arg = @current_tok.tok_val
        advance
        if @current_tok.tok_type != RPAREN
          return [], InvalidSyntaxError.new("Right Parantheses", @file)
        end
        ast.append(FunctionNode.new(FUNCTION_CALL, func_name, [arg]))
      end
      advance
    end
    return ast, nil
  end
end