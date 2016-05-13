urlRegex = require('url-regex')

apiURL = "#"
# Place Holder apiUrl

# Listens for URL and posts as JSON to apiURL
module.exports = (robot) ->
  robot.hear urlRegex(), (msg) ->
    slackURL = msg.match[0]
    msg.send "Meow, Uploading: #{slackURL}"

    data = JSON.stringify({
      url: slackURL
    })

    robot.http(apiURL)
      .header('Content-Type', 'application/json')
      .post(data) (err, res, body) ->
        if err
          robot.send "Otis has failed you :( #{err}"
          robot.emit 'error', err, res
          return
