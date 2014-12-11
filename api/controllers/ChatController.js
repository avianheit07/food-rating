/**
 * ChatController
 *
 * @description :: Server-side logic for managing chats
 * @help        :: See http://links.sailsjs.org/docs/controllers
 */

module.exports = {

  addConv:function (req,res) {
    var data_from_client = req.params.all();

    if(req.isSocket && req.method === 'POST'){

      // This is the message from connected client
      // So add new conversation
      Chat.create(data_from_client)
        .exec(function(error,data_from_client){
          Chat.publishCreate(data_from_client);
        }); 
    }
    else if(req.isSocket){
      // subscribe client to model changes 
      Chat.watch(req.socket);
      console.log( 'User subscribed to ' + req.socket.id );
    }else{
      Chat.find().exec(function(err,data){
        if(err){
          res.json(err);
        }else{
          res.json(data);
        }
      })
    }
  },
  test: function(req,res){

  }
};