Training.ApplicationController = Ember.Controller.extend
  needs: ['flash']
  flashBinding: 'controllers.flash'
  defaultTitle: "Classroom"

  init: ->
    @setDefaultTitle()
    @createLinkElement()

  setDefaultTitle: ->
    @set('title', @get('defaultTitle'))

  titleDidChange: (->
    document.title = @get('title')
  ).observes('title')

  createLinkElement: ->
    @set('linkElement', $("<link rel='stylesheet' class='theme-link'></link>"))
    $('head').append(@get('linkElement'))

  setThemeUrl: (url) ->
    @get('linkElement').attr('href', url)