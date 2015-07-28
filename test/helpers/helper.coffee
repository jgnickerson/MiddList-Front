createMockPostsService = ($q, mps = {}) ->
  categories = [
    {name: 'Cat1', id: 1}
    {name: 'Cat2', id: 2}
    {name: 'Cat3', id: 3}
  ]

  posts = [
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

  mps.getPost = (postId) ->
    defer = $q.defer()
    defer.resolve(posts[0])
    return defer.promise

  mps.addNewPost = (post) ->
    defer = $q.defer()
    defer.resolve()
    return defer.promise

  mps.updatePost = (post) ->
    defer = $q.defer()
    defer.resolve()
    return defer.promise

  mps.getCategories = ->
    defer = $q.defer()
    defer.resolve(categories)
    return defer.promise

  mps.getCategoryPosts = (categoryId) ->
    categoryId = parseInt(categoryId)
    defer = $q.defer()
    categoryPosts = _.filter(posts, (p) -> categoryId is p.categoryId)
    defer.resolve(categoryPosts)
    return defer.promise

  return mps


window.specHelper ?= {}
window.specHelper.createMockPostsService = createMockPostsService
