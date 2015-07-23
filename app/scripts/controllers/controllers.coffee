angular.module('middlistApp').controller('ListController', ['$scope', '$rootScope', '$routeParams', 'postRepository'
  ($scope, $rootScope, $routeParams, postRepository) ->
    $scope.categoryId = $routeParams.categoryId #needed in scope for ng-if in list.html
    $scope.category = postRepository.getCategoryObject($scope.categoryId);
    $scope.allPosts = []

    if $scope.categoryId is '0'
      postRepository.getAllPosts().then((result) -> 
        console.log result
        $scope.allPosts = result.data
      , (reason) -> 
        console.log("getAllPosts error:", reason)
      )
      $scope.categories = postRepository.getCategories()
    else
      $scope.categoryPosts = postRepository.getCategoryPosts($scope.categoryId)

    $scope.getCategoryObject = (categoryId) ->
      return postRepository.getCategoryObject(categoryId)
])

angular.module('middlistApp').controller('NewPostController', ['$scope', '$location', '$routeParams', 'postRepository'
  ($scope, $location, $routeParams, postRepository) ->
    $scope.categories = postRepository.getCategories()
#    pristinePost = {title:null, category:null, author:null, description:null}
    pristinePost = {}

    if $location.path() is '/postForm'
      $scope.post = {}
    else
      postToBeEdited = postRepository.getPost($routeParams.postId)
      $scope.post = _.clone(postToBeEdited)

    $scope.postIsNew = postRepository.postIsNew($scope.post) #needed in scope for ng-if in postForm.html

    $scope.update = (post) ->
      if $scope.postForm.$valid
        if $scope.postIsNew
          postRepository.addPost(post)
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
