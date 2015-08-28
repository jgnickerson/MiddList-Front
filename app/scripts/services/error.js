(function() {
  angular.module('middlistApp').service('errorService', function() {
    var errors, service;
    service = {};
    errors = [];
    service.addError = function(err) {
      return errors.push(err);
    };
    service.errors = errors;
    return service;
  });

}).call(this);

//# sourceMappingURL=error.js.map
