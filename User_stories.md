##Login screen

  -Every user has to first login to get access to their individual movie recommendations, watch list, and already watched list.
  After the user types in their username, if it is not recognized in the database the app will ask if the user would like to create a new username, if the user chooses to do so, they will be prompted on how to setup a username.
  Once the user is successfully logged in, they will be sent to the user screen

  Existing User: type “username”
      -goes into existing user’s movie database
  If username typed is not found, prompt: would you like to create a new username   [y,n]   
  -creates new user table with the name being the username typed


##User screen
  
  -Every user is presented with the same options for their profile: recommend, watch list, and already watched list, and exit app.
  -The user will navigate through options by typing in the index of the option they want to go to(ie: user wants to go to “1) Recommend Movies”, the user will type in “1” and then hit enter).

    options:
      -recommend
        -takes to screen prompting to ask for movie recommendation
      -watchlist
        -takes to list of movies that user wants to see
      -movies watched
        -takes to list of movies that user has watched
      -exit app
        -this will clear the screen and send the user outside of the app

##Recommend screen
  
  -The user is more than likely is coming to this app to find movies that might interest them (the user).  The recommend movies screen is where they can accomplish this goal.  
  -the user will first type in a movie that they like (ie: “heat”) and the recommendation screen will show a list of 5 movies that it will recommend
  -the recommended movies can’t be movies inside of that user’s already watched list or watch list.  If the movie is inside one of those lists it will recommended another movie.
  -the user can then select which movie they want to look further into by typing in the index of that movie.

  Type in the title of a movie that you would like recommendations based on:
      -takes typed movie title and runs it through TasteKid API to get 5 recommended movie    titles. i.e:
        movie title: Heat

        recommended:

          The Insider
          Ronin
          Carlito’s Way
          Donnie Brasco
          Collateral

  Type in index. + method to mark the movie as: watched, put into a watchlist. ie:
      -user wants to mark The Insider as watched:
        1.watched
      -user wants to mark Collateral to his watchlist:
        5.watchlist

  Once a movie has had a method applied to it, the recommendation screen will not recommend that title again.  


##Movie Info Screen 

  -The user will want to know more about a movie before they take action on it.  This information consist of the title, year released, rotten tomatoes score, actors, directors, etc.

     Options inside the movie info screen include:
        -plot
        -rating
        -rotten tomatoes score
        -year released
        -cast
        -director
        -writers
        -runtime
      
    
  -The user will also have options of actions to do with the movie (based on what part of the app they are in)
      
      Action options for movies inside movie info screen:
        
      Recommendation Screen
  Send to Watchlist (will send movie to the user’s watchlist and won’t show up in recommendation list)
  Send to Already Watched List (will send movie to the user’s already watched list and won’t show up in recommendation list)
  Leave this movie (this will go to the previous screen)

      Already Watched List
  Send to Already Watched List 
  Delete movie from Watch List (will delete movie from Already Watched List and movie will start to show up in recommendation list again)
  Leave this movie

      Watchlist
  Send to Already Watched List
  Delete movie from Watch List
  Leave this movie



##Watch list screen     
  
  -Purpose for this screen is to show the movies that the user has pushed to their “watch list”.  These are the movies that the user has already watched but does not want to show up on the recommendation list ever. 

  -The user can select a movie on their list and send it to their already watched list, or delete it from this table.
    
##Already Watched screen   


  -Purpose for this screen is to show the movies that the user has pushed to their “already watched list”.  These are the movies that the user has already watched but does not want to show up on the recommendation list ever. 

  -The user can select a movie on their list and send it to their watch list, or delete it from this table.
    
