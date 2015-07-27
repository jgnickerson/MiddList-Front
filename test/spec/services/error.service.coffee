describe 'Service: errorService', ->

  beforeEach module 'middlistApp'

  errorService = {}

  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($service, $rootScope) ->
    scope = $rootScope.$new()
    errorService = $service 'errorService', {

    }

  it 'should attach a list of awesomeThings to the scope', ->
