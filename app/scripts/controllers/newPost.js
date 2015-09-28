(function() {
  angular.module('middlistApp').controller('NewPostController', [
    '$scope', '$location', '$routeParams', 'postsService', function($scope, $location, $routeParams, postsService) {
      var postId, pristinePost;
      pristinePost = {
        title: null,
        category: null,
        author: null,
        description: null
      };

      postId = $routeParams.postId;
      $scope.categories = [];
      $scope.path = $location.path();
      postsService.getCategories().then(function(cats) {
        return $scope.categories = cats;
      });

      if ($scope.path === '/postForm') {
        $scope.post = {};
      } else {
        postsService.getPost(postId).then(function(post) {
          return $scope.post = angular.copy(post);
        });
      }

      $scope.update = function() {
        if ($scope.postForm.$valid) {
          if ($scope.path === '/postForm') {
            return postsService.addNewPost($scope.post).then(function() {
              return $location.path('/list');
            });
          } else {
            return postsService.updatePost($routeParams.postId, $scope.post).then(function() {
              return $location.path('/list');
            });
          }
        }
      };

      return $scope.reset = function(form) {
        if (form != null) {
          form.$setPristine();
          form.$setUntouched();
        }
        return $scope.post = angular.copy(pristinePost);
      };
    }
  ]);

}).call(this);
