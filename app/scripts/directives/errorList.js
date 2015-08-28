(function() {
  angular.module('middlistApp').directive('errorList', [
    'errorService', function(errorService) {
      return {
        link: function(scope) {
          return scope.errors = errorService.errors;
        },
        template: "<ul>\n    <li ng-repeat=\"err in errors\">{{err}}</li>\n</ul>"
      };
    }
  ]);

}).call(this);