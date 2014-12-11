app.controller("ListCtrl",[
  "$scope",
  "APPLICANT",
  function($scope, APPLICANT){
    $scope.developers = APPLICANT.query();
  }
])