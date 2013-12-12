Training.CourseRegisterRoute = Ember.Route.extend
  model: ->
    @get('store').createRecord('registration', course: @modelFor('course'))

  setupController: (controller, model) ->
    controller.set('model', model);
    controller.set('card', Ember.Object.create())