angular.module('middlistApp').controller('PostViewController', ['$scope', '$http', '$routeParams', '$location', 'postsService'
  ($scope, $http, $routeParams, $location, postsService) ->
    postId = $routeParams.postId
    $scope.post = {}
    $scope.category = {}

    postsService.getPost(postId).then((post) ->
      $scope.post = post
      postsService.getCategory($scope.post.categoryId).then((category) -> $scope.category = category)
    )

    $scope.deletePost = ->
      postsService.deletePost(postId).then(-> $location.path('/list'))
])
