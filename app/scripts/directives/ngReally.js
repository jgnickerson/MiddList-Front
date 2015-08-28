(function() {
  angular.module('middlistApp').directive('ngReallyClick', [
    function() {
      return {
        restrict: 'A',
        link: function(scope, element, attrs) {
          return element.bind('click', function() {
            var message;
            message = attrs.ngReallyMessage;
            if (message && confirm(message)) {
              return scope.$apply(attrs.ngReallyClick);
            }
          });
        }
      };
    }
  ]);

}).call(this);