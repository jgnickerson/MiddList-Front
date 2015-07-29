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

angular.module('middlistApp').directive('postInformation', ['postsService', (postsService) ->
  return {
    scope: {
      post: '='
    }
    link: (scope) ->
      scope.category = null
      postsService.getCategory(scope.post.categoryId).then((cat)-> scope.category = cat)
#    controller: ['$scope', 'postsService', ($scope, postsService) ->
#      $scope.category = {}
#      postsService.getCategory($scope.post.categoryId).then((cat)->$scope.category = cat)
#    ]
    templateUrl: '../views/postInformation.html'
  }
])
