Training.CoursePurchaseRoute = Ember.Route.extend
  model: ->
    @get('store').createRecord('registration', course: @modelFor('course'))
