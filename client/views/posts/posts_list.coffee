Template.postsList.helpers {
  hasMorePosts: ->
    this.posts.rewind()
    Router.current().limit() is this.posts.count()
}