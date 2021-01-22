import ast
from os import environ
from pyrogram import filters

API_ID = environ.get('API_ID') 
API_HASH = environ.get('API_HASH') 
TOKEN = environ.get('TOKEN')  
SUDO_USERS = environ.get('SUDO_USERS')
GROUP = environ.get('GROUP') 
MONGO_DB_URI = environ.get('MONGO_DB_URI') 
USERS_MUST_JOIN = environ.get('USERS_MUST_JOIN', 'False') 
LANG = environ.get('LANG', 'en')
DUR_LIMIT = environ.get('DUR_LIMIT', 10) 

API_ID = int(API_ID)
SUDO_USERS = list(map(int, SUDO_USERS.split()))
if type(GROUP) is str:
  GROUP = int(GROUP)#GROUP = int(GROUP)
DUR_LIMIT = int(DUR_LIMIT)
USERS_MUST_JOIN = ast.literal_eval(USERS_MUST_JOIN)
LOG_GROUP = GROUP if MONGO_DB_URI != "" else None
SUDO_FILTER = filters.user(SUDO_USERS)
async def custom_filter(_, __, ___):
    return bool(LOG_GROUP)

LOG_GROUP_FILTER = filters.create(custom_filter)
