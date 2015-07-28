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

angular.module('middlistApp').directive('categoryNav',['postsService',(postsService) ->
  return (
    templateUrl: '../views/categoryNav.html'
    scope: {}
    controller: ['$scope', ($scope) ->
      $scope.categories = []
      postsService.getCategories().then((cats) -> $scope.categories = cats)
    ]
  )
])

angular.module('middlistApp').directive('errorList', ->
  return {
    controller: ['$scope','errorService', ($scope, errorService) ->
      $scope.errors = errorService.errors
    ]
    templateUrl: '../views/errorList.html'
  }
)
