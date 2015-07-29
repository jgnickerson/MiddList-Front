describe('Controller: ListController', ->
  scope = null
  $controller = null
  $routeParams = null
  postsService = null

  injectNewController = (param) ->
    inject((_$controller_, $rootScope, _$routeParams_, _postsService_) ->
      scope = $rootScope.$new()
      $routeParams = _$routeParams_
      postsService = _postsService_
      $controller = _$controller_('ListController',
        $scope: scope,
        $routeParams: {categoryId: param}
        postsService: postsService
      )
      scope.$apply()
    )

  beforeEach(module('middlistApp'))

  beforeEach(() ->
    mps = {}
    module('middlistApp', ($provide) ->
      $provide.value('postsService', mps)
      return
    )

    inject(($q) ->
      window.createMockPostsService($q, mps)
    )

    injectNewController('0')
  )

  it('should contain all categories in scope on startup', ->
    expect(scope.categories).toEqual([
      {name: 'Cat1', id: 1},
      {name: 'Cat2', id: 2},
      {name: 'Cat3', id: 3}
    ])
  )

  describe('with a $routeParams.categoryId of "0"', ->
    it('should grab all posts contained in the service, dumping them to scope.posts', ->
      expect(scope.posts.length).toEqual(postsService.posts.length)
      expect(scope.posts).toEqual(postsService.posts)
    )
  )

  describe('with a $routeParams.categoryId of "1"', ->
    beforeEach(
      injectNewController('1')
    )

    it('should only grab posts belonging to categoryId "1"', ->
      expect(scope.posts.length).toEqual(1)
    )
  )
)
