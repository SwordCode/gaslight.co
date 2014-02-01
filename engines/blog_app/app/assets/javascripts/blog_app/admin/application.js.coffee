#= require jquery
#= require jquery_ujs
#= require handlebars
#= require bootstrap
#= require marked
#= require highlight/highlight.pack
#= require ember
#= require ember-data
#= require_self
#= require appkit

marked.setOptions
  smartypants: true
  highlight: (code) ->
    hljs.highlightAuto(code).value

window.BlogAdmin = Ember.Application.create
  LOG_TRANSITIONS: true

