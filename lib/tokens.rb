# TOKEN TYPES #
KEYWORD = "KEYWORD"
DQUOTES = "DQUOTES"
LPAREN  = "LPAREN"
RPAREN  = "RPAREN"
STRING  = "STRING"

# TOKEN CLASS #
class Token 
  attr_reader :tok_type, :tok_val
  def initialize(tok_type, tok_val=nil) 
    @tok_type = tok_type
    @tok_val = tok_val
  end

  def to_s
    return "< #{@tok_type} #{@tok_val} >" if @tok_val != nil
    return "< #{@tok_type} >"
  end
end












