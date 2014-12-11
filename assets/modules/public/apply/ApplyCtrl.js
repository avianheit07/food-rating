app.controller("ApplyCtrl",[
  "$scope",
  "APPLICANT",
  function($scope,APPLICANT){
    
    $scope.applicant = new APPLICANT({skills:[]});
    $scope.skill = {}

    $scope.add = function(){
      $scope.applicant.skills.push($scope.skill);
      $scope.skill = {};
    }
    $scope.submit = function(applicant){
      if(applicant.$valid){
        $scope.applicant.$create(function(data){
          if(data.id){
            $scope.applicant = new APPLICANT({other:{}});
          }
        });
      }else{
        alert("please provide the required data");
      }
    }
  }
])