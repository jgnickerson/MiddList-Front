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
    $scope.categories = []
    $scope.path = $location.path()
    $http.get('http://localhost:3000/cats').success((cats) -> $scope.categories = cats)


    if $location.path() is '/postForm'
      $scope.post = {}
    else
      postToBeEdited = postRepository.getPost($routeParams.postId)
      $scope.post = _.clone(postToBeEdited)


    $scope.update = (post) ->
      if $scope.postForm.$valid
        if $scope.path is '/postForm'
          $http.post('http://localhost:3000/postForm', $scope.post).success( -> $location.path('/list'))
        else
          postRepository.updatePost(post)
        $location.path('/list')

    $scope.reset = (form) ->
      if form?
        form.$setPristine()
        form.$setUntouched()
      $scope.post = angular.copy(pristinePost)
  ])

angular.module('middlistApp').controller('PostViewController', ['$scope', '$routeParams', '$location', 'postRepository'
  ($scope, $routeParams, $location, postRepository) ->
    $scope.post = postRepository.getPost($routeParams.postId)
    $scope.category = postRepository.getCategoryObject($scope.post.categoryId)

    $scope.deletePost = ->
      postRepository.deletePost($routeParams.postId)
      $location.path('/list')
])
