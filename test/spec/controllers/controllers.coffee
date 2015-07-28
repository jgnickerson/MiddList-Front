describe('Controller: ListController', ->
  scope = null
  $controller = null
  $routeParams = null
  postsService = null

  beforeEach(module('middlistApp'))

  beforeEach(() ->
    mockPostsService = {}
    module('middlistApp', ($provide) ->
      $provide.value('postsService', mockPostsService)
      return
    )


    inject(($q) ->
      mockPostsService.categories = [
        {name: 'Cat1', id: 1}
        {name: 'Cat2', id: 2}
        {name: 'Cat3', id: 3}
      ]
      mockPostsService.posts = [
        {
          author:'A'
          title:'A'
          description:'A'
          postId:1
          categoryId:1
        },
        {
          author:'B'
          title:'B'
          description:'B'
          postId:2
          categoryId:2
        },
        {
          author:'C'
          title:'C'
          description:'C'
          postId:3
          categoryId:3
        }
      ]

      mockPostsService.getPosts = ->
        defer = $q.defer()
        defer.resolve(this.posts)
        return defer.promise

      mockPostsService.getCategories = ->
        defer = $q.defer()
        defer.resolve(this.categories)
        return defer.promise

      mockPostsService.getCategoryPosts = (categoryId) ->
        categoryId = parseInt(categoryId)
        defer = $q.defer()
        categoryPosts = _.filter(this.posts, (p) -> categoryId is p.categoryId)
        defer.resolve(categoryPosts)
        return defer.promise
    )

    inject((_$controller_, $rootScope, _$routeParams_, _postsService_) ->
      scope = $rootScope.$new()
      $routeParams = _$routeParams_
      postsService = _postsService_
      $controller = _$controller_('ListController',
        $scope: scope,
        $routeParams: {categoryId:'0'}
        postsService: postsService
      )
      scope.$apply()
    )
  )

  it('should contain all categories in scope on startup', ->
    expect(scope.categories).toEqual([
      {name: 'Cat1', id: 1},
      {name: 'Cat2', id: 2},
      {name: 'Cat3', id: 3}
    ])
  )

  describe('with a $routeParams.categoryId of "0"', ->

    beforeEach( ->
      spyOn(scope,'getCategoryObject')
    )

    it('should grab all posts contained in the service, dumping them to scope.posts', ->
      expect(scope.posts.length).toEqual(postsService.posts.length)
      expect(scope.posts).toEqual(postsService.posts)
    )

    it('should grab the category.name for each post', ->
      scope.getCategoryObject(1)
      expect(scope.getCategoryObject).toHaveBeenCalled()
    )
  )

  describe('with a $routeParams.categoryId of "1"', ->

    beforeEach(
      #reinjecting to change routeparams to 1 to test other state of controller
      inject((_$controller_, $rootScope, _$routeParams_, _postsService_) ->
        scope = $rootScope.$new()
        $routeParams = _$routeParams_
        postsService = _postsService_
        $controller = _$controller_('ListController',
          $scope: scope,
          $routeParams: {categoryId:'1'}
          postsService: postsService
        )
        scope.$apply()
      )
    )

    it('should only grab posts belonging to categoryId "1"', ->
      expect(scope.posts.length).toEqual(1)
    )
  )
)
