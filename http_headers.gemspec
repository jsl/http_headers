Gem::Specification.new do |s|
  s.name     = "http_headers"
  s.version  = "0.0.2.2"
  s.date     = "2009-05-25"
  s.summary  = "Library for parsing the Curl header_str into attributes"
  s.email    = "justin@phq.org"
  s.homepage = "http://github.com/jsl/http_headers"
  s.description = "Parses a HTTP header string into individual header fields"
  s.has_rdoc = true
  s.authors  = ["Justin Leitgeb"]
  s.files    = [
    "Rakefile",
    "http_headers.gemspec",
    "LICENSE",
    "README.rdoc",
    "Rakefile",
    "spec/http_headers_spec.rb",
    "spec/fixtures/headers.txt",
    "spec/fixtures/headers2.txt",
    "spec/fixtures/headers3.txt",
    "lib/http_headers.rb"
  ]
  s.test_files = [
    "spec/http_headers_spec.rb",
    "spec/spec_helper.rb"
  ]
  
  s.extra_rdoc_files = [ "README.rdoc" ]
  
  s.rdoc_options += [
    '--title', 'HttpHeaders',
    '--main', 'README.rdoc',
    '--line-numbers',
    '--inline-source'
   ]
end
