app.controller("DeveloperCtrl",[
	"$scope",
	"APPLICANT",
	"$routeParams",
	function($scope, APPLICANT, $routeParams){
		console.log($routeParams.id);
		$scope.developer = new APPLICANT({
			id:$routeParams.id
		});
		$scope.developer.$find();
	}

])