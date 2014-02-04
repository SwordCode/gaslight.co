BlogAdmin.PostsNewRoute = Ember.Route.extend
  model: ->
    @store.createRecord('post')

  actions:
    savePost: (post) ->
      post.save().then(=> @transitionTo('post.index', post))
    
