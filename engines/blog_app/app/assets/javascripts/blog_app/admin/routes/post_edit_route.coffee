BlogAdmin.PostEditRoute = Ember.Route.extend
  model: ->
    @modelFor('post')

  renderTemplate: ->
    @render 'post.edit', into: 'posts'

  actions:
    savePost: (post) ->
      post.save().then(@redirectToPost.bind(this))

  redirectToPost: ->
    @transitionTo('post.index', this)

  setupController: (controller, model) ->
    @controller.set('model', model)
    @controllerFor('post').set('isEditable', false)

