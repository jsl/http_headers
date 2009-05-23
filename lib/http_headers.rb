# Class HttpHeaders parses a http header_str from Curl::Easy into component parts.
class HttpHeaders
  
  attr_reader :content
    
  def initialize(str)
    @content = str.split(/\\r\\n|\n|\r/)
  end

  def version
    @content[0].match(/HTTP\/\d\.\d/)[0]
  end
  
  def response_code
    @content[0].match(/HTTP\/\d\.\d (\d{3}.*)/)[1]
  end

  def method_missing(sym, *args)
    detect_multi_value_keys(sym)
  end
  
  private
  
  # Turns the given sym into a String after replacing the '_' character with the '-'
  def method_sym_to_http_key(sym)
    sym.to_s.gsub('_', '-')
  end
  
  def detect_multi_value_keys(tag)
    tag = method_sym_to_http_key(tag)
    regexp = /^#{tag}:/i
    results = @content.select{|e| e =~ regexp }.map{|e| value_from(e)}
    results.size <= 1 ? results.first : results
  end
  
  # Returns the key from this tag, which should be a string with key separated
  # from val by ':'
  def value_from(tag)
    tag.split(/:\W+/)[1]
  end
end