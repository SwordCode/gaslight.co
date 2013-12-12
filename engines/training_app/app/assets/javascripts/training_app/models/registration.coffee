Training.Registration = DS.Model.extend
  amount: DS.attr('number')
  name: DS.attr('string')
  email: DS.attr('string')
  phone: DS.attr('string')
  code: DS.attr('string')
  stripe_token: DS.attr('string')
  discountCode: DS.attr('string')
  course: DS.belongsTo('course')
