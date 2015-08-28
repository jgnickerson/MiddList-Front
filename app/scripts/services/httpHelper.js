(function() {
  angular.module('middlistApp').service('httpHelper', [
    '$http', 'errorService', function($http, errorService) {
      var service;
      service = {};
      service.transformResponse = function(response) {
        return response != null ? response.data : void 0;
      };
      service.handleError = function(reason) {
        return errorService.addError(reason != null ? reason.data : void 0);
      };
      service.get = function(url) {
        return $http.get(url).then(this.transformResponse, this.handleError);
      };
      service.post = function(url, item) {
        return $http.post(url, item).then(this.transformResponse, this.handleError);
      };
      service.put = function(url, item) {
        return $http.put(url, item).then(this.transformResponse, this.handleError);
      };
      service["delete"] = function(url) {
        return $http["delete"](url).then(this.transformResponse, this.handleError);
      };
      return service;
    }
  ]);

}).call(this);

//# sourceMappingURL=httpHelper.js.map
