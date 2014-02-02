#= require jquery
#= require jquery_ujs
#= require bootstrap
#= require marked
#= require highlight/highlight.pack
#= require handlebars
#= require ember
#= require ember-data

#= require_self

#= require ./store
#= require ./router
#= require_tree ./models
#= require_tree ./controllers
#= require_tree ./views
#= require_tree ./helpers
#= require_tree ./components
#= require_tree ./templates
#= require_tree ./routes

marked.setOptions
  smartypants: true
  highlight: (code) ->
    hljs.highlightAuto(code).value

window.BlogAdmin = BlogAdmin = Ember.Application.create
  LOG_TRANSITIONS: true
  templateNamespace: 'blog_app/admin/templates'

  Resolver: Ember.DefaultResolver.extend
    resolveTemplate: (parsedName) ->
      parsedName.fullNameWithoutType = BlogAdmin.templateNamespace + '/' + parsedName.fullNameWithoutType
      parsedName.name = BlogAdmin.templateNamespace + '/' + parsedName.name
      @_super(parsedName)


Em.Route.reopen
  activate: ->
    @_super()
    document.title = @routeName.split('.').map((v) ->
      v.split('-').map((vv) ->
        vv.capitalize()
      ).join(' ')
    ).join(' – ') + ' | Gaslight'

