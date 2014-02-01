#= require jquery
#= require jquery_ujs
#= require bootstrap
#= require marked
#= require highlight/highlight.pack
#= require handlebars
#= require ember
#= require ember-data

#= require_self

#= require blog_app/admin/store
#= require blog_app/admin/router
#= require_tree ./admin/models
#= require_tree ./admin/controllers
#= require_tree ./admin/views
#= require_tree ./admin/helpers
#= require_tree ./admin/components
#= require_tree ./admin/templates
#= require_tree ./admin/routes

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
