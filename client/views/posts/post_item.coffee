Template.postItem.helpers {
  domain: ->
    a = document.createElement('a')
    a.href = this.url
    a.hostname

  ownPost: ->
    this.userId is Meteor.userId()

}