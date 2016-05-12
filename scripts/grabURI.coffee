# Place Holder apiUrl
apiURL = "#"
# Regular Expression for finding URI
regExp = new RegExp("^(http[s]?:\\/\\/(www\\.)?|ftp:\\/\\/(www\\.)?|www\\.){1}([0-9A-Za-z-\\.@:%_\+~#=]+)+((\\.[a-zA-Z]{2,3})+)(/(.)*)?(\\?(.)*)?", "i")
# Listens for URL and posts as JSON to apiURL
module.exports = (robot) ->
  robot.hear regExp, (msg) ->
    console.log "------------------------------------------------"
    console.log "this is the msg: #{msg}"
    console.log "this is the full match #{msg.match}"
    console.log "------------------------------------------------"
    slackURL = msg.match[0]
    console.log "------------------------------------------------"
    console.log "This is the slackURL #{slackURL}"
    console.log "------------------------------------------------"
    msg.send "Meow, Uploading: #{slackURL}"

    data = JSON.stringify({
      url: slackURL
    })
    console.log "This is the data JSON: #{data}"
    robot.http(apiURL)
      .header('Content-Type', 'application/json')
      .post(data) (err, res, body) ->
        if err
          robot.reply "Otis has failed you :("
          robot.emit 'error', err, res
          return
