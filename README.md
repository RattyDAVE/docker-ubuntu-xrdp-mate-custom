## Modified version of  RattyDAVE's original repo to deploy [VCPB](https://github.com/rojserbest/VCPB) on [Zeet](https://zeet.co/)

## Env
* You will need to set the following environment variables for a successful build.

`API_ID` int: An api id from [my.telegram.org](https://my.telegram.org/apps).

`API_HASH` str: An api hash from [my.telegram.org](https://my.telegram.org/apps).

`TOKEN` str: A bot token from [@BotFather](https://t.me/BotFather).

`SUDO_USERS` list(int): Separated by space, a list of user ids.

`GROUP` int: The id of the group where your bot plays. 

`MONGO_DB_URI` str: (optional, default: none) your MongoDB URI for the custom playlist feature (you can get one for free in their [official website](https://mongodb.com/), sign up, create a cluster and a database named "vcpb").

`USERS_MUST_JOIN` bool: (requires GROUP, optional, default: false) If true, only users which are in the group can use the bot.
    
`LANG` str: (optional, default: en) your bot language, choose an available language code in [here](https://github.com/rojserbest/vcpb/tree/main/strings).

`DUR_LIMIT` int: (optional, default: 10) max video duration in minutes for downloads.

## Deploying
Sign in with your Github account and fork this repo.

* [Fork](https://github.com/rojserbest/vcpb-zeet-deploy/fork) this repository.
* Go to [Zeet's website](https://zeet.co/).
* Sign in using your GitHub account.
* Create a new project, using the free plan.
* Add access to the forked repository and deploy.
* Fill the environment variables as described below.
* Zeet will start building from the Dockerfile, it might take some time.
* Once deployed, you'll see a small terminal icon, click it to open Zeet's in-browser terminal.
* Type `/xrdp-start.sh`, hit enter, wait 10 seconds and disconnect from the terminal.
* After starting XRDP, copy your project's pulbic IP address and open a remote desktop client.
* Use the public IP, plus the following credentials to login:
    User: `vcpb`  
    Passphrase: `music`
* After logging in, you can ignore some expected error messages.
* Open Mate terminal, type `~/Telegram/Telegram` to open tdesktop.
* When tdesktop is opened, login with an alt account of yours.
* Join a voice chat, unmute the mic and close the RDP connection.
  
## Credits
* [The original repository](https://github.com/RattyDAVE/docker-ubuntu-xrdp-mate-custom)
* [Subinps](https://github.com/subinps) 
