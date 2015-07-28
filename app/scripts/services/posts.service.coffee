angular.module('middlistApp').service('postsService', ['$http', 'errorService',  ($http, errorService) ->
    service = {}


    transformResponse = (response) -> response?.data

    handleError = (reason) ->
      errorService.addError(reason)
      throw reason.status + " : " + reason.data
      reason

    get = (url) ->
      $http.get(url).then(transformResponse,handleError)


    service.getPosts = ->
      get('http://localhost:3000/posts')

    service.getPost = (postId) ->
      get("http://localhost:3000/posts/view/#{postId}")

    service.getCategoryPosts = (categoryId) ->
      get("http://localhost:3000/posts/#{categoryId}")

    service.getCategories = ->
      get('http://localhost:3000/cats')

    service.getCategory = (categoryId) ->
      get("http://localhost:3000/cats/#{categoryId}")

    service.addNewPost = (newPost) ->
      $http.post('http://localhost:3000/posts', newPost)
      .then(
        -> console.log "successfull added a new post"
        handleError
      )

    service.updatePost = (updatedPost) ->
      $http.put("http://localhost:3000/posts/#{updatedPost.postId}", updatedPost)
      .then(
        -> console.log "successfully updated a post",
        handleError
      )

    service.deletePost = (postId) ->
      $http.delete("http://localhost:3000/posts/view/#{postId}")

    return service
])

