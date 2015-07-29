angular.module('middlistApp').controller('ListController', ['$scope', '$routeParams', 'postsService'
  ($scope, $routeParams, postsService) ->
    $scope.categoryId = $routeParams.categoryId
    $scope.categories = []
    $scope.posts = []

    postsService.getCategories().then((cats) -> $scope.categories = cats)

    if $scope.categoryId is '0'
      postsService.getPosts().then((posts) -> $scope.posts = posts)
    else
      postsService.getCategoryPosts($scope.categoryId).then((posts)-> $scope.posts = posts)
])
