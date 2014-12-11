callouts =
  welcome: [message: "Welcome to MeWe please login to start using the app"]
  wrongAccess: [message: "Wrong email or password"]
  banned: [message: "email has been banned from accessing this app"]

###
 configure this later together with grunt task to get user data configuration from an external json file like users.json
###
module.exports.render = (req, res) ->
  base = req.headers.host
  user_data = req.session.passport.user
  if user_data
    switch user_data.role
      when 0
        return res.view("employee",
          base: base
        )
      when 1
        #administrator
        return res.view("administrator",
          base: base
        )
  else
    res.view "public",
      base: base
  return