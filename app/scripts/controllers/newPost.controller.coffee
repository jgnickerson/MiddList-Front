angular.module('middlistApp').controller('NewPostController', ['$scope', '$location', '$routeParams', 'postsService'
  ($scope, $location, $routeParams, postsService) ->

    pristinePost = {title: null, category: null, author: null, description: null}
    postId = $routeParams.postId
    $scope.categories = []
    $scope.path = $location.path()

    postsService.getCategories().then((cats) -> $scope.categories = cats)

    if $scope.path is '/postForm'
      $scope.post = {}
    else
      postsService.getPost(postId).then((post) -> $scope.post = angular.copy(post))

    $scope.update = () ->
      if $scope.postForm.$valid

        if $scope.path is '/postForm'
          postsService.addNewPost($scope.post).then(-> $location.path('/list'))
        else
          postsService.updatePost($scope.post).then(-> $location.path('/list'))

    $scope.reset = (form) ->
      if form?
        form.$setPristine()
        form.$setUntouched()
      $scope.post = angular.copy(pristinePost)
])
