[![Coverage Status](https://coveralls.io/repos/github/NKlage/tvbuddy/badge.svg)](https://coveralls.io/github/NKlage/tvbuddy)
# TV Buddy App


# Development

A TMDB API key is required for development, as well as a Countly instance that requires a correspondingly configured Countly project.
The information of the TMDB API key and the Countly settings are stored in an `app_config.json` file in the root folder.
The `app_config.json` is transferred via the parameter `--dart-define-from-file=app_config.json` when the app is built.

```json
{
  "countly_url": "",
  "countly_app_key": "",
  "countly_salt": "",
  "tmdb_api_key": ""
}
```