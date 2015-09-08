(function() {
  angular.module('middlistApp').directive('categoryNav', [
    'postsService', '$routeParams', function(postsService, $routeParams) {
      return {
        scope: {},
        link: function(scope) {
          var category;
          scope.categories = [];
          postsService.getCategories().then(function(cats) {
            return scope.categories = cats;
          });
          scope.currentCat = {};
          category = $routeParams.category;
            console.log(category);
          if (category === 'all') {
            return scope.currentCat = {
              title: 'All Posts'
            };
          } else {
            return postsService.getCategory(category).then(function(cat) {
                console.log("Current category: " + cat.title);
              return scope.currentCat = cat;
            });
          }
        },
        templateUrl: 'views/categoryNav.html'
      };
    }
  ]);

}).call(this);