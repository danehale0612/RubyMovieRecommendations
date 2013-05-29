#!/usr/bin/env ruby

require_relative 'bootstrap_ar'
require 'faraday'
require 'pp'
database = ENV['FP_ENV'] || 'development'
connect_to database





def create_user
  puts "Please enter username"
  username = gets.chomp
  User.create(name: username)
  print "\e[H\e[2J"
  login_screen
end


def watchlist_to_watched_list(db_movie_title, movie_info)
  UserMovie.where(user_id: @userID, movie_title: db_movie_title, movie_status: 'watchlist').destroy_all
  print "\e[H\e[2J"
  send_to_already_watched_list(db_movie_title)
  puts "#{movie_info['Title']} has been added to your Already Watched List
    
    "
    watchlist
end


def delete_from_watchlist(db_movie_title, movie_info)
  UserMovie.where(user_id: @userID, movie_title: db_movie_title, movie_status: 'watchlist').destroy_all
  print "\e[H\e[2J"
  puts "#{movie_info['Title']} has been deleted from your Watchlist"
  puts
  watchlist
end



def watchlist
  title_list = []
  puts "Watchlist"
  puts
  watch_list = UserMovie.where(movie_status: "watchlist", user_id: @userID).all
  watch_list.each do |movie|
    title_list << movie.movie_title
  end

  watch_list.each_with_index do |movie, i|
    puts "#{i + 1}) #{movie.movie_title}"
  end

  puts

  print "
  r)Enter a new title for Recommendations
  h)Go to User Home Screen

  Select a movie: "
  

  menu_option = gets.chomp.to_s

  if menu_option == "r"
    print "\e[H\e[2J"
    recommend_screen 
  elsif menu_option == "h"
    print "\e[H\e[2J"
    user_screen
  else 
    selected_movie_index = menu_option.to_i - 1
  end

  selected_movie = title_list[selected_movie_index]

  response = Faraday.get "http://www.omdbapi.com/?i=&t=#{selected_movie}&plot=full&tomatoes=true"

  movie_info = JSON.parse(response.body)

  print "\e[H\e[2J"
  puts full_movie_info(movie_info)
    
    print " 
  1) Send to Already Watched List
  2) Delete movie from Watchlist
  3) Leave this movie

  What would you like to do with movie?: "

  db_movie_title = movie_info['Title'].downcase

  movie_action = gets.chomp

  if movie_action == "3"
    print "\e[H\e[2J"
    watchlist
  elsif movie_action == "1"
    watchlist_to_watched_list(db_movie_title, movie_info)
  else
    delete_from_watchlist(db_movie_title, movie_info)
  end
end



def full_movie_info(movie_info)

  <<-MOVIEINFO

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

end


def watched_list_to_watchlist(db_movie_title, movie_info)
  UserMovie.where(user_id: @userID, movie_title: db_movie_title, movie_status: 'already_watched').destroy_all
  print "\e[H\e[2J"
  send_to_watchlist(db_movie_title)
  puts "#{movie_info['Title']} has been added to your WatchList
    
    "
    already_watched_list
end


def delete_from_already_watched_list(db_movie_title, movie_info)
  UserMovie.where(user_id: @userID, movie_title: db_movie_title, movie_status: 'already_watched').destroy_all
  print "\e[H\e[2J"
  puts "#{movie_info['Title']} has been deleted from your Already Watched List"
  puts
  already_watched_list
end



def already_watched_list
  title_list = []
  puts "Already Watched List"

  puts

  watchedList = UserMovie.where(movie_status: "already_watched", user_id: @userID).all
  watchedList.each do |movie|
    title_list << movie.movie_title
  end

  watchedList.each_with_index do |movie, i|
    puts "#{i + 1}) #{movie.movie_title}"
  end

  puts

  print "
  r)Enter a new title for Recommendations
  h)Go to User Home Screen

  Select a movie: "
  

  menu_option = gets.chomp.to_s

  if menu_option == "r"
    print "\e[H\e[2J"
    recommend_screen 
  elsif menu_option == "h"
    print "\e[H\e[2J"
    user_screen
  else 
    selected_movie_index = menu_option.to_i - 1
  end

  selected_movie = title_list[selected_movie_index]

  response = Faraday.get "http://www.omdbapi.com/?i=&t=#{selected_movie}&plot=full&tomatoes=true"

  movie_info = JSON.parse(response.body)

  print "\e[H\e[2J"
  puts full_movie_info(movie_info)
    
    print " 
  1) Send to Watchlist
  2) Delete movie from Already Watched List
  3) Leave this movie

  What would you like to do with movie?:"

  db_movie_title = movie_info['Title'].downcase

  movie_action = gets.chomp

  if movie_action == "3"
    print "\e[H\e[2J"
    already_watched_list
  elsif movie_action == "1"
    watched_list_to_watchlist(db_movie_title, movie_info)
  else
    delete_from_already_watched_list(db_movie_title, movie_info)
  end

