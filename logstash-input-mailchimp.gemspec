Gem::Specification.new do |s|
  s.name = 'logstash-input-mailchimp'
  s.version         = '0.1.8'
  s.licenses = ['Apache License (2.0)']
  s.summary = "Pulls data from MailChimp at a definable interval and inputs it."
  s.description = "Pulls data from MailChimp at a definable interval and inputs it."
  s.authors = ["CodeBoffins"]
  s.email = 'synnott@gmail.com'
  s.homepage = "http://www.codeboffins.com"
  s.require_paths = ["lib"]

  # Files
  s.files = `git ls-files`.split($\)
   # Tests
  s.test_files = s.files.grep(%r{^(test|spec|features)/})

  # Special flag to let us know this is actually a logstash plugin
  s.metadata = { "logstash_plugin" => "true", "logstash_group" => "input" }

  # Gem dependencies
  s.add_runtime_dependency "logstash-core", '>= 1.4.0', '< 2.0.0'
  s.add_runtime_dependency 'logstash-codec-plain'
  s.add_runtime_dependency 'stud'
  s.add_runtime_dependency 'mailchimp'
  s.add_runtime_dependency 'mailchimp-api'
  s.add_development_dependency 'logstash-devutils'
end