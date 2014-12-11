
module.exports.routes = {
  '/': {
    controller: 'SiteController',
    action:'index'
  },
  'post /login':{
    controller: 'SiteController',
    action:'login'
  },
  'get /logout':{
    controller: 'SiteController',
    action: 'logout'
  },
  'get /apply':{
    controller: 'SiteController',
    action:'index'
  },
  'get /developer/:id':{
    controller: 'SiteController',
    action:'index'
  }
};
