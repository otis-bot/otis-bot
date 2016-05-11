regExp = new RegExp("^(http[s]?:\\/\\/(www\\.)?|ftp:\\/\\/(www\\.)?|www\\.){1}([0-9A-Za-z-\\.@:%_\+~#=]+)+((\\.[a-zA-Z]{2,3})+)(/(.)*)?(\\?(.)*)?")
apiURL = "PlaceHolder"

module.exports = (robot) ->
  robot.hear regExp, (msg) ->
    slackURL = msg.match[1]
    msg.reply "Meow, Uploading: #{slackURL}"
    robot.http(apiURL).post(slackURL) (err, res, body) ->
      if err
        res.send "Otis has failed you: #{err}"
        return
      res.send "Meow"
