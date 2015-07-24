angular.module('middlistApp').service 'postRepository', ['$http', ($http) ->
  currentId = 100

  service = {}

  categories = []

  allPosts = []

  service.getAllPosts = ->
    posts = []
    $http.get('http://localhost:3000/posts').success((data) ->
      console.log data
      posts = data
    )

  service.getCategoryPosts = (categoryId) ->
    #return array of only those posts which
    #have matching categoryId
    categoryId = parseInt(categoryId)
    return _.filter(allPosts, (p) -> p.categoryId is categoryId)

  service.getPost = (postId) ->
    postId = parseInt(postId)
    return _.find(allPosts, (p) -> p.postId is postId)

  service.getCategoryObject = (categoryId) ->
    categoryId = parseInt(categoryId)
    if categoryId is 0
      return
    return _.find(categories, (category) -> category.id is categoryId)

  service.getCategories = ->
    categories

  service.addPost = (newPost) ->
    newPost.postId = currentId++
    newPost.date = new Date()
    allPosts.push(newPost)

  service.updatePost = (editedPost) ->
    originalPost = _.find(allPosts, (p) -> p.postId is editedPost.postId)
    service.deletePost(originalPost.postId)
    allPosts.push(editedPost)

  service.deletePost = (postId) ->
    postId = parseInt(postId)
    _.remove(allPosts, (p) -> p.postId is postId)

  service.postIsNew = (post) ->
    return !post.postId?

  return service
]
