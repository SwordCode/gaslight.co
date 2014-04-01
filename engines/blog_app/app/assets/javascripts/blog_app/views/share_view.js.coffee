class Blog.Views.ShareView extends Backbone.View
  className: "share"
  template: JST["blog_app/templates/share"]
  active: true
  mobileWidth: 768
  targetScrollRatio: 0.75

  events:
    "click .share__deactivate": "deactivate"

  constructor: (options = {}) ->
    @shareUrl = encodeURIComponent(options.shareUrl)
    @targetEl = $(options.targetEl)
    @viewportEl = $(options.viewportEl)
    @viewportEl.on 'scroll', => @handleScroll()
    @subreddit = options.subreddit
    super

  handleScroll: ->
    return @deactivate() if @mobile()
    if @currentScrollRatio() >= @targetScrollRatio
      @show()
    else
      @hide()

  render: ->
    @$el.html @template(@)
    @

  currentScrollRatio: ->
    (@viewportEl.scrollTop() + @viewportEl.height()) / @targetEl.height()

  mobile: ->
    @viewportEl.width() < @mobileWidth

  show: ->
    return unless @active == true
    @$el.addClass('share--active')

  hide: ->
    @$el.removeClass('share--active')

  deactivate: ->
    @active = false
    @hide()
