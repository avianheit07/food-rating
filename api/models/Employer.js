module.exports = {
  adapter: "local",
  autoPK: true,
  attributes:{
    id:{
      primaryKey:true,
      type:"integer",
      autoIncrement: true
    },
    email:"email",
    password:"string"
  }
}