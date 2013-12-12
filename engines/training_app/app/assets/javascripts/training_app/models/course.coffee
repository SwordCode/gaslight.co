Training.Course = DS.Model.extend
  title: DS.attr('string')
  introduction: DS.attr('string')
  price: DS.attr('number')
  demo: DS.attr('boolean')
  sections: DS.hasMany('section')
