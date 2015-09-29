(function() {
  angular.module('middlistApp').controller('ListController', [
    '$scope', '$routeParams', 'postsService', function($scope, $routeParams, postsService) {
      $scope.category = $routeParams.category;
      $scope.categories = [];
      $scope.posts = [];
      postsService.getCategories().then(function(cats) {
        return $scope.categories = cats;
      });
      if ($scope.category === 'all') {
        return postsService.getPosts().then(function(posts) {
          return $scope.posts = posts;
        });
      } else {
        return postsService.getCategoryPosts($scope.category).then(function(posts) {
          return $scope.posts = posts;
        });
      }
    }
  ]);

}).call(this);