describe('postInformation Directive:', ->
  $compile = null
  scope = null
  postsService = {}
  element = null
  mockCat = null
  $q = null
  $location = null

  beforeEach(module('middlistApp'))

  beforeEach( ->
    inject((_$compile_, $rootScope, _$q_, _$location_, _postsService_) ->
      $compile = _$compile_
      scope = $rootScope.$new()
      $q = _$q_
      $location = _$location_
      scope.post = {author: 'a', title: 'a', description: 'a', date: new Date(), postId: 1, categoryId: 1}
      postsService = _postsService_
#      mock = (cat) -> {name:'cat1',id:1}
      mockCat = {name:'cat1',id:1}


#      spyOn(postsService,'getCategory').and.returnValue(mockCat)
      spyOn(postsService, 'getCategory').and.callFake( ->
        deferred = $q.defer()
        deferred.resolve(mockCat)
        return deferred.promise
      )

#      spyOn(postsService,'deletePost')
      spyOn(postsService,'deletePost').and.callFake( ->
        deferred = $q.defer()
        deferred.resolve()
        return deferred.promise
      )



      element = $compile("<post-information post='post'></post-information>")(scope)
      scope.$digest()
    )
  )

  it('binds and displays post and category in scope', ->
    expect(element.isolateScope().category).toEqual(mockCat)
    expect(element.html()).toContain(scope.post.author, scope.post.title, scope.post.description, mockCat.name)
  )

  it('upon delete() click, makes a call to postsService.deletePost', ->
    spyOn($location,'path')
    element.isolateScope().deletePost(scope.post.postId)
    scope.$digest()
    expect($location.path).toHaveBeenCalledWith('/list')
    expect(postsService.deletePost).toHaveBeenCalled()
  )
)

