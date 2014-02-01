Ember.Handlebars.helper 'format-markdown', (input) ->
  new Handlebars.SafeString marked(input)
