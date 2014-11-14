ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'test/unit/rails/test_help'

class ActiveSupport::TestCase
  class << self
    def startup
      DatabaseRewinder.clean_all
    end
  end

  def setup
    DatabaseRewinder.clean
  end
end

class ActionController::TestCase
  class << self
    def startup
      DatabaseRewinder.clean_all
    end
  end

  def setup
    DatabaseRewinder.clean
  end
end
