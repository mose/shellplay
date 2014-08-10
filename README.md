Shellplay
==================

This is a CLI tool for recording and presenting step by step operations from the console. It is targeted at presentations that would simulate live coding, without the random murphy factor of it.

It can record a session and playback from it, so if internet fails in your conference room you are safe.

**Note: this is a work inprogress, nothing there to be seen yet, except for reading code.**

## Installation

    gem install shellplay

The first time you run it, some configuration variables will be asked, and stored in `$HOME/.shellplay/config.yml`. All the recorded sessions will be stored in that same directory.

## Recording a session

For recording a session

    shellrecord

Then type the commands you want to record, amd type q at the end it will prompt you for a file name and a title.

The session file is stored in json format and can be used to be played

## Playing a session

For playing

    shellplay <session_file_name>

or just

    shellplay

If you don't specify the name of the session, all locally available sessions will be displayed and you will be asked to chose one.

Then type enter to go next, or `?` to display list of available commands.

## Todo

- when prototype is ready, switch to v0.1.0
- test coverage
- save and load sessions from gist
  - add gist token to config or something
- ponder about using the curses lib


## Contributing

1. Fork it
2. Create a feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Copyright

(c) Copyright 2014 mose. Distributed under MIT license
