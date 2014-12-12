module.exports = {
  subscribe: (req,res)->
    data= req.params.all()
    id = req.param "id"
    if id
      Test.findOneById id
      .exec (err,test)->
        if !err
          if req.isSocket and req.method is 'PUT'

              test.name = req.param "name"
              test.children = req.param "children"

              test.save (err)->
                room = "test/"+test.id
                sails.sockets.broadcast room,room,test
                res.json hello:"world"
                #Test.publishUpdate(test.id,test)

          else if req.isSocket
            sails.sockets.join req.socket, 'test/'+id
            res.json room:'test/'+id
          else
            res.json test
    else
      if req.isSocket and req.method is "POST"
        Test.create req.body
        .exec (err,test)->
          if err
            console.log err
          else
            sails.sockets.broadcast "test/all","test/all",test
            #Test.publishCreate test
      else if req.isSocket
        sails.sockets.join req.socket, 'test/all'
      else
        Test.find()
        .exec (err,data)->
          if !err
            res.json data

  terminate: (req,res)->

    id = req.param "id"
    Test.findOneById id
    .exec (err,test)->
      if req.isSocket
        Test.unsubscribe req.socket,test
}