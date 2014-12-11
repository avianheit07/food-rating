app.directive "star", [ ->
  restrict: "E"
  replace: true
  template: JST["common/star/star.html"]()
  require: "ngModel"
  scope:
    selected: "=ngModel"
    limit: "@"
    viewOnly: "@"

  controller: ($scope, $element, $attrs) ->
    $scope.selected = $scope.selected or 0
    $scope.select = (i) ->
      $scope.selected = i + 1  unless $scope.viewOnly

    $scope.hovered = 0
    $scope.hover = (i) ->
      $scope.hovered = i + 1  unless $scope.viewOnly

    numStars = (if $attrs.limit then parseInt($attrs.limit, 10) else 5)
    $scope.stars = []
    i = 0

    while i < numStars
      $scope.stars.push count: i + 1
      i++
    $scope.selectClass = (count) ->
      num = $scope.hovered or $scope.selected
      starClass = (if count <= num then "icon-star" else "icon-star-outline")
      starClass
 ]