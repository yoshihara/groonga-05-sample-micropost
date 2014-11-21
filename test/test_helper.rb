ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'test/unit/rails/test_help'

module DatabaseConfiguration
  def self.included(klass)
    klass.extend Startup
    include Setup
  end

  module Startup
    def startup
      DatabaseRewinder.clean_all
      MicropostIndex.truncate
    end
  end

  module Setup
    def setup
      DatabaseRewinder.clean
      MicropostIndex.truncate
    end
  end
end
