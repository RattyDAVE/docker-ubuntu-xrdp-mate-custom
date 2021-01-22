## This is a Modified Version of  RattyDAVE/docker-ubuntu-xrdp-mate-custom to support deploy of [VoiceChatPyroBot](https://github.com/rojserbest/VoiceChatPyroBot.git) to [Zeet](https://zeet.co/)

## Deploying
Sign in with your Github account and fork this repo.

* Go here [Zeet](https://zeet.co/)
* Sign into Zeet with your Github account
* Now Choose New Project and choose GitHub repo and give access to your fork ,then click on Deploy Now. 
* Now Zeet will automatically starts building from the Dockerfile. Wait for the build to finish.
* After completing the build you have to configure the Environment Variables.

## Configuring
* You will need to set the following Environment Variables for your VoiceChatPyroBot

`API_ID` :Get your api id from [my.telegram.org](https://my.telegram.org)

`API_HASH` :Get your api hash from [my.telegram.org](https://my.telegram.org)

`TOKEN` :Get your bot token from [@BotFather](https://t.me/BotFather)

`SUDO_USERS` : A list of user ids which can pause, skip and change volume, Enter each id's seperated by a space.

`GROUP` : The id of the group where your bot plays. 

`MONGO_DB_URI` str: your MongoDB URI (you can get one for free in their [official website](https://mongodb.com/), sign up, create a cluster and a database named "vcpb")

`USERS_MUST_JOIN` : If true, only users which are in the group can use the bot.
    
`LANG` : your bot language, choose an available language code in [VoiceChatPyroBot](https://github.com/rojserbest/VoiceChatPyroBot/tree/main/strings)

`DUR_LIMIT`: Max video duration in minutes for downloads

  ⚠️ The Following variables are Compulsory (Others will use default values if not set)
  ~~~
  API_ID
  API_HASH
  TOKEN
  SUDO_USERS
  GROUP  (If USERS_MUST_JOIN is set to True)
  ~~~
* If the remaining values are not set then the Default values are:
~~~
 MONGO_DB_URI = None
 USERS_MUST_JOIN = False
 LANG = en (english)
 DUR_LIMIT = 10
~~~
* After setting the Evnironment Variables save them and Wait for the Deploy to finish.

* Once Deploying is finished check if your bot is working. If not make sure that you set the Environment variables Correct.

* Once all are perfect now its time to setup XRDP to strat RDP connection.

* Go to Your Zeet dashboard and select the deployed app and start the Zeet Terminal.

* Start xrdp by running the bash script xrdp-start.sh by running ```/xrdp-start.sh```

* Once its started succesfully close the terminal and copy the PUBLIC IPS from Zeet Dashboard
 
* Open a remote desktop client and login to your user. The default credentials are:-
  ~~~
  username :vcpb  
  password :music
  ~~~
* If you want to edit the username and password , you can do it by editing the values in [createusers.txt](https://github.com/subinps/docker-ubuntu-xrdp-mate-custom-VCPB/blob/master/createusers.txt) file. the foremat is username:password:is SUDO or not(Y/N)
  * ℹ️ If you are changing the default user , you may need to change the same in [script.sh](https://github.com/subinps/docker-ubuntu-xrdp-mate-custom-VCPB/blob/master/script.sh) also .

* Once after loging in ,  you can see a file named Telegram in  /home/vcpb/Telegram Directory (You may see some error messages, since i debloated many mate utils , ignore(delete) those.)

* Execute it and login into your telegram account and Join a Voicechat.
  * ℹ️ No need to change the default microphone as MySink is already default Mic.
  
## Credit and Thanks
* [VoiceChatPyroBot](https://github.com/rojserbest/VoiceChatPyroBot) 
* [RattyDAVE/docker-ubuntu-xrdp-mate-custom](https://github.com/RattyDAVE/docker-ubuntu-xrdp-mate-custom)
