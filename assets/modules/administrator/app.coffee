app = angular.module "FoodApp",["ngResource","ngRoute","ngAnimate"]

app.config [
  "$routeProvider"
  "$locationProvider"
  ($routeProvider, $locationProvider)->
    $locationProvider.html5Mode true

    $routeProvider
    .when "/",
      template: JST["common/summary/summary.html"]()
      controller:"SummaryCtrl"
    .when "/day/:id",
      template: JST["administrator/day/day.html"]()
      controller: "DayCtrl"
    .when "/review/:id",
      template: JST["common/review/review.html"]()
      controller:"ReviewCtrl"
    .otherwise redirectTo:"/"
]