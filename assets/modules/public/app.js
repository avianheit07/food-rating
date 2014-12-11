var app = angular.module("RegistrationApp",["ngResource","ngRoute"]);

app.config([
  "$routeProvider",
  "$locationProvider",
  function( $routeProvider, $locationProvider ){
    $locationProvider.html5Mode(true);
      
    $routeProvider
    .when("/",{
      template: JST["common/list/list.html"](),
      controller:"ListCtrl"
    })
    .when("/apply",{
      template: JST["public/apply/apply.html"](),
      controller:"ApplyCtrl"
    })
    .when("/developer/:id",{
      template: JST["common/developer/developer.html"](),
      controller: "DeveloperCtrl"
    })
    .otherwise({
      redirectTo:"/"
    });
  }
]);