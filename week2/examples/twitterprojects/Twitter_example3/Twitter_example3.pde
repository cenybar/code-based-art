// This example queries Twitter every 10 seconds for #worldseries and cubs, and draws corresponding ellipses

// import the Twitter library
import twitter4j.*;
import twitter4j.api.*;
import twitter4j.auth.*;
import twitter4j.conf.*;
import twitter4j.json.*;
import twitter4j.management.*;
import twitter4j.util.*;
import twitter4j.util.function.*;
import twitter4j.conf.ConfigurationBuilder;
import java.util.Date;

//initialize Twitter configuration
ConfigurationBuilder cb = new ConfigurationBuilder();

// initialize a twitter instance and a twitter query (we'll use these later)
Twitter twitterInstance;
Query queryForTwitter;

//Build an ArrayList to hold all of the words that we get from the imported tweets
ArrayList<String> words = new ArrayList();

void setup(){

//Set the size of the stage, and the background to black.
size(550,550);
background(0);  
  
  
// log into Twitter  
cb.setOAuthConsumerKey("****");
cb.setOAuthConsumerSecret("****");
cb.setOAuthAccessToken("****");
cb.setOAuthAccessTokenSecret("****");

// set your twitter object and your query (initialized above)
twitterInstance = new TwitterFactory(cb.build()).getInstance(); 
queryForTwitter = new Query("#worldseries"); 

//how many results do you want to store? (it will take the most recent results each time the program runs)
queryForTwitter.count(200);


}


// make a function to scrape information from Twitter
void collectTweets() {   

// Here we use try and catch statements. 
//This way, if Processing has trouble communicating with Twitter, it simply reverts to the "catch" and prints "can't connect", rather than breaking the code. 
try {
  
// Search Twitter for our query, defined above, and store the tweets in an array. 
  QueryResult result = twitterInstance.search(queryForTwitter);
  ArrayList tweets = (ArrayList) result.getTweets();

//For however many tweets we've asked for, get those tweets and store the user and the message 
  for (int i = 0; i < tweets.size(); i++) { 
    Status t = (Status) tweets.get(i); 
    User u = (User) t.getUser();
    String user = u.getName();
    String msg = t.getText();

// then print that information to the console
   println("Tweet by " + user + ": " + msg);
    
    //Break the tweet into words 
      String[] input = msg.split(" ");
      for (int j = 0;  j < input.length; j++) {
        
       //Put each word into the words ArrayList
       words.add(input[j]);
      }
       
    
  };
}
catch (TwitterException te) {
  println("Couldn't connect: " + te);
};


}


void draw() {
  
// call the function we made above (collectTweets) 
  collectTweets(); 

// use the tweets to make a drawing!

  for (String word : words)
  {
    if (word.toLowerCase().contains("cubs"))
    {
      //every time you find the word "cubs" draw an ellipse and print "found cubs" in the console
      ellipse (random(0,550), random(0,550), 25, 25);
     
    }
  }

//wait 10 seconds-- this is not perfect because it feels slow, but if you query too many times, you'll get booted off Twitter's rest API
delay (10000);
}

  
