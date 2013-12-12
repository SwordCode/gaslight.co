Training.FlashController = Ember.ObjectController.extend
  statusClass: (->
    "flash--#{@get('status')}"
  ).property('status')

  init: ->
    @set('content', {message: null, status: null})

  add: (message, status) ->
    @setProperties({ message: message, status: status })