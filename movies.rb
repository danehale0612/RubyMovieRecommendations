#!/usr/bin/env ruby

require_relative 'bootstrap_ar'
require 'faraday'
require 'pp'





def create_user
  puts "Please enter username"
  username = gets.chomp
  User.create(name: username)
end



def user_screen
  print "
1) Recommend movies
2) Watchlist
3) Already Watched List

What would you like to do: "

  direction = gets.chomp

  if direction == "1"
    puts
    recommend_screen
  else
    puts "No other value is valid yet"
    user_screen
  end
end



def login_screen
  print "Type Username: "
  username = gets.chomp 

  table_username = User.where(:name => username).first

  unless table_username.nil?
    puts "Welcome, #{username}!"
    user_screen
  else
    print "This username does not exist.  Would you like to create it?
    y) yes
    n) no

    :"

    input = gets.chomp

    if input == "n"
      print "\e[H\e[2J"
      login_screen
    elsif input == "y"
      create_user
    else
      "Not a valid input"
    end
  end
end




def movie_info_screen(top_five_movies)

    print "6)Enter a new title for Recommendations
7)Go to User Home Screen

Select a movie: "

    picked_movie_index = gets.chomp.to_i - 1

    if picked_movie_index == 5
      print "\e[H\e[2J"
      recommend_screen 
    elsif picked_movie_index == 6
      print "\e[H\e[2J"
      user_screen
    end

    picked_movie = top_five_movies[picked_movie_index]

    response = Faraday.get "http://www.omdbapi.com/?i=&t=#{picked_movie['Name']}&plot=full&tomatoes=true"

    movie_info = JSON.parse(response.body)

    print "\e[H\e[2J"
    puts <<-MOVIEINFO

Title: #{movie_info['Title']}
Year: #{movie_info['Year']}
Rated: #{movie_info['Rated']}
Released: #{movie_info['Released']}
Runtime: #{movie_info['Runtime']}
Genre: #{movie_info['Genre']}
Director: #{movie_info['Director']}
Writer: #{movie_info['Writer']}
Actors: #{movie_info['Actors']}
Rotten Tomatoes Score: #{movie_info['tomatoMeter']}
Plot: 
#{movie_info['Plot']}
     
    MOVIEINFO

    print " 
    1) Send to Watchlist
    2) Send to Already Watched List
    3) Leave this movie

    What would you like to do with movie?:"

    movie_action = gets.chomp

  if movie_action == "3"
    print "\e[H\e[2J"
    recommended_movies(top_five_movies)
  else
    print "\e[H\e[2J"
    recommended_movies(top_five_movies)
  end

end





def recommended_movies(top_five_movies)
  puts
  top_five_movies.each do |movie|
    puts "#{movie['Index']}) #{movie['Name']}"
  end
  puts 

  movie_info_screen(top_five_movies)

end





def recommend_screen

  print "Type in a movie that you liked to get recommendations on: "
  movie_title = gets.chomp

  puts

  response = Faraday.get "http://www.tastekid.com/ask/ws?q=movie:#{movie_title}//movies&format=JSON&f=see_the3022&k=nzfkmgm3nwvm"

  results = JSON.parse(response.body)['Similar']['Results']

  top_five_movies = results.shift(5)

  top_five_movies.each_with_index do |movie, index|
    movie['Index'] = index + 1
  end

  recommended_movies(top_five_movies)

end



login_screen