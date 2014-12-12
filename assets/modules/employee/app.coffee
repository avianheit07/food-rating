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
    .when "/rate/:dayId",
      template: JST["employee/rate/rate.html"]()
      controller: "RateCtrl"
    .when "/review/:id",
      template: JST["common/review/review.html"]()
      controller:"ReviewCtrl"
    .otherwise redirectTo:"/"
]
app.run ($http)->
  $http.defaults.headers.common['food-api'] = true