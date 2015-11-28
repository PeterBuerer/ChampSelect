#Installation
* Running ```git submodule update --init``` should be all you need to do

#Overview
This is a learning project for me. I am currently using it to gain experience interacting with an API (specifically the [Riot Games API](https://developer.riotgames.com/docs/getting-started)), while also building an application based around one of my favorite games ([League of Legends](https://www.leagueoflegends.com))

The app itself is simply a champion library that provides information about a champ when you tap on them. It is a work in progress and will most likely remain so for the foreseeable future because I plan on using it to experiment with as many new things as possible.

###IMPORTANT 
This application requires an API key. To acquire one, simply log on to [http://developer.riotgames.com](http://developer.riotgames.com) with your League of Legends account and register a key. If you are planning on running the app to do more than just test it out, please replace my API key with your own.

###Current Goals
* Create a database for local storage (Core Data or straight SQLite)

###Known Problems
 * There are spell variables with "f" prefixes that are missing from the JSON. This is a bug on Riot's end.
 * Currently not filtering what the spell vars output so things like "bonusattackdamage" are left in for now.
 * Champ info cells aren't dynamically sized to fit content.