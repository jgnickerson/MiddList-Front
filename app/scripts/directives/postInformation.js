(function() {
  angular.module('middlistApp').directive('postInformation', [
    'postsService', '$location', function(postsService, $location) {
      return {
        scope: {
          post: '='
        },
        link: function(scope) {
          scope.category = {};
          postsService.getCategory(scope.post.categoryId).then(function(cat) {
            return scope.category = cat;
          });
          return scope.deletePost = function(postId) {
            return postsService.deletePost(postId).then(function() {
              return $location.path('/list');
            });
          };
        },
        templateUrl: 'views/postInformation.html'
      };
    }
  ]);

}).call(this);