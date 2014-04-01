BlogAdmin.Post = DS.Model.extend
  isEditable: true

  title: DS.attr('string')
  description: DS.attr('string')
  body: DS.attr('string')
  slug: DS.attr('string')
  audio_url: DS.attr('string')
  author: DS.belongsTo('author')
  author_image: DS.attr('string')
  published_at: DS.attr('string')
  subreddit: DS.attr('string')

  publishedAt: Ember.computed.alias('published_at')
  authorImage: Ember.computed.alias('author_image')
  audioURL: Ember.computed.alias('audio_url')

  sizedAuthorImage: (->
    "#{@get('authorImage')}?s=64x64" if @get('authorImage')?
  ).property('authorImage')

  published: ((key, value) ->
    if arguments.length > 1
      if value == true
        @set('published_at', new Date().toISOString())
      else
        @set('published_at', null)
    !!@get('publishedAt')
  ).property('publishedAt')

  hasMarkdown: (->
    !!@get('body')
  ).property('body')

