module.exports = {
  index: function(req,res){

  },
  logout: function(req,res){
    req.session.destroy();
    res.redirect("/");
  }
}