BlogAdmin.PostRoute = Ember.Route.extend
  serialize: (model) ->
    post_id: model.get('slug')

  afterModel: (post) ->
    document.title = post.get('title')

