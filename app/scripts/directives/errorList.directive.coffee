angular.module('middlistApp').directive('errorList', ['errorService', (errorService) ->
  return {
  link: (scope) ->
    scope.errors = errorService.errors
  template: """
    <ul>
        <li ng-repeat="err in errors">{{err}}</li>
    </ul>
  """
  }
])
