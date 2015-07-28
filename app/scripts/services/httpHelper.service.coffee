angular.module('middlistApp').service('httpHelper', ['$http', 'errorService', ($http, errorService) ->
  service = {}

  service.transformResponse = (response) -> response?.data

  service.handleError = (reason) ->
    errorService.addError(reason?.data)

  service.get = (url) ->
    $http.get(url).then(this.transformResponse, this.handleError)

  service.post = (url, item) ->
    $http.post(url, item).then(this.transformResponse, this.handleError)

  service.put = (url, item) ->
    $http.put(url, item).then(this.transformResponse, this.handleError)

  service.delete = (url) ->
    $http.delete(url).then(this.transformResponse, this.handleError)

  return service
])
