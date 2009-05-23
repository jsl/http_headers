require File.join(File.dirname(__FILE__), %w[spec_helper])

describe HttpHeaders do
  before do
    @h  = HttpHeaders.new(File.read(File.join(File.dirname(__FILE__), %w[fixtures headers.txt])))
    @h2 = HttpHeaders.new(File.read(File.join(File.dirname(__FILE__), %w[fixtures headers2.txt])))
  end
  
  it "should have text/html as the content_type" do
    @h.version.should == 'HTTP/1.1'
  end
  
  it "should have 200 OK as the response code" do 
    @h.response_code.should == '200 OK'
  end
  
  it "should have a nil etag for the first header file" do
    @h.etag.should be_nil
  end
  
  it "should have an etag of pnDSjJtGvlc2WrX6VND/w0qxEc8" do
    @h2.etag.should == 'pnDSjJtGvlc2WrX6VND/w0qxEc8'
  end
  
  it "should have Fri, 22 May 2009 18:18:08 GMT for date" do
    @h2.date.should == 'Fri, 22 May 2009 18:18:08 GMT'
  end
  
  it "should have Fri, 22 May 2009 18:18:08 GMT for expires" do
    @h2.expires.should == 'Fri, 22 May 2009 18:18:08 GMT'
  end
  
  it "should have private, max-age=0 for cache_control" do
    @h2.cache_control.should == 'private, max-age=0'
  end
  
  it "should have Fri, 22 May 2009 15:35:08 GMT for last_modified" do
    @h2.last_modified.should == 'Fri, 22 May 2009 15:35:08 GMT'
  end
  
  it "should have GFE/2.0 for server" do
    @h2.server.should == 'GFE/2.0'
  end  
  
  it "should have no-cache for pragma" do
    @h.pragma.should == 'no-cache'
  end
  
  it "should have chunked for transfer_encoding" do
    @h2.transfer_encoding.should == 'chunked'
  end
  
  describe "multi-valued keys like Set-cookie:" do
    before do
      @c = @h.set_cookie
    end
    
    it "should return an Array if multiple values are present" do
      @c.should be_a(Array)
    end
    
    it "should have three cookies" do
      @c.size.should == 3
    end
    
    it "should have adxcs=-; path=/; domain=.nytimes.com as value for one cookie" do
      @c.include?("adxcs=-; path=/; domain=.nytimes.com").should be_true
    end
  end
end