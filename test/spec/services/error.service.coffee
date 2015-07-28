describe('Service: errorService',( ->
  errorService = null

  beforeEach(module('middlistApp'))

  # Initialize the controller and a mock scope
  beforeEach(inject((_errorService_) ->
    errorService = _errorService_
  ))

  it('should give us an array of error messages, containing only "err"',( ->
    expect(errorService.errors.length).toEqual(0)
    err = "err"
    errorService.addError(err)
    expect(errorService.errors.length).toEqual(1)
    expect(errorService.errors).toEqual([err])
  ))
))
