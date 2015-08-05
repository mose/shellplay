Shellplay
==================

[![Gem Version](https://img.shields.io/gem/v/shellplay.svg)](https://rubygems.org/gems/shellplay)
[![Downloads](http://img.shields.io/gem/dt/shellplay.svg)](https://rubygems.org/gems/shellplay)
[![Build Status](https://img.shields.io/travis/mose/shellplay.svg)](https://travis-ci.org/mose/shellplay)
[![Coverage Status](https://img.shields.io/coveralls/mose/shellplay.svg)](https://coveralls.io/r/mose/shellplay?branch=master)
[![Dependency Status](https://img.shields.io/gemnasium/mose/shellplay.svg)](https://gemnasium.com/mose/shellplay)
[![Code Climate](https://img.shields.io/codeclimate/github/mose/shellplay.svg)](https://codeclimate.com/github/mose/shellplay)
[![Inch CI](https://inch-ci.org/github/mose/shellplay.svg)](https://inch-ci.org/github/mose/shellplay)
----

This is a CLI tool for recording and presenting step by step operations from the console. It is targeted at presentations that would simulate live coding, without the random murphy factor of it.

It can record a session and playback from it, so if internet fails in your conference room you are safe.

**Note: this is a barely working, use at your own risk.**

## Installation

    gem install shellplay

The first time you run it, some configuration variables will be asked, and stored in `$HOME/.shellplay/config.yml`. All the recorded sessions will be stored in that same directory.

### Development install

    git clone git@github.com:mose/shellplay.git
    cd shellplay
    bundle install --path vendor

To launch shellrecord or shellplay from local repo:

    bundle exec ./bin/shellrecord

## Recording a session

For recording a session

    shellrecord

Then type the commands you want to record, and type `q` at the end it will prompt you for a file name and a title.

The session file is stored in `$HOME/.shellplay/` in json format and can be used to be played.

You can record a session in several steps, and merge then afterwards, with

    shellcat session1 session2 session3

You will be prompted to provide a new title and a new name, and it will save the new concatenated session file.

The session file being a pretty-formatted json file, it's also convenient to just edit it for fixes or adjustments. Especially as this tool is still in development and all the optimal edit features are not yet implemented.

During recording you can use various tricks:

```
> Newprompt
will change the prompt from now on, on next screens

d
will delete last recorded screen

q
finishes the recording and saves

x
ends the recording without saving

<enter>
will introduce a blank screen

? something
will fake a command. Convenient when you simulate a command on a remote host and then you can copy paste the comamnd result below that one. The output is ended if you input a . (dot) alone on a line (like with the 'mail' command).

# something
will not display the command, only the output

## something
will not display the command, and will not display the play prompt

/ something
will issue a clear before display of the screen

?##/ something
typical combination to write full-text screens for intro, outro or just text screens. example at https://gist.github.com/mose/99843942efb9e275638b
Note that you can use escape chars like when you build a bash prompt, for colors.
```

## Playing a session

For playing

    shellplay <session_file_name>
    shellplay <remote session url>

For example

    shellplay https://raw.githubusercontent.com/mose/20140814-dokku/master/dokku-full.json

or just

    shellplay

If you don't specify the name of the session, all locally available sessions will be displayed and you will be asked to choose one.

Then type enter to go next, or `?` to display list of available commands.

## Export to HTML

To export

    shellexport <session_file_name>
    shellplay <remote session url>

It will save the html in a dir in `.shellplay` under the name of the session. The dir contains index.html, css, and js files, ready to be played from your laptop or uploaded to your server.

Note, the `shellexport` command will not override `shellplay.css`, `shellplay.js` and `colors.css` if they exist. So you can apply changes on those files after the first export, then work on your session and re-export. If you want to rest those files, you can just delete them and re-export.

Navigation on the html version is

- `p`, `left` for previous screen,
- `n`, `enter` or `right` for next screen

Demo HTML: http://mose.com/20140814-dokku/

## Todo

- <s>handle the no-display entries</s>
- <s>when prototype is ready, switch to v0.1.0</s>
- make an html export
- write a shell colors parser of some sort because \e[1;33m sucks
- add a function in player to edit a screen
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
