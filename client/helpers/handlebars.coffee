Handlebars.registerHelper 'pluralize', (n, thing) ->
  if n in [0 ,1]
    if n is 1
      '1 ' + thing
    else
      '0 ' + thing
  else
    n + ' ' + thing + 's'

