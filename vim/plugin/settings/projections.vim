let g:rails_projections = {
      \  "app/controllers/*_controller.rb": {
      \      "test": [
      \        "spec/requests/{}_spec.rb",
      \        "spec/controllers/{}_controller_spec.rb",
      \        "test/controllers/{}_controller_test.rb"
      \      ],
      \      "alternate": [
      \        "spec/requests/{}_spec.rb",
      \        "spec/controllers/{}_controller_spec.rb",
      \        "test/controllers/{}_controller_test.rb"
      \      ],
      \   },
      \   "spec/requests/*_spec.rb": {
      \      "command": "request",
      \      "alternate": "app/controllers/{}_controller.rb",
      \      "template": "require 'rails_helper'\n\n" .
      \        "RSpec.describe '{}' do\nend",
      \   },
      \   "app/services/*.rb": {
      \     "command": "service",
      \     "test": [
      \       "spec/services/%s_spec.rb",
      \       "test/services/%s_test.rb"
      \     ],
      \      "template": [
      \        "class {camelcase|capitalize|colons}",
      \        "  def self.call(*args)",
      \        "    new(*args).call",
      \        "  end",
      \        "",
      \        "  def initialize(*args)",
      \        "  end",
      \        "",
      \        "  def call",
      \        "  end",
      \        "end"
      \      ]
      \   },
      \ }
