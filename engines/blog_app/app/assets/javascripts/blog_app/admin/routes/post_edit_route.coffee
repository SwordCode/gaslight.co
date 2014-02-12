BlogAdmin.PostEditRoute = Ember.Route.extend
  authors: ['cdmwebs', 'joelturnbull']

  model: ->
    @modelFor('post')

  actions:
    savePost: (post) ->
      post.save()

  setupController: (controller, model) ->
    controller.set('model', model)
    controller.set('authors', @authors)

