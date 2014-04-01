BlogAdmin.PostsNewRoute = Ember.DSModelRoute.extend
  model: ->
    @store.createRecord('post')

  actions:
    savePost: (post) ->
      post.save().then(=> @transitionTo('post.index', post))
    
