Training.ModalDialogComponent = Ember.Component.extend
  classNames: "modal"
  classNameBindings: ['active:modal--active']
  actions:
    deactivate: ->
      @set('active', false)