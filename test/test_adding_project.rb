require 'test_helper'

class TestAddingMovie < Test::Unit::TestCase
  def test_takes_arguments_and_saves_them
    # start with no projects
    assert_equal 0, Movie.count
    project = Movie.create( Title: 'Collateral' )
    assert_equal 1, Movie.count
  end
end
