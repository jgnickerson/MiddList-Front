angular.module('middlistApp').service('postsService', ['$http', '$q', ($http, $q) ->
    service = {}

    service.getPosts = ->
      $http.get('http://localhost:3000/posts')
      .then((response) -> response.data)

    service.getPost = (postId) ->

      $http.get('http://localhost:3000/posts/view/' + postId).then((post) -> post.data)

    service.getCategoryPosts = (categoryId) ->
      $http.get('http://localhost:3000/posts/' + categoryId)
      .then((response) -> response.data)

    service.getCategories = ->
      $http.get('http://localhost:3000/cats')
      .then((response) -> response.data)

    service.addNewPost = (newPost) ->
      $http.post('http://localhost:3000/posts', newPost)
      .then(
        -> console.log "successfully added new post",
        (httpError) -> throw httpError.status + " : " + httpError.data
      )

    service.updatePost = (updatedPost) ->
      $http.put('http://localhost:3000/posts/' + updatedPost.postId, updatedPost)
      .then( -> console.log("successfully updated a post"))

    return service
])
