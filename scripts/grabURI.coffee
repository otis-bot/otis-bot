# Description:
#   A Hubot robot that listens for the posting of
#   URLs to Slack chat and than posts them to a
#   back-end database.
# Dependencies:
#   url-regex
# Configuration:
#   None
# Commands:
#   None
# Author:
#   © 2016 The Firehose Project
#   License MIT (https://opensource.org/licenses/MIT).

urlRegex = require('url-regex')

module.exports = (robot) ->
  robot.hear urlRegex(), (msg) ->
    slackURL = msg.match[0]
    msg.send "Meow, Uploading: #{slackURL}"

    data = JSON.stringify({
      url: slackURL
    })

    robot.http('http://www.APIBackend.com/url')
      .header('Content-Type', 'application/json')
      .post(data) (err, res, body) ->
        if err
          robot.send 'hubot', 'Otis has failed'
          robot.emit 'error', err, res
          return
