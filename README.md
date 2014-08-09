Shreplay
==================

This is a CLI tool for recording and presenting step by step operations from the console. It is targeted at presentations that would simulate live coding, without the random murphy factor of it.

It can record a session and playback from it, so if internet fails in your conference room you are safe.

Note: this is a work inprogress, nothing there to be seen yet.

## Installation

    gem install shreplay

## Recording a session

For recording a session

    shellrecord

Then type the commands you want to record, type `?` for the help on special commands.

## Playing a session

For playing

    shelprez <presentation-file.json>

Then type enter to go next, or `?` to display list of available commands.

## Contributing

1. Fork it
2. Create a feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Copyright

(c) Copyright 2014 mose. Distributed under MIT license