end



def user_screen
  print "

  User Home Screen 

  1) Recommend movies
  2) Watchlist
  3) Already Watched List
  4) Exit App

  What would you like to do: "

  direction = gets.chomp

  if direction == "1"
    print "\e[H\e[2J"
    recommend_screen
  elsif direction == "2"
    print "\e[H\e[2J"
    watchlist
  elsif direction == "3"
    print "\e[H\e[2J"
    already_watched_list
  elsif direction == "4"
    print "\e[H\e[2J"
    exit
  else
    puts "No other value is valid yet"
    user_screen
  end
end



def login_screen
  print "
  See These Movies!
  Login

  Type Username: "
  username = gets.chomp 

  table_username = User.where(:name => username).first

  unless table_username.nil?
    print "\e[H\e[2J"
    puts "Welcome, #{username}!"
    @userID = table_username.id
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

def send_to_watchlist(db_movie_title)
  UserMovie.create(user_id: @userID, movie_title: db_movie_title, movie_status: 'watchlist')
end

def send_to_already_watched_list(db_movie_title)
  UserMovie.create(user_id: @userID, movie_title: db_movie_title, movie_status: 'already_watched')
end


def movie_info_screen(top_five_movies, movie_title)

  print "
  r)Enter a new title for Recommendations
  h)Go to User Home Screen

  Select a movie: "

  menu_option = gets.chomp.to_s

  if menu_option == "r"
    print "\e[H\e[2J"
    recommend_screen 
  elsif menu_option == "h"
    print "\e[H\e[2J"
    user_screen
  else 
    picked_movie_index = menu_option.to_i - 1
  end

  picked_movie = top_five_movies[picked_movie_index]

  response = Faraday.get "http://www.omdbapi.com/?i=&t=#{picked_movie['Name']}&plot=full&tomatoes=true"

  movie_info = JSON.parse(response.body)

  print "\e[H\e[2J"
  puts full_movie_info(movie_info)
  
  print " 
  1) Send to Watchlist
  2) Send to Already Watched List
  3) Leave this movie

  What would you like to do with movie?:"

  db_movie_title = movie_info['Title'].downcase

  movie_action = gets.chomp

  if movie_action == "3"
    print "\e[H\e[2J"
    recommended_movies(top_five_movies, movie_title)
  elsif movie_action == "1"
    print "\e[H\e[2J"
    send_to_watchlist(db_movie_title)
    puts "#{movie_info['Title']} has been added to your WatchList
    
    "
    recommendation_process(movie_title)
  elsif movie_action == "2"
    print "\e[H\e[2J"
    send_to_already_watched_list(db_movie_title)
    puts "#{movie_info['Title']} has been added to your Already Watched List
    
    "
    recommendation_process(movie_title)
  else
    print "\e[H\e[2J"
    recommendation_process(movie_title)
  end

end





def recommended_movies(top_five_movies, movie_title)
  movie_title = movie_title

  puts
  top_five_movies.each do |movie|
    puts "#{movie['Index']}) #{movie['Name']}"
  end
  puts 

  movie_info_screen(top_five_movies, movie_title)

end

def recommendation_process(movie_title)

  movie_title = movie_title

  response = Faraday.get "http://www.tastekid.com/ask/ws?q=movie:#{movie_title}//movies&format=JSON&f=see_the3022&k=nzfkmgm3nwvm"

  results = JSON.parse(response.body)['Similar']['Results']

  scrub_results = []

  results.length.times do |i|
    lowercase_results = results[i]['Name'].downcase

    matched_movie = UserMovie.where(movie_title: lowercase_results, user_id: @userID).first
    if matched_movie.nil?
      scrub_results << results[i]
    end
  end 

  top_five_movies = scrub_results.shift(5)

  top_five_movies.each_with_index do |movie, index|
    movie['Index'] = index + 1
  end

  recommended_movies(top_five_movies, movie_title)

end



def recommend_screen

  print "Type in a movie that you liked to get recommendations on: "
  movie_title = gets.chomp

  puts

  recommendation_process(movie_title)
  
end


login_screen

