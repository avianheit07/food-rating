app.controller("MainCtrl",[
	"$scope",
	function($scope){

		$scope.logout = function(){
        	document.location = '/logout'
		}

	}

]);