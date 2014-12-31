app.directive "faceRater",[
  ->
    return {
      restrict: "E"
      template:JST["common/rate/rate.html"]()
      replace: true
      require:"ngModel"
      scope:
        rating: "=ngModel"
      link: (scope,element,attrs)->
        scope.scores = [1,2,3,4,5]

        scope.select = (idx)->
          scope.rating = parseInt idx,10
          return
        scope.selected = (idx)->
          return scope.rating == parseInt idx,10
        return
    }
]