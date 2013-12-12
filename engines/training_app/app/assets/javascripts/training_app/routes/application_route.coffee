Training.ApplicationRoute = Ember.Route.extend
  actions:
    flash: (message, status) ->
      @controllerFor('flash').add(message, status)
