Gem::Specification.new do |s|
  s.name     = "http_headers"
  s.version  = "0.0.1"
  s.date     = "2009-05-22"
  s.summary  = "Library for parsing the Curl header_str into attributes"
  s.email    = "justin@phq.org"
  s.homepage = "http://github.com/jsl/hashback"
  s.description = "Creates an object from the attributes in a header_str from Curl"
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
