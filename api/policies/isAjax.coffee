module.exports = (req, res, next) ->
  url = req.url
  exception = false
  except = [
    "auth/google/"
    "auth/google/callback"
    "styles/"
    "js/"
    "templates/"
  ]
  except.forEach (ex)->
    exception = true if url.indexOf(ex) isnt -1
  if req.headers["food-api"] or url is "/login" or url is "/logout" or exception
    next()
  else #login or logout
    View.render req, res