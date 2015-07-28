angular.module('middlistApp').service('errorService', ->

  service = {}

  errors = []

  service.addError = (err) ->
    errors.push(err)

  service.errors = errors
  #gives service calls direct access to errors, rather than returning errors

  return service

)
