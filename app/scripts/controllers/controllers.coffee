angular.module('middlistApp').controller('ListController', ['$scope', '$routeParams', 'postsService'
  ($scope, $routeParams, postsService) ->
    $scope.categoryId = $routeParams.categoryId
    $scope.categories = []
    $scope.posts = []

    postsService.getCategories().then((cats) -> $scope.categories = cats)

    if $scope.categoryId is '0'
      postsService.getPosts().then((posts) -> $scope.posts = posts)
    else
      postsService.getCategoryPosts($scope.categoryId).then((posts)->$scope.posts = posts)

    #refactor this into postsService
    $scope.getCategoryObject = (categoryId) ->
      categoryId = parseInt(categoryId)
      _.find($scope.categories, (category) -> return category.id is categoryId)
])


angular.module('middlistApp').controller('NewPostController', ['$scope','$http', '$location', '$routeParams', 'postsService', 'errorService'
  ($scope, $http, $location, $routeParams, postsService, errorService) ->
    pristinePost = {title:null, category:null, author:null, description:null}
    postId = $routeParams.postId
    $scope.categories = []
    $scope.path = $location.path()

    postsService.getCategories().then((cats) -> $scope.categories = cats)

    if $scope.path is '/postForm'
      $scope.post = {}
    else
      postsService.getPost(postId).then((post) -> $scope.post = angular.copy(post))

    $scope.update = () ->
      if $scope.postForm.$valid

        if $scope.path is '/postForm'
          postsService.addNewPost($scope.post).then( -> $location.path('/list'))
        else
          postsService.updatePost($scope.post).then( -> $location.path('/list'))

    $scope.reset = (form) ->
      if form?
        form.$setPristine()
        form.$setUntouched()
      $scope.post = angular.copy(pristinePost)
  ])



angular.module('middlistApp').controller('PostViewController', ['$scope', '$http', '$routeParams', '$location', 'postsService'
  ($scope, $http, $routeParams, $location, postsService) ->
    postId = $routeParams.postId
    $scope.post = {}
    $scope.category = {}

    postsService.getPost(postId).then((post) ->
      $scope.post = post
      postsService.getCategory($scope.post.categoryId).then((category) -> $scope.category = category)
    )

    $scope.deletePost = ->
      postsService.deletePost(postId).then( -> $location.path('/list'))
])
