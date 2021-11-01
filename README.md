`tsc` or Twitch Social Credit is a Twitch.tv chat bot that attempts to score chatters with a toxicity score based on scores provided by Perspective API.


### Design

Currently supports 1:1 bot per channel and stores information in a 'local' sqlite3 database that assumes everything is taking place in one channel. If one were to productize this - investigate having the bot join a list of servers and set up database relationships appropriately so that username's have scores per channel and overall.

* `lib/tsc.rb` - Main program that connects to the ttv IRC room and creates a structure to react to messages.
* `lib/tsc/irc.rb` - IRC auth, message parsing, sending, heartbeat.
* Database - Using `active_record` to interface with sqlite3 to store usernames and update a username's average score. Messages are not kept, only a count of total messages seen and the average score of the username's messages. Schema and migrations are found in `lib/tsc/db/` and familiar (for `active_record`) database tasks are found in the `Rakefile`.
* `lib/tsc/configuration.rb` - See Configuration section.
* Workers - `lib/tsc/workers` Because of the rate of IRC messages, each message spawns a Sidekiq worker that will perform Perspective API requests and inserts into the database.

### Configuration
Config is contained in `lib/tsc/configuration.rb` and `lib/tsc/conf`:
* `TSC_ENV`
* `TSC_DATABASE`
* `TSC_REDIS_URL`
* `TSC_OAUTH_STRING`
* `TSC_TWITCH_USER`
* `TSC_TWITCH_CHANNEL`
* `TSC_WSS_SERVER`
* `TSC_GOOGLE_API_KEY`

You can configure `lib/tsc/conf/channel_and_mod_list.json` with a channel (include the # before the channel name) and an array of mods to improve processing time and prevent the bot from reporting on messages from mods (or other users by pretending they are a mod). Example configuration:

```json
{
  "#channel": [ "mod1", "mod2" ]
}
```

You also need to request access and configure the Perspective API on your Google Cloud Console. Instructions can be found on their website.
