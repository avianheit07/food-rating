###
  date:"11-12-2014"
  foods:[
    {
      name:""
    }
  ]
###
module.exports =
  adapter: 'mongo'
  attributes:
    date:"date"
    foods:"ARRAY"
    orders:
      collection: "order"
      via: "menu"