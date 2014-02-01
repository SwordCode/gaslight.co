BlogAdmin.PostIndexRoute = Ember.Route.extend
  renderTemplate: ->
    @render 'post', into: 'posts'
