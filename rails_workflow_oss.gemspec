Gem::Specification.new do |s|
  s.name        = 'rails_workflow_oss'
  s.version     = '0.5.0'
  s.authors     = ['Maxim Madzhuga']
  s.email       = ['maximmadzhuga@gmail.com']
  s.homepage    = 'https://github.com/madzhuga/rails_workflow_oss'
  s.summary     = 'OSS Workflow engine implementation'
  s.description = <<-DESC
    Rails engine allowing to configure and manage business processes in rails
    including user operations, background operations, etc. '
  DESC
  s.license = 'MIT'
  s.files = Dir['{lib}/**/*']
  s.test_files = Dir['spec/**/*']
end
