var apiURL = "#";

module.exports = function(robot) {
  robot.hear(/(http|ftp|https)://([\w_-]+(?:(?:\.[\w_-]+)+))([\w.,@?^=%&:/~+#-]*[\w@?^=%&/~+#-])?/g), function(msg) {
    var slackURL = msg.match[0];
    msg.reply("Meow, Uploading: " + slackURL);

    robot.http(apiURL).post(slackURL, function(err, res, body) {
      if (err) {
        res.send("Otis has failed you: " + err);
        return;
      }
      res.send("Meow");
    });
  }
};
