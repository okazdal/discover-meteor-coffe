
@Posts = new Meteor.Collection 'posts'
@Posts.allow {
#  insert: (userId, doc) ->
#    only allow if logged
#    userId?
  update: ownsDocument
  remove: ownsDocument
}

@Posts.deny {
  update: (userId, post, fieldNames) ->
    _.without(fieldNames, 'url', 'title').length > 0
}

Meteor.methods {
  post: (postAttributes) ->
    user = Meteor.user()
    postWithSameLink = Posts.findOne { url: postAttributes.url }

    if not user?
      throw new Meteor.Error 401, 'You need to login to post new stories'

    if not postAttributes.title?
      throw new Meteor.Error 422, 'Please fill in headline'

    if postAttributes.url and postWithSameLink
      throw new Meteor.Error 302, 'This link has already been posted', postWithSameLink._id

    post = _.extend(_.pick(postAttributes, 'url', 'title', 'message'),
                                                                      {
                                                                        userId: user._id,
                                                                        author: user.username,
                                                                        submitted: new Date().getTime(),
                                                                        commentsCount: 0
                                                                      }
    )

    postId = Posts.insert post

  upvote: (postId) ->
    user = Meteor.user()

    if not user
      throw new Meteor.Error 401, "You need to login to upvote!"

    Posts.update { _id: postId, upvoters: {$ne: user._id} }, { $addToSet: {upvoters: user._id}, $inc: {votes: 1}}

}