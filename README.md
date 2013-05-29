##Purpose:

To give a user an organized application to recommend movies.  The organization is for making a watch list (a place to store movie tiles a user wants to see) and a watched list (a place to store titles a user has already seen).  Whenever a user asked for movie recommendations it will not recommend movies that the user has sent to either list (unless the user deletes the title from their lists).

Another purpose of the project is for my Nashville Software School Capstone to show I have basic understanding of ruby (this far into my training) and can demonstrate the ability to store and retrieve information (in ruby).




##Status:


  <h5>What is complete:</h5>
  <ul>
    <li>the executive file is fully functional (the app runs, from what QA I have done, as planned)</li>
  </ul>
  
  <h5>To do:</h5>
  <ul>
    <li>Connect app to Test database for additional testing</li>
    <li>Refactor, Refactor, Refactor</li>
  </ul>



##Features:

<ul>

  <li>Have a User Login</li>

  <li>After logged in, a user can type in a movie name.  Using an API (Tastkid), 5 movie recommendations will print out.</li>

  <li>The user can select one of the recommendations to see more information about the movie and then will be prompted as to what does the user want to do with the movie?  Does the user want to send it to their "watchlist", mark the movie as "already watched", or leave that movie and go back to the recommendations.</li>

  <li>By selecting that a movie is in a watchlist or it has been watched, those titles will not get re-recommended to the user again.</li>

  <li>This also will have a menu where the user can select their watchlist or already watched list and interact with the movie titles from there.</li>

</ul>

##Dependencies:

  <h5>Gems:</h5>
  
  <ul>
   <li>Faraday (JSON Parser)</li>
   
   <li>Pretty Print</li>
  </ul>


##Instructions for Use:

<h5>Execute app:</h5>
<ul>
  <li>go to directory of executive file (movie.rb) in command line of terminal</li>

  <li>type './movies.rb' (don't type quotes)</li>
</ul>


##Author:

Dane Hale






##License:

Copyright (c) 2013 Dane Hale

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
