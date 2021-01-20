import ast
from os import environ
from pyrogram import filters


API_ID = environ.get('API_ID') # Get these two from https://my.telegram.org
API_HASH = environ.get('API_HASH') # Get these two from https://my.telegram.org
TOKEN = environ.get('TOKEN')   ## Get this from @Botfather
SUDO_USERS = environ.get('SUDO_USERS') # The IDs of the users which can stream, skip, pause and change volume
GROUP = environ.get('GROUP') # The ID of the group where your bot streams
MONGO_DB_URI = environ.get('MONGO_DB_URI') # Your mongodb uri
USERS_MUST_JOIN = environ.get('USERS_MUST_JOIN', 'False') # Users must join the group before using the bot (note: the bot should be admin in the group if you enable this)
LOG = environ.get('LOG', 'True') # Send "Now playing" messages to the group you gave above
LANG = environ.get('LANG', 'en') # Choose the preferred language for your bot. If English leave as it is, or change to the code of any supported language.
DUR_LIMIT = environ.get('DUR_LIMIT', 10) # Max video duration allowed for user downloads in minutes




## No need to touch the following.
SUDO_USERS = list(map(int, SUDO_USERS.split()))
GROUP = int(GROUP)
DUR_LIMIT = int(DUR_LIMIT)
LOG = ast.literal_eval(LOG)
USERS_MUST_JOIN = ast.literal_eval(USERS_MUST_JOIN)
LOG_GROUP = GROUP if LOG else None
SUDO_FILTER = filters.user(SUDO_USERS)
