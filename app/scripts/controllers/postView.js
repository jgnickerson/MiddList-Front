(function() {
  angular.module('middlistApp').controller('PostViewController', [
    '$scope', '$http', '$routeParams', '$location', 'postsService', function($scope, $http, $routeParams, $location, postsService) {
      var postId;
      postId = $routeParams.postId;
      $scope.post = {};
      $scope.category = {};
      postsService.getPost(postId).then(function(post) {
        $scope.post = post;
        return postsService.getCategory($scope.post.category).then(function(category) {
          return $scope.category = category;
        });
      });
      return $scope.deletePost = function() {
        return postsService.deletePost(postId).then(function() {
          return $location.path('/list');
        });
      };
    }
  ]);

}).call(this);