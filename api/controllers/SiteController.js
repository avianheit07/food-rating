module.exports = {
  index: function(req,res){
    if(req.session.user){
      res.view("employer");
    }else{
      res.view("public");
    }

  },
  login: function(req,res){
    var filter = {
      email: req.body.email,
      password: req.body.password
    };


    Employer.findOne(filter).exec(function(err,user){
      if(err){
        res.json(err);
      }
      if(user){
        req.session.user = user;
      }else{
        Employer.create(filter)
        .exec(function(err,data){
          if(err){
            console.log(err);
          }
        })
      }
      res.redirect("/");
    });

  },
  logout: function(req,res){
    req.session.destroy();
    res.redirect("/");
  }
}