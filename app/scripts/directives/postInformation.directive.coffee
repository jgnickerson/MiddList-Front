angular.module('middlistApp').directive('postInformation', ['postsService', '$location', (postsService, $location) ->
  return {
  scope:
    post: '='
  link: (scope) ->
    scope.category = {}
    postsService.getCategory(scope.post.categoryId).then((cat) -> scope.category = cat)
#    scope.category = postsService.getCategory(scope.post.categoryId)

    scope.deletePost = (postId) ->
      postsService.deletePost(postId)
      .then(-> $location.path('/list'))
  template: """
    <div>
      <a ng-href="#/post/{{post.postId}}">
        <h3>{{post.title}}</h3></a>
      <h5>Posted by {{post.author}} in {{category.name}} on {{post.date | date:"short"}}</h5>
      <button ng-really-message="Are you sure you want to delete this post?" ng-really-click="deletePost({{post.postId}})" class="btn btn-default">Delete this post</button>
      <a ng-href="#/post/{{post.postId}}/edit"><button class="btn btn-default">Edit this post</button></a>
    </div>
  """
  }
])
