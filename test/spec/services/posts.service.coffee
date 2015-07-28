xdescribe('Service: postsService',( ->
  postsService = {}
  httpBackend = {}
  fakeData =
    [{
      'author': 'a',
      'title': 'a',
      postId: 1,
      categoryId: 1
    }, {
      'author': 'b',
      'title': 'b',
      postId: 1,
      categoryId: 1
    }]


  beforeEach(module('middlistApp'))

  beforeEach(inject((_postsService_, $httpBackend) ->
    postsService = _postsService_
    httpBackend = $httpBackend
  ))

  it('should get an array of post objects',( ->
    httpBackend.whenGET("http://localhost:3000/posts").respond(fakeData)
    postsService.getPosts().then((posts) ->
      expect(posts).toEqual([{
        'author': 'a',
        'title': 'a',
        postId: 1,
        categoryId: 1
      }, {
        'author': 'b',
        'title': 'b',
        postId: 1,
        categoryId: 1
      }])
    )
    httpBackend.flush()
  ))

  it('should get an individual post object', ( ->
    httpBackend.whenGET('http://localhost:3000/posts/view/1').respond(fakeData[0])
    postsService.getPost('1').then((post) ->
      expect(post).toEqual({
        'author': 'a',
        'title': 'a',
        postId: 1,
        categoryId: 1
      })
    )
    httpBackend.flush()
  ))

))
