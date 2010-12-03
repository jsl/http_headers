require 'spec_helper'

describe HttpHeaders do
  it "should parse the version from the header string" do
    HttpHeaders.new('HTTP/1.1 200 OK\r\n').version.should == 'HTTP/1.1'
  end
  
  it "should have 200 OK as the response code" do 
    HttpHeaders.new('HTTP/1.1 200 OK\r\n').response_code.should == '200 OK'
  end
  
  it "should have an etag if one is not present in header string" do
    HttpHeaders.new('HTTP/1.1 200 OK\r\n').etag.should be_nil
  end

  it "should correctly strip a field wrapped in quotes" do
    HttpHeaders.new('ETag: "1edec-3e3073913b100"').etag.should == '1edec-3e3073913b100'
  end
  
  it "should correctly parse a date field" do
    HttpHeaders.new("Date: Fri, 22 May 2009 18:18:08 GMT").date.should == 'Fri, 22 May 2009 18:18:08 GMT'
  end
  
  it "should correctly parse an expires field" do
    HttpHeaders.new("Expires: Fri, 22 May 2009 18:18:08 GMT").expires.should == 'Fri, 22 May 2009 18:18:08 GMT'
  end
  
  it "should properly parse the cache-control field" do
    HttpHeaders.new('Cache-Control: private, max-age=0').cache_control.should == 'private, max-age=0'
  end
  
  it "should have correctly parse Last-Modfied" do
    HttpHeaders.new('Last-Modified: Fri, 22 May 2009 15:35:08 GMT').last_modified.should == 'Fri, 22 May 2009 15:35:08 GMT'
  end
  
  it "should parse the server type" do
    HttpHeaders.new("Server: GFE/2.0").server.should == 'GFE/2.0'
  end  
  
  it "should correctly parse the pragma" do
    HttpHeaders.new('Pragma: no-cache').pragma.should == 'no-cache'
  end

  describe "#fields" do

    before {pending}
    
    it "should return a collection of fields in the HTTP header" do
      HttpHeaders.new('Pragma: no-cache\r\nCache-Control: private').field_names.should == ['Pragma', 'Cache-Control']
    end

    it "should not include the header" do
      HttpHeaders.new('HTTP/1.1 200 OK\r\n').response_code.should == [ ]      
    end

    it "should remove duplicates from the list" do
      HttpHeaders.new('Set-Cookie: foo\r\nSet-Cookie: bar').field_names.should == ['Set-Cookie']      
    end
  end
  
  describe "breaking lines in header" do
    it "should parse fields when separated by a normal newline" do
      header = HttpHeaders.new(<<-EOS)
HTTP/1.1 200 OK
Last-Modified: Fri, 22 May 2009 15:35:08 GMT
ETag: pnDSjJtGvlc2WrX6VND/w0qxEc8
EOS

      header.etag.should == 'pnDSjJtGvlc2WrX6VND/w0qxEc8'
    end

    it "should break lines when separated by \\r\\n" do
      HttpHeaders.new("HTTP/1.1 200 OK\r\nServer: Sun-ONE-Web-Server/6.1\r\nDate: Fri, 22 May 2009 12:53:02 GMT\r\n").date.should == "Fri, 22 May 2009 12:53:02 GMT"
    end
  end

  describe "strict mode" do
    it "should not recognize headers with values containing _ if strict mode is on" do
      HttpHeaders.new("Foo_bar: baz", :strict => true).foo_bar.should be_nil  
    end

    it "should recognize headers with values containing _ if strict mode is off" do
      HttpHeaders.new("Foo_bar: baz", :strict => false).foo_bar.should == 'baz'
    end

    it "should have strict mode on by default" do
      HttpHeaders.new("Foo_bar: baz").strict_mode.should be_true      
    end    
  end

  describe "multi-valued keys" do
    before do
      @headers = <<EOS
HTTP/1.1 200 OK
Server: Sun-ONE-Web-Server/6.1
Set-cookie: RMID=21167df34c454a16a02ee2e1; expires=Saturday, 22-May-2010 12:53:02 GMT; path=/; domain=.nytimes.com
Set-cookie: adxcs=-; path=/; domain=.nytimes.com
Set-cookie: adxcs=-; path=/; domain=.nytimes.com
EOS
    end
    
    it "should have three cookies" do
      HttpHeaders.new(@headers).set_cookie.size.should == 3
    end
    
    it "should have adxcs=-; path=/; domain=.nytimes.com as value for one cookie" do
      HttpHeaders.new(@headers).set_cookie.include?("adxcs=-; path=/; domain=.nytimes.com").should be_true
    end
  end
end