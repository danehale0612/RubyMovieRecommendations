require "minitest/autorun"
require_relative '../bootstrap_ar'

connect_to 'test'

ENV['FP_ENV'] = 'test'

module DatabaseCleaner
  def before_setup
    super
    Movie.destroy_all
  end
end

