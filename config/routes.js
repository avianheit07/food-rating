var toUnk = [
  "/:unk",
  "/review/:id",
  "/rate/:id",
  "/day/:id"
]
var routes = {
  '/': {
    controller: 'AuthController',
    action:'index'
  },
  '/logout':{
    controller: 'AuthController',
    action:'logout'
  },
  '/test/subscribe/:id':{
    controller: 'TestController',
    action:'subscribe'
  },
  '/test/terminate/:id':{
    controller: 'TestController',
    action:'terminate'
  }
};
toUnk.forEach(function(url){
  routes[url] = {
    controller: 'AuthController',
    action: 'index',
    skipAssets: true
  }
})
module.exports.routes = routes;