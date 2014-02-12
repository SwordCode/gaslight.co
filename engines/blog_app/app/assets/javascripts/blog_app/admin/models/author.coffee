BlogAdmin.Author = DS.Model.extend
  login: DS.attr('string')
  tumblr: DS.attr('string')
  posts: DS.hasMany('post')

