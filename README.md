
[![CircleCI](https://circleci.com/gh/otis-bot/otis-bot/tree/master.svg?style=svg)](https://circleci.com/gh/otis-bot/otis-bot/tree/master)
[![Coverage Status](https://coveralls.io/repos/github/otis-bot/otis-bot/badge.svg?branch=master)](https://coveralls.io/github/otis-bot/otis-bot?branch=master)

#Otis-Bot

Otis-Bot is an Otis project, built and maintained by students and graduates of
the Firehose Project. Otis-Bot is based on [Hubot](https://hubot.github.com/)
and written in Node.js/CoffeeScript.

The purpose of the bot is to scrape Slack for potentially informative and
helpful URLs posted by the participants of the community. When the bot
'hears' a URL posted (based on a regular expression test), it attempts to
POST to an API server that is charged with storing and maintaining the URLs.

##Installing Dependencies

After cloning to a local repository, you should be able to type `npm install`
from the root.

##Testing the Otis-Bot

After installing the required dependencies (please see above), type `npm test`
from the root.

##Otis-Bot in Production

Otis-Bot currently remains pre-production.

##Credits

Otis-Bot was written by Michael Ferrill and is maintined by Michael Farrell and
other graduates of the Firehose Project, including:

Matthew Dunn ([radiofreemattd](https://github.com/radiofreemattd))

Michael Farrell ([mikeysax](https://github.com/Mikeysax))

##Licensing Information

Otis-Bot is subject to the terms of the MIT License Agreement, available [here](MITLicense.md).
