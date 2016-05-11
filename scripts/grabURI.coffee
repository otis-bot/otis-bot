regExp = new RegExp("(http|ftp|https)://([\w_-]+(?:(?:\.[\w_-]+)+))([\w.,@?^=%&:/~+#-]*[\w@?^=%&/~+#-])?", "g")
apiURL = "www.fakewebsite.otis"

module.exports = (robot) ->
  robot.hear regExp, (msg) ->
    slackURL = msg.match[0]
    msg.reply "Meow, Uploading: #{slackURL}"
    robot.http(apiURL).post(slackURL) (err, res, body) ->
      if err
        res.send "Otis has failed you: #{err}"
        return
      res.send "Meow"
