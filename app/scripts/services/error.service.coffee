angular.module('middlistApp').service('errorService', ['$window', ($window) ->

  service = {}

  errors = []

  service.addError = (err) ->
    errors.push(err)

  service.errors = errors

#  service.displayAlerts = ->
#    for alert in alerts
#      $window.alert(alert)
#      _.remove(alerts, (a) -> alert is a);

  return service

])
