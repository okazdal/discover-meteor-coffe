@ownsDocument = (userId, doc) ->
  doc and ( userId is doc.userId )