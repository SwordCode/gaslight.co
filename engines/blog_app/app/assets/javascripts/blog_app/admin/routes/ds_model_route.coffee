Ember.DSModelRoute = Ember.Route.extend
  deactivate: -> 
    model = this.get 'controller.model'
    model.rollback()
    if (model.get 'isNew')
      model.deleteRecord()

  actions: 
    willTransition: (transition) ->
      model = this.get 'controller.model' 
      if ((model.get 'wasEdited')  && !confirm('You have unsaved changes. They will be lost if you continue!'))
        transition.abort()
