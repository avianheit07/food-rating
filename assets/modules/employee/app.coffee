app = angular.module "FoodApp",["ngResource","ngRoute","ngAnimate"]

app.config [
  "$routeProvider"
  "$locationProvider"
  ($routeProvider, $locationProvider)->
    $locationProvider.html5Mode true

    $routeProvider
    .when "/",
      template: JST["employee/menus/menus.html"]()
      controller:"MenusCtrl"
]
app.controller "LoginCtrl",[
  "$scope"
  ($s)->
    $s.logout = ->
      document.location = "/logout"
    return
]
app.run ($http)->
  $http.defaults.headers.common['food-api'] = true