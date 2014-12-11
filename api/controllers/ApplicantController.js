module.exports = {
  query:function(req,res){
    Applicant.find()
    .exec(function(err,data){
      if(err){
        res.json(err);
      }else{
        res.json(data||[]);
      }
    })
  }
}