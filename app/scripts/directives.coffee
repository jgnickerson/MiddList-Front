angular.module('middlistApp').directive('ngReallyClick', [->
  return {
  restrict: 'A',
  link: (scope, element, attrs) ->
    element.bind('click', ->
      message = attrs.ngReallyMessage
      if message and confirm(message)
        scope.$apply(attrs.ngReallyClick)
    )
  }
])

angular.module('middlistApp').directive('categoryNav', ->
  return (
    template: """
                <div class="col-xs-8 col-xs-push-2 btn-group">
                  <button type="button" class="btn btn-primary btn-lg">MiddList</button>
                  <button id="main-dropdown-toggle" type="button" class="btn btn-primary btn-lg dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    <span class="glyphicon glyphicon-triangle-bottom"></span>
                    <span class="sr-only">Toggle Dropdown</span>
                  </button>
                  <ul class="dropdown-menu">
                    <li class="dropdown-header">
                    <li><a ng-href="#/list">All Posts</a></li>
                    <li ng-repeat="cat in categories"><a ng-href="#/list/{{cat.id}}">{{cat.name}}</a></li>
                  </ul>
                </div>
    """
    scope: {}
    controller: ['$scope', '$http', ($scope, $http) ->
      $scope.categories = []
      $http.get('http://localhost:3000/cats').success((cats) -> $scope.categories = cats)
    ]
  )
)
