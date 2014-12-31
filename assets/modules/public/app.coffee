app = angular.module "FoodApp",["ngResource","ngRoute","ngAnimate"]

app.config [
  "$routeProvider"
  "$locationProvider"
  ($routeProvider, $locationProvider)->
    $locationProvider.html5Mode true

    $routeProvider
    .when "/",
      template: JST["public/menus/menus.html"]()
      controller:"MenusCtrl"
]
app.run ($http)->
  $http.defaults.headers.common['food-api'] = true

app.controller "LoginCtrl",[
  "$scope"
  ($s)->
    $s.login = ->
      document.location = "/auth/google/"
    return
]