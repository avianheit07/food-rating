module.exports =
  test: (req,res)->

    return
  latest: (req,res)->
    # get the latest foods from yesterday to latest
     
    if req.isSocket
      sails.sockets.join req.socket,'menu/latest'
    else
      minDate = new Date()
      minDate.setDate minDate.getDate()-1

      filter =
        date:
          '>=':minDate

      Menu.find filter
      .exec (err,data)->
        if err
          res.json err
        else
          res.json data
    return
  save: (req,res)->
    if req.isSocket and req.method is "POST"
      Menu.create req.body
      .exec (err,newMenu)->
        if err
          res.json err
        else
          sails.sockets.broadcast "menu/latest","menu/latest",newMenu
          res.json newMenu
          return
    else if req.method is "PUT"
      id = req.body.id
      if id
        Menu.update id:id,req.body
        .exec (err,updatedMenu)->
          if err
            res.json err
          else
            sails.sockets.broadcast "menu/latest","menu/latest",updatedMenu
            res.json updatedMenu
          return
