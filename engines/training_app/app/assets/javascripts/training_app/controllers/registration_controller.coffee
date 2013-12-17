Training.CourseRegisterController = Ember.ObjectController.extend
  needs: ['flash']
  purchasePending: false
  discountPending: false
  registrationErrors: null
  cardErrors: null

  actions:
    submit: ->
      @set('cardErrors', null)
      @set('purchasePending', true)
      @createStripeToken()

  currentPrice: (->
    if @get('discountedPrice')? then @get('discountedPrice') else @get('course.price')
  ).property('course.price', 'discountedPrice')

  isDiscounted: (->
    @get('discountedPrice')?
  ).property('discountedPrice')

  cardProperties: (->
    @get('card').getProperties('name', 'number', 'expMonth', 'expYear')
  ).property('card.name', 'card.number', 'card.expMonth', 'card.expYear')

  discountCodeURL: (->
    "/training/api/discount_codes/#{@get('discountCode')}"
  ).property('discountCode')

  discountCodeDidChange: (->
    Ember.run.throttle(this, 'fetchDiscount', 300)
  ).observes('discountCode')

  createStripeToken: ->
    Stripe.createToken @get('cardProperties'), (status, response) =>
      if (status == 200)
        @handleStripeSuccess(response)
      else
        @handleStripeError(response)

  handleStripeSuccess: (response) ->
    @set('stripe_token', response.id)
    @get('model').save().then(@handleRegistrationSuccess.bind(this), @handleRegistrationError.bind(this))

  handleStripeError: (response) ->
    @set('cardErrors', response.error.message)
    @set('purchasePending', false)

  handleRegistrationSuccess: (registration) ->
    registration.get('course').reload().then =>
      @get('controllers.flash').add("Thanks for purchasing!")
      @transitionToRoute('course', registration.get('course'))

  handleRegistrationError: (response) ->
    @set('purchasePending', false)
    if response.responseJSON?
      @set('registrationErrors', response.responseJSON.error_message)
    else
      @set('registrationErrors', "Oops! Something went wrong. Please send an email to training@gaslight.co and we'll get you setup.")

  fetchDiscount: ->
    return unless @get('discountCode')? && @get('discountCode').length > 2
    @set('discountPending', true)
    Ember.$.getJSON(@get('discountCodeURL')).then(@handleDiscountSuccess.bind(this), @handleDiscountError.bind(this))

  handleDiscountSuccess: (response) ->
    @set('discountedPrice', response.discount_code.price)
    @set('discountPending', false)

  handleDiscountError: (response) ->
    @set('discountPending', false)
