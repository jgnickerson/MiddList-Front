(function() {
  angular.module('middlistApp').service('postsService', [
    'httpHelper', function(httpHelper) {
      var service;
      service = {};
      service.getPosts = function() {
        return httpHelper.get('http://localhost:3000/posts');
      };
      service.getPost = function(postId) {
        return httpHelper.get("http://localhost:3000/post/" + postId);
      };
      service.getCategoryPosts = function(categoryId) {
        return httpHelper.get("http://localhost:3000/posts/" + categoryId);
      };
      service.getCategories = function() {
        return httpHelper.get('http://localhost:3000/cats');
      };
      service.getCategory = function(categoryId) {
        return httpHelper.get("http://localhost:3000/cat/" + categoryId);
      };
      service.addNewPost = function(newPost) {
        return httpHelper.post('http://localhost:3000/posts', newPost);
      };
      service.updatePost = function(updatedPost) {
        return httpHelper.put("http://localhost:3000/posts/" + updatedPost.postId, updatedPost);
      };
      service.deletePost = function(postId) {
        return httpHelper["delete"]("http://localhost:3000/posts/view/" + postId);
      };
      return service;
    }
  ]);

}).call(this);

//# sourceMappingURL=posts.js.map
