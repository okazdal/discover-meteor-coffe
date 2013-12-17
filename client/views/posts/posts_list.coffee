Template.postsList.helpers {
  postsWithRank: ->
    this.posts.rewind()
    this.posts.map (post, index, cursor) ->
      post._rank = index
      post


  hasMorePosts: ->
    this.posts.rewind()
    Router.current().limit() is this.posts.count()
}