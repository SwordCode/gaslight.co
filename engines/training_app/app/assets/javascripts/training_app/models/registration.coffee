Training.Registration = DS.Model.extend
  amount: DS.attr('Number')
  name: DS.attr('String')
  email: DS.attr('String')
  phone: DS.attr('String')
  organization: DS.attr('String')
  discount_code: DS.attr('String')
  course: DS.belongsTo('course')
