describe('Controller: NewPostController', ->
  scope = null
  $controller = null
  $routeParams = null
  $location = null
  postsService = null

  injectNewController = ((path)->
    return inject((_$controller_, $rootScope, _$routeParams_, _$location_, _postsService_) ->
      scope = $rootScope.$new()
      $routeParams = _$routeParams_
      $location = _$location_
      $location.path(path)
      postsService = _postsService_
      $controller = _$controller_('NewPostController',
        $scope: scope,
        postsService: postsService
      )
      scope.$apply()
    )
  )

  beforeEach(module('middlistApp'))

  beforeEach(() ->
#setting up mockPostsService
    mps = {}
    module('middlistApp', ($provide) ->
      $provide.value('postsService', mps)
      return
    )

    inject(($q) ->
      window.createMockPostsService($q, mps)
    )

    injectNewController('/postForm')
  )

  it('should contain all categories in scope on startup', ->
    expect(scope.categories).toEqual([
      {name: 'Cat1', id: 1},
      {name: 'Cat2', id: 2},
      {name: 'Cat3', id: 3}
    ])
  )

  describe('when path is "/postForm" (i.e. we are adding a new post)', ->
    it('should have an empty post in scope', ->
      expect(scope.post).toEqual({})
    )

    describe('when postForm is valid', ->
      beforeEach(->
        spyOn(postsService, 'addNewPost').and.callThrough()
        scope.postForm = {$valid: true}
      )
      it('upon scope.update(), should call postsService.addNewPost and redirect to "/list"', ->
        scope.update()
        expect(postsService.addNewPost).toHaveBeenCalled()
        scope.$apply()
        expect($location.path()).toEqual('/list')
      )
    )

    describe('when postForm is invalid', ->
      beforeEach(->
        scope.postForm = {$valid: false}
        spyOn(postsService, 'addNewPost')
      )
      it('upon scope.update(), should not do anything', ->
        expect(postsService.addNewPost).not.toHaveBeenCalled()
      )
    )

    it('upon scope.reset() should reset scope.post to a null object', ->
      scope.post = {author: 'a', title: 'a'}
      scope.$apply()
      expect(scope.post).not.toEqual({})
      scope.reset()
      scope.$apply()
      expect(scope.post).toEqual({title: null, category: null, author: null, description: null})
    )
  )



  describe('when path is NOT "/postForm" (i.e. we are updating an existing post)', ->
    beforeEach(->
      injectNewController('/posts/1/edit')
      spyOn(postsService, 'updatePost').and.callThrough()
      scope.postForm = {$valid: true}
    )

    it('should copy the existing post from postsService', ->
      expect(scope.post).not.toEqual({})
    )

    it('upon scope.update() should call postsService.updatePost and redirect to "/list"', ->
      scope.update()
      expect(postsService.updatePost).toHaveBeenCalled()
      scope.$apply()
      expect($location.path()).toEqual('/list')
    )
  )
)
