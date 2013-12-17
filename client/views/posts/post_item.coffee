Template.postItem.helpers {
  domain: ->
    a = document.createElement('a')
    a.href = this.url
    a.hostname

  ownPost: ->
    this.userId is Meteor.userId()

  upvotedClass: ->
    userId = Meteor.userId()
    if (userId and not _.include(this.upvoters, userId))
      'btn-primary upvotable'
    else
      'disabled'


}

Template.postItem.rendered = ->
  #  animate post
  instance = this
  rank = instance.data._rank
  $this = $(this.firstNode)
  postHeight = 80
  newPosition = rank * postHeight

  if typeof instance.currentPosition isnt undefined
    previousPosition = instance.currentPosition

    delta = previousPosition - newPosition
    $this.css('top', delta + 'px')
  else
    $this.addClass('invisible')

  Meteor.defer ->
    instance.currentPosition = newPosition
    $this.css('top', '0px').removeClass('invisible')


Template.postItem.events {
  'click .upvotable': (e) ->
    e.preventDefault()
    Meteor.call 'upvote', this._id
}