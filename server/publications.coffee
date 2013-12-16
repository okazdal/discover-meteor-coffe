Meteor.publish 'posts', (options) ->
  Posts.find({}, options)

Meteor.publish 'singlePost', (id) ->
  Posts.find id and id

Meteor.publish 'comments', (postId) ->
  Comments.find {postId: postId}

Meteor.publish 'notifications', ->
  Notifications.find { userId: this.userId}