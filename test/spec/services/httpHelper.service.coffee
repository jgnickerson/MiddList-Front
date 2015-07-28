describe('Service: httpHelper', ->
  httpHelper = null
  $httpBackend = null
  errorService = null
  fakeData = [
    {
      'author': 'a',
      'title': 'a',
      postId: 1,
      categoryId: 1
    }, {
      'author': 'b',
      'title': 'b',
      postId: 1,
      categoryId: 1
    }
  ]

  beforeEach(module('middlistApp'))

  # Initialize the controller and a mock scope
  beforeEach(inject (_httpHelper_, _$httpBackend_, _errorService_) ->
    httpHelper = _httpHelper_
    $httpBackend = _$httpBackend_
    errorService = _errorService_
    spyOn(httpHelper,'transformResponse').and.callThrough()
    spyOn(httpHelper,'handleError').and.callThrough()
  )

  it('on successful requests, should transform response by returning just response.data', ->
    $httpBackend.whenGET('http://localhost:3000/posts').respond(fakeData)
    responseData = null
    httpHelper.get('http://localhost:3000/posts')
      .then((data) -> responseData = data)
    $httpBackend.flush()
    expect(httpHelper.transformResponse).toHaveBeenCalled()
    expect(responseData).toEqual(fakeData)
  )

  it('on unsuccessful request, should call and add err to errorService', ->
    err = "error"
    $httpBackend.whenPOST('http://localhost:3000/posts').respond(400, err)
    httpHelper.post('http://localhost:3000/posts', fakeData[0])
    $httpBackend.flush()
    expect(httpHelper.handleError).toHaveBeenCalled()
    expect(errorService.errors.length).toEqual(1)
    expect(errorService.errors[0]).toEqual(err)
  )
)
