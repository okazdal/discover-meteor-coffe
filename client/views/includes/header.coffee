#Helper Arguments
#
#We haven't used that specific pattern up to now, but just like any other Handlebars tags, template helper tags can take arguments.
#
#And while you can of course pass specific named arguments to your function, you can also pass an unspecified number of anonymous parameters and retrieve them by calling the arguments object inside a function.
#
#In this last case, you will probably want to convert the arguments object to a regular JavaScript array and then call pop() on it to get rid of the hash added at the end by Handlebars.

Template.header.helpers {
  activeRouteClass: ->
    args = Array.prototype.slice.call(arguments, 0)
    args.pop()

    active = _.any args, (name) ->
      Router.current().route.name is name

    active and 'active'
#    false and 'mystring' returns false
#    true and 'mystring' returns mystring
}