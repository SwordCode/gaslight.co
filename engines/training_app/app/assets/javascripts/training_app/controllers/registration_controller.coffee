Training.CourseRegisterController = Ember.ObjectController.extend
  errors: null

  actions:
    submit: ->
      @createToken()

  cardProps: (->
    @get('card').getProperties('name', 'number', 'expMonth', 'expYear')
  ).property('card')

  createToken: ->
    Stripe.createToken @get('cardProps'), (status, response) =>
      if (status == 200)
        @set('stripe_token', response.id)
        @get('model').save()
      else
        @set('errors', response.error.message)
