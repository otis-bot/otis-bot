regExp = new RegExp("^(http[s]?:\\/\\/(www\\.)?|ftp:\\/\\/(www\\.)?|www\\.){1}([0-9A-Za-z-\\.@:%_\+~#=]+)+((\\.[a-zA-Z]{2,3})+)(/(.)*)?(\\?(.)*)?", "i")
# Place Holder apiUrl
apiURL = "#"

# Listens for URL and posts as JSON to apiURL
module.exports = (robot) ->
  robot.hear regExp, (msg) ->
    slackURL = msg.match[0]
    msg.send "Meow, Uploading: #{slackURL}"

    data = JSON.stringify({
      url: slackURL
    })

    robot.http(apiURL)
      .header('Content-Type', 'application/json')
      .post(data) (err, res, body) ->
        if (err)
          "Otis has failed you :("
          return
