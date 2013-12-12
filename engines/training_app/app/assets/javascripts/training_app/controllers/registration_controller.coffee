Training.CourseRegisterController = Ember.ObjectController.extend
  registrationErrors: null
  cardErrors: null

  actions:
    submit: ->
      @set('cardErrors', null)
      @createToken()

  cardProps: (->
    @get('card').getProperties('name', 'number', 'expMonth', 'expYear')
  ).property('card')

  createToken: ->
    Stripe.createToken @get('cardProps'), (status, response) =>
      if (status == 200)
        @set('stripe_token', response.id)
        @get('model').save().then ((reg) => @handleSave(reg)), ((reg) => @handleError(reg))
      else
        @set('cardErrors', response.error.message)

  handleSave: (registration) ->
    debugger
    $.ajaxSetup(data: { code: registration.get('code') })
    registration.get('course').reload()
    @transitionToRoute('course', registration.get('course'))

  handleError: (e) ->
    @set('registrationErrors', e.errors)
