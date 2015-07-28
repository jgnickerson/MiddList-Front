angular.module('middlistApp').service('postsService', ['httpHelper',  (httpHelper) ->
    service = {}

    service.getPosts = ->
      httpHelper.get('http://localhost:3000/posts')

    service.getPost = (postId) ->
      httpHelper.get("http://localhost:3000/posts/view/#{postId}")

    service.getCategoryPosts = (categoryId) ->
      httpHelper.get("http://localhost:3000/posts/#{categoryId}")

    service.getCategories = ->
      httpHelper.get('http://localhost:3000/cats')

    service.getCategory = (categoryId) ->
      httpHelper.get("http://localhost:3000/cats/#{categoryId}")

    service.addNewPost = (newPost) ->
      httpHelper.post('http://localhost:3000/posts', newPost)

    service.updatePost = (updatedPost) ->
      httpHelper.put("http://localhost:3000/posts/#{updatedPost.postId}", updatedPost)

    service.deletePost = (postId) ->
      httpHelper.delete("http://localhost:3000/posts/view/#{postId}")

    return service
])

