class Gaslight.Views.ShareView extends Backbone.View
  className: "share"

  template: JST["backbone/templates/share"]

  active: true

  targetScrollRatio: 0.5

  events:
    "click .share__deactivate": "deactivate"

  constructor: (options = {}) ->
    @shareUrl = encodeURIComponent(options.shareUrl)
    @targetEl = $(options.targetEl)
    @viewportEl = $(options.viewportEl)
    @viewportEl.on 'scroll', => @handleScroll()
    super

  render: ->
    @$el.html @template(@)
    @

  currentScrollRatio: ->
    (@viewportEl.scrollTop() + @viewportEl.height()) / @targetEl.height()

  handleScroll: ->
    if @currentScrollRatio() >= @targetScrollRatio
      @show()
    else
      @hide()

  show: ->
    return unless @active == true
    @$el.addClass('share--active')

  hide: ->
    @$el.removeClass('share--active')

  deactivate: ->
    @active = false
    @hide()
