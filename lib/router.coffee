Router.configure {
  layoutTemplate: 'layout'
  loadingTemplate: 'loading'
  waitOn: ->
    Meteor.subscribe('notifications')
}

PostsListController = RouteController.extend {
  template: 'postsList'
  increment: 5
  limit: ->
    parseInt this.params.postsLimit or this.increment

  findOptions: ->
    {sort: {submitted: -1, _id: -1}, limit: this.limit()}

  waitOn: ->
    Meteor.subscribe 'posts', this.findOptions()

  data: ->
    {
      posts: Posts.find {}, this.findOptions()
      nextPath: this.route.path { postsLimit: this.limit() + this.increment }
    }
}

Router.map ->

  this.route 'postPage', {
    path: '/posts/:_id'

    waitOn: ->
      [ Meteor.subscribe('singlePost', this.params._id) ,
      Meteor.subscribe('comments', this.params._id) ]

    data: ->
      Posts.findOne this.params._id

  }

  this.route 'postSubmit', {
    path: '/submit'
    disableProgress: true
  }

  this.route 'postEdit', {
    path: '/posts/:_id/edit'
    waitOn: ->
      Meteor.subscribe 'singlePost', this.params._id
    data: ->
      Posts.findOne this.params._id
  }

  this.route 'postsList', {
    path: '/:postsLimit?'
    controller: PostsListController
  }


requireLogin = ->
  if ( not Meteor.user())
    if (Meteor.loggingIn())
      this.render this.loadingTemplate
    else
      this.render 'accessDenied'
    this.stop()

Router.before requireLogin, { only: 'postSubmit'}
Router.before ->
  Errors.clearSeen()