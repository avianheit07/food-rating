module.exports = {
  subscribe: (req,res)->
    data= req.params.all()

    Test.findOneById req.param('id')
    .exec (err,test)->
      if !err
        if req.isSocket and req.method is 'PUT'

            test.name = req.param "name"
            test.children = req.param "children"

            test.save (err)->

              Test.publishUpdate(test.id,test)

        else if req.isSocket
          Test.subscribe req.socket,test
        else
          res.json test
  terminate: (req,res)->

    id = req.param "id"
    Test.findOneById id
    .exec (err,test)->
      if req.isSocket
        Test.unsubscribe req.socket,test
}