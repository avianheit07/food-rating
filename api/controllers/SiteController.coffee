module.exports =
  index: (req,res)->
    View.render req
    return
  logout: (req,res)->
    req.session.destroy()
    res.redirect "/"
    return