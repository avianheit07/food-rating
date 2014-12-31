module.exports =
  latest: (req,res)->
    # get the latest foods from yesterday to latest

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
        if data.length
          menuIds = data.map (e)->
            return e.id

          orderFilter =
            menu:menuIds
            user: UserData(req).id
          
          Order.find orderFilter
          .exec (err,orders)->
            if err
              res.json err
            else
              res.json orders
            return
        else
          res.json []
      return
    return
  save: (req,res)->
    if req.isSocket and req.method is "POST"
      order = req.body
      order.user = UserData(req).id

      Order.create req.body
      .exec (err,newOrder)->
        if err
          res.json err
        else
          sails.sockets.broadcast "order/latest","order/latest",newOrder
          res.json newOrder
          return
    else if req.method is "PUT"

      ###
        be able to send the order update to the menu items being listened

      ###
      id = req.body.id
      if id
        Order.update id:id,req.body
        .exec (err,updatedOrder)->
          if err
            res.json err
          else
            sails.sockets.broadcast "order/latest","order/latest",updatedOrder
            res.json updatedOrder
          return
