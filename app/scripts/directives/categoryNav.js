(function() {
  angular.module('middlistApp').directive('categoryNav', [
    'postsService', '$routeParams', function(postsService, $routeParams) {
      return {
        scope: {},
        link: function(scope) {
          var categoryId;
          scope.categories = [];
          postsService.getCategories().then(function(cats) {
            return scope.categories = cats;
          });
          scope.currentCat = {};
          categoryId = $routeParams.categoryId;
          if (categoryId === '0') {
            return scope.currentCat = {
              name: 'All Posts'
            };
          } else {
            return postsService.getCategory(categoryId).then(function(cat) {
              return scope.currentCat = cat;
            });
          }
        },
        templateUrl: 'views/categoryNav.html'
      };
    }
  ]);

}).call(this);