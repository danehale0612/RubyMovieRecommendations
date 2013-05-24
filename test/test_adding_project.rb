require_relative 'test_helper'

class TestAddingMovie < MiniTest::Unit::TestCase
  def test_takes_arguments_and_saves_them
    # start with no projects
    assert_equal 0, Movie.count
    project = Movie.create( Title: 'Collateral' )
    assert_equal 1, Movie.count
  end

  # def test_send_to_already_watched_list
  #   record = UserMovie.new(movie_title: "Jaws")
  #   assert_equal( )
  # end

end
