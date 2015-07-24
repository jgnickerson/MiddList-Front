angular.module('middlistApp').controller('ListController', ['$scope', '$http', '$routeParams', 'postRepository'
  ($scope, $http, $routeParams, postRepository) ->
    $scope.categoryId = $routeParams.categoryId #needed in scope for ng-if in list.html
    $scope.categories = []
    $scope.allPosts = []
    $scope.category = {}

    if $scope.categoryId is '0'
      $http.get('http://localhost:3000/posts').success((data) -> $scope.allPosts = data)
      $http.get('http://localhost:3000/cats').success((cats) -> $scope.categories = cats)
    else
      $scope.categoryPosts = postRepository.getCategoryPosts($scope.categoryId)

    $scope.getCategoryObject = (categoryId) ->
      return _.find($scope.categories, (category) -> return category.id is categoryId)
])



angular.module('middlistApp').controller('NewPostController', ['$scope','$http', '$location', '$routeParams', 'postRepository'
  ($scope, $http, $location, $routeParams, postRepository) ->

    pristinePost = {title:null, category:null, author:null, description:null}
    postId = $routeParams.postId
    $scope.categories = []
    $scope.path = $location.path()
    $http.get('http://localhost:3000/cats').success((cats) -> $scope.categories = cats)

    if $location.path() is '/postForm'
      $scope.post = {}
    else
      $http.get('http://localhost:3000/post/' + postId).success((post) -> $scope.post = _.clone(post))

    $scope.update = (post) ->
      if $scope.postForm.$valid
        if $scope.path is '/postForm'
          $http.post('http://localhost:3000/postForm', $scope.post).success( -> $location.path('/list'))
        else
          $http.put('http://localhost:3000/post/' + postId + '/edit', $scope.post).success( -> $location.path('/list'))

    $scope.reset = (form) ->
      if form?
        form.$setPristine()
        form.$setUntouched()
      $scope.post = angular.copy(pristinePost)
  ])



angular.module('middlistApp').controller('PostViewController', ['$scope', '$http', '$routeParams', '$location', 'postRepository'
  ($scope, $http, $routeParams, $location, postRepository) ->
    postId = $routeParams.postId
    $scope.post = {}
    $scope.category = {}
    $http.get('http://localhost:3000/post/' + postId).success((post) ->
      $scope.post = post
      $http.get('http://localhost:3000/cat/' + $scope.post.categoryId).success((category) ->
        $scope.category = category
      )
    )

    $scope.deletePost = ->
      $http.get('http://localhost:3000/post/'+ postId + '/delete').success( ->
        $location.path('/list')
      )
])
