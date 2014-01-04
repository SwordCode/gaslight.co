#= require jquery
#= require jquery_ujs
#= require jquery.placeholder
#= require jquery.form-n-validate
#= require ./analytics
#= require raphael
#= require underscore
#= require moment
#= require backbone
#= require backbone/gaslight
#= require blog_app/application
#= require ./coffee

track = (category, action, value = "") ->
  _gaq.push(['_trackEvent', category, action, value])

$ ->
  $('.top-bar__expand').on 'click', (event)->
    $('.top-bar').toggleClass('top-bar--expanded')

  $('.activate-modal, .modal__backdrop').on 'click touchstart', (event)->
    $('.modal').toggleClass('modal--active')

  $("meta[property='og:article:tag']").each ->
    track('Blog', 'Tag', $(this).attr('content'))

  $("meta[property='author']").each ->
    track('Blog', 'Author', $(this).attr('content'))

  $('#mc-embedded-subscribe').on 'click', (event) ->
    url = $("meta[property='og:url']").attr('content') or location.href
    track('Blog', 'Newsletter Signup', url)

  # Fix ie placeholders
  $('input, textarea').placeholder()
