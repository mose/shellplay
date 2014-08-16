Shellplay Changelog
=========================

v0.0.12 - 2014-08-15
-----------------
- fix recorder to take account of `cd` properly
- fix recorder cmmand execution

v0.0.11 - 2014-08-14
------------------
- made possible to open a remote json file with `shellplay http://example.com/something.json`
- moved config vars (prompt and timeformat) to session file

v0.0.10 - 2014-08-13
-------------------
- added a `shellcat` command to merge sessions

v0.0.9 - 2014-08-13
------------------
- fix the fix of creation of config dir

v0.0.8 - 2014-08-13
------------------
- fix creation of the config dir at first launch

v0.0.7 - 2014-08-13
-------------------
- fix exec of commandfs in shellplay
- implement a `p` command in play mode for switching to previous screen
- added management of bash escape char for colorization in output texts


v0.0.6 - 2014-08-13
--------------------
- save json session in pretty format for manual intervention
- chomp output so there is less spaces
- add a config param for setting time format on the elapsed time of last command
- fix display of playprompt
- improved styling on 'timespent' display

v0.0.5 - 2014-08-12
------------------
- add a `/` record prefix for clearscreen, works with iterm2 on mac, linux trick don't work yet
- add a `?` record prefix for faking output, in case of ssh connection for example
- add a `>` to change the prompt and a `>>` to switch prompt back and forth
- code is getting messy, it will be time to refactor the record into some classes soon

v0.0.4 - 2014-08-12
------------------
- add changelog link in the gemspec
- add a `##` record option for inhibiting display of the play prompt
- add a `d` record command to drop last screen

v0.0.3 - 2014-08-11
-------------------
- fix shellrecord that was broken after incomplete file renaming

v0.0.2 - 2014-08-10
---------------
- made recorder and player more or less working
- changed project name twice. First shellprez, then shreplay, finally shellplay rocks better

v0.0.1 - 2014-08-08
------------------
- just initial code
