(function() {
  angular.module('middlistApp', ['ngAnimate', 'ngCookies', 'ngMessages', 'ngResource', 'ngRoute', 'ngSanitize', 'ngTouch', 'ngMessages']);

  angular.module('middlistApp').config(function($routeProvider) {
    return $routeProvider.when('/list/:category', {
      templateUrl: 'views/list.html',
      controller: 'ListController'
    }).when('/postForm', {
      templateUrl: 'views/postForm.html',
      controller: 'NewPostController'
    }).when('/post/:postId', {
      templateUrl: 'views/post.html',
      controller: 'PostViewController'
    }).when('/post/:postId/edit', {
      templateUrl: 'views/postForm.html',
      controller: 'NewPostController'
    }).otherwise({
      redirectTo: '/list/all'
    });
  });

}).call(this);