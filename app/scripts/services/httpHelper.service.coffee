angular.module('middlistApp').service('httpHelper', ['$http', 'errorService',  ($http, errorService) ->

  service = {}

  transformResponse = (response) -> response?.data

  handleError = (reason) ->
    errorService.addError(reason.data)
    throw reason.status + " : " + reason.data

  service.get = (url) ->
    $http.get(url).then(transformResponse,handleError)

  service.post = (url,item) ->
    $http.post(url,item).then(transformResponse,handleError)

  service.put = (url,item) ->
    $http.put(url,item).then(transformResponse,handleError)

  service.delete = (url) ->
    $http.delete(url).then(transformResponse,handleError)

  return service
])
