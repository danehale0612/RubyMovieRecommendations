module MoviesController

  def clear_screen
    print "\e[H\e[2J"
  end

  def create_user
    puts "Please enter username"
    username = gets.chomp
    User.create(name: username)
    clear_screen
    login_screen
  end


  def watchlist_to_watched_list(db_movie_title, movie_info)
    UserMovie.where(user_id: @userID, movie_title: db_movie_title, movie_status: 'watchlist').destroy_all
    clear_screen
    send_to_already_watched_list(db_movie_title)
    puts "#{movie_info['Title']} has been added to your Already Watched List\n\n"
    watchlist
  end


  def delete_from_watchlist(db_movie_title, movie_info)
    UserMovie.where(user_id: @userID, movie_title: db_movie_title, movie_status: 'watchlist').destroy_all
    clear_screen
    puts "#{movie_info['Title']} has been deleted from your Watchlist\n\n"
    watchlist
  end


  def navigation_options
    
    print "\n\nr)Enter a new title for Recommendations" +
    "\nh)Go to User Home Screen" +
    "\n\nSelect a movie: "

    menu_option = gets.chomp.to_s

    if menu_option == "r"
      clear_screen
      recommend_screen 
    elsif menu_option == "h"
      clear_screen
      user_screen
    else 
      selected_movie_index = menu_option.to_i - 1
    end
  end

  def watchlist
    title_list = []
    puts "Watchlist\n\n"
    watch_list = UserMovie.where(movie_status: "watchlist", user_id: @userID).all
    watch_list.each do |movie|
      title_list << movie.movie_title
    end

    watch_list.each_with_index do |movie, i|
      puts "#{i + 1}) #{movie.movie_title}"
    end

    selected_movie_index = navigation_options

    selected_movie = title_list[selected_movie_index]

    response = Faraday.get "http://www.omdbapi.com/?i=&t=#{selected_movie}&plot=full&tomatoes=true"

    movie_info = JSON.parse(response.body)

    print clear_screen

    puts full_movie_info(movie_info)
      
    print "\n1) Send to Already Watched List" +
    "\n2) Delete movie from Watchlist" +
    "\n3) Leave this movie" +
    "\n\nWhat would you like to do with movie?: "

    db_movie_title = movie_info['Title'].downcase
    movie_action = gets.chomp
    if movie_action == "3"
      clear_screen
      watchlist
    elsif movie_action == "1"
      watchlist_to_watched_list(db_movie_title, movie_info)
    elsif movie_action == "2"
      delete_from_watchlist(db_movie_title, movie_info)
    else
      clear_screen
      puts "Not a valid command"
      puts
      watchlist
    end
  end



  def full_movie_info(movie_info)
    return "\nTitle: #{movie_info['Title']}" +
    "\nYear: #{movie_info['Year']}" +
    "\nRated: #{movie_info['Rated']}" +
    "\nReleased: #{movie_info['Released']}" +
    "\nRuntime: #{movie_info['Runtime']}" +
    "\nGenre: #{movie_info['Genre']}" +
    "\nDirector: #{movie_info['Director']}" +
    "\nWriter: #{movie_info['Writer']}" +
    "\nActors: #{movie_info['Actors']}" +
    "\nRotten Tomatoes Score: #{movie_info['tomatoMeter']}" +
    "\nPlot:\n#{movie_info['Plot']}"
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

    selected_movie_index = navigation_options

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
    elsif movie_action == "2"
      delete_from_already_watched_list(db_movie_title, movie_info)
    else
      print "\e[H\e[2J"
      puts "Not a valid command"
      puts
      already_watched_list
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

  def send_to_movie_not_found_list(db_unknown_title)
    UserMovie.create(user_id: @userID, movie_title: db_unknown_title, movie_status: 'movie_not_found')
  end


  def movie_info_screen(top_five_movies, movie_title)

    picked_movie_index = navigation_options

    picked_movie = top_five_movies[picked_movie_index]

    response = Faraday.get "http://www.omdbapi.com/?i=&t=#{picked_movie['Name']}&plot=full&tomatoes=true"

    movie_info = JSON.parse(response.body)

    clear_screen

    if movie_info['Error'] == "Movie not found!"
      db_unknown_title = picked_movie['Name'].downcase
      puts "Sorry, Movie Info Not Found. Please Select Another Movie" 
      send_to_movie_not_found_list(db_unknown_title)
      recommendation_process(movie_title)
    else
      puts full_movie_info(movie_info)
      
      print "\n1) Send to Watchlist\n" +
      "2) Send to Already Watched List\n" +
      "3) Leave this movie\n" +
      "\nWhat would you like to do with movie?: "

      db_movie_title = movie_info['Title'].downcase

      movie_action = gets.chomp

      if movie_action == "3"
        clear_screen
        recommended_movies(top_five_movies, movie_title)
      elsif movie_action == "1"
        clear_screen
        send_to_watchlist(db_movie_title)
        puts "#{movie_info['Title']} has been added to your WatchList\n\n"
        recommendation_process(movie_title)
      elsif movie_action == "2"
        clear_screen
        send_to_already_watched_list(db_movie_title)
        puts "#{movie_info['Title']} has been added to your Already Watched List\n\n"
        recommendation_process(movie_title)
      else
        clear_screen
        puts "Not A Valid Command\n\n"
        recommendation_process(movie_title)
      end
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

    puts "Movie title not recognized" if results.length == 0
    
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
end