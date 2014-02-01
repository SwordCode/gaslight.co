BlogAdmin.PostRoute = Ember.Route.extend
  serialize: (model) ->
    post_id: model.get('slug')

