BlogAdmin.PostsNewController = Ember.ObjectController.extend

  setUnknownProperty: (key,value) ->
    @_super(key,value)
    @get('model').set('wasEdited',true)
