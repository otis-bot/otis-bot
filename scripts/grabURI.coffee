# Description:
#
# Dependencies:
#
# Configuration:
#
# Commands:
#
# Author:
#   The Firehose Project

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
          return
