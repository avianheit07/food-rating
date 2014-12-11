app.directive("star",[
  function(){
    return {
      restrict:"E",
      replace:true,
      template:JST["common/star/star.html"](),
      require:"ngModel",
      scope:{
        selected:"=ngModel",
        limit:"@",
        viewOnly:"@"
      },
      controller: function($scope,$element,$attrs){

        $scope.selected = $scope.selected || 0;
        $scope.select = function(i){
          if(!$scope.viewOnly){
            $scope.selected = i+1;
          }
        }

        $scope.hovered = 0;
        $scope.hover = function(i){
          if(!$scope.viewOnly){
            $scope.hovered = i+1;
          }
        }
        var numStars = $attrs.limit ? parseInt($attrs.limit,10) : 5;
        $scope.stars = [];

        for(var i = 0;i<numStars;i++ ){
          $scope.stars.push({
            count:i+1
          });
        }

        $scope.selectClass = function(count){
          num = $scope.hovered || $scope.selected;
          starClass = count<=num ? "icon-star":"icon-star-outline";
          return starClass;
        }
      }
    }
  }
])