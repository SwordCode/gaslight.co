BlogAdmin.PostsNewRoute = Ember.Route.extend
  model: ->
    @store.createRecord('post')

  renderTemplate: ->
    @render 'post.edit', into: 'posts'

  actions:
    savePost: (post) ->
      post.save().then(=> @transitionTo('post.index', post))
    
