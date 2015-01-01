app.directive "faceRater",[
  "$timeout"
  ($t)->
    return {
      restrict: "E"
      template:JST["common/rate/rate.html"]()
      replace: true
      require:"ngModel"
      scope:
        rating: "=ngModel"
        onSelect: "&"
      link: (scope,element,attrs)->
        scope.scores = [1,2,3,4,5]

        scope.select = (score)->
          scope.rating = +score
          params =
            pidx : +attrs.pidx

          $t ->
            scope.onSelect params
          ,40
          return
        scope.selected = (score)->
          return scope.rating == (+score)
        return
    }
]