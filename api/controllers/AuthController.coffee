passport =require "passport"

module.exports =
  index: (req,res)->
    View.render(req,res)
    return
  logout: (req,res)->
    req.logout()
    res.redirect "/"
    return
  google: (req, res) ->
    passport.authenticate("google",
      failureRedirect: "/"
      scope: [ "https://www.googleapis.com/auth/plus.login", "https://www.googleapis.com/auth/userinfo.profile", "https://www.googleapis.com/auth/userinfo.email" ]
    , (err, user) ->
      
      req.logIn user, (err) ->
        if err
          console.log err
          res.redirect "/"
          return
        res.redirect "/"
        return

    ) req, res
  logged: (req,res)->
    res.json session: req.session.passport.user or false
    return