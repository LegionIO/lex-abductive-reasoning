# frozen_string_literal: true

require_relative 'lib/legion/extensions/abductive_reasoning/version'

Gem::Specification.new do |spec|
  spec.name          = 'lex-abductive-reasoning'
  spec.version       = Legion::Extensions::AbductiveReasoning::VERSION
  spec.authors       = ['Esity']
  spec.email         = ['matthewdiverson@gmail.com']

  spec.summary       = 'LEX Abductive Reasoning'
  spec.description   = 'Peirce abductive reasoning engine — inference to the best explanation for brain-modeled agentic AI'
  spec.homepage      = 'https://github.com/LegionIO/lex-abductive-reasoning'
  spec.license       = 'MIT'
  spec.required_ruby_version = '>= 3.4'

  spec.metadata['homepage_uri']        = spec.homepage
  spec.metadata['source_code_uri']     = 'https://github.com/LegionIO/lex-abductive-reasoning'
  spec.metadata['documentation_uri']   = 'https://github.com/LegionIO/lex-abductive-reasoning'
  spec.metadata['changelog_uri']       = 'https://github.com/LegionIO/lex-abductive-reasoning'
  spec.metadata['bug_tracker_uri']     = 'https://github.com/LegionIO/lex-abductive-reasoning/issues'
  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir.glob('{lib,spec}/**/*') + %w[lex-abductive-reasoning.gemspec Gemfile]
  end
  spec.require_paths = ['lib']
  spec.add_development_dependency 'legion-gaia'
end
