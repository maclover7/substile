# substile

Analyze turnstile data for stations on the New York City Subway.

### How to

- Run `bundle install` to install dependencies
- Download turnstile data files from the [website](http://web.mta.info/developers/turnstile.html), and place inside this folder
- Run `TURNSTILE_FILE='FILENAME' ruby substile.rb`, replacing `FILENAME`
  with the name of the file downloaded, for example,
`turnstile_180428.txt`

### License

Copyright (c) 2018+ Jon Moss under the MIT License.
