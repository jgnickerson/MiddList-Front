describe('Controller: ListController', ->
  scope = null
  $controller = null
  $routeParams = null
  postsService = null

  beforeEach(module('middlistApp'))

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
          author: 'A'
          title: 'A'
          description: 'A'
          postId: 1
          categoryId: 1
        },
        {
          author: 'B'
          title: 'B'
          description: 'B'
          postId: 2
          categoryId: 2
        },
        {
          author: 'C'
          title: 'C'
          description: 'C'
          postId: 3
          categoryId: 3
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
    injectNewController('0')
  )

  it('should contain all categories in scope on startup', ->
    expect(scope.categories).toEqual([
      {name: 'Cat1', id: 1},
      {name: 'Cat2', id: 2},
      {name: 'Cat3', id: 3}
    ])
  )

#  refactored the below into a directive

#  describe('getCategoryObject()', ->
#    it('should grab the category.name for each post when given an number', ->
#      expect(scope.getCategoryObject(1)).toEqual(postsService.categories[0])
#    )
#
#
#    it('should grab the category.name for each post when given a number as a string', ->
#      expect(scope.getCategoryObject('1')).toEqual(postsService.categories[0])
#    )
#  )

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
