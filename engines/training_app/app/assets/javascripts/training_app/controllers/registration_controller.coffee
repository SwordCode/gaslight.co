Training.CourseRegisterController = Ember.ObjectController.extend
  needs: ['flash']
  registrationErrors: null
  cardErrors: null

  actions:
    submit: ->
      @set('cardErrors', null)
      @createToken()

  cardProps: (->
    @get('card').getProperties('name', 'number', 'expMonth', 'expYear')
  ).property('card.name', 'card.number', 'card.expMonth', 'card.expYear')

  createToken: ->
    Stripe.createToken @get('cardProps'), (status, response) =>
      if (status == 200)
        @set('stripe_token', response.id)
        @get('model').save().then(@handleSave.bind(this), @handleError.bind(this))
      else
        @set('cardErrors', response.error.message)

  handleSave: (registration) ->
    registration.get('course').reload().then =>
      @get('controllers.flash').add("Thanks for purchasing!")
      @transitionToRoute('course', registration.get('course'))

  handleError: (e) ->
    @set('registrationErrors', e.errors)

  discountCodeDidChange: (->
    Ember.run.throttle(this, 'fetchDiscount', 300)
  ).observes('discountCode')

  discountCodeURL: (->
    "/training/api/discount_codes/#{@get('discountCode')}"
  ).property('discountCode')

  fetchDiscount: ->
    return unless @get('discountCode')? && @get('discountCode').length > 2
    $.getJSON(@get('discountCodeURL')).then (response) =>
      @set('discountedPrice', response.discount_code.price)

