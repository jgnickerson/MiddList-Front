(function() {
  angular.module('middlistApp').controller('ListController', [
    '$scope', '$routeParams', 'postsService', function($scope, $routeParams, postsService) {
      $scope.categoryId = $routeParams.categoryId;
      $scope.categories = [];
      $scope.posts = [];
      postsService.getCategories().then(function(cats) {
        return $scope.categories = cats;
      });
      if ($scope.categoryId === '0') {
        return postsService.getPosts().then(function(posts) {
          return $scope.posts = posts;
        });
      } else {
        return postsService.getCategoryPosts($scope.categoryId).then(function(posts) {
          return $scope.posts = posts;
        });
      }
    }
  ]);

}).call(this);