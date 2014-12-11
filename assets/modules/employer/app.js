var app = angular.module("RegistrationApp",["ngResource","ngRoute"]);

app.config([
	"$routeProvider",
	"$locationProvider",
	function( $routeProvider, $locationProvider ){
		$locationProvider.html5Mode(true);
		$routeProvider
		.when("/",{
		  template: JST["employer/list.html"](),
		  controller:"ListCtrl"
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