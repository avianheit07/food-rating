module.exports =
  adapter: 'mongo'
  attributes:
    provider: 'STRING'
    uid: 'STRING'
    name: 'STRING'
    email: 'STRING'
    firstname: 'STRING'
    lastname: 'STRING'
    role:
      type:"INTEGER"
      defaultsTo: 0