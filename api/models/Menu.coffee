###
  date:"11-12-2014"
  foods:[
    {
      name:""
      score:0 / 5
      nightShiftOnly:true
    }
  ]
###
module.exports =
  adapter: 'mongo'
  attributes:
    date:"date"
    foods:"ARRAY"
    default:"INTEGER"