BlogAdmin.Post = DS.Model.extend
  isEditable: true

  title: DS.attr('string')
  description: DS.attr('string')
  body: DS.attr('string')
  slug: DS.attr('string')
  audio_url: DS.attr('string')
  author: DS.attr('string')
  author_image: DS.attr('string')
  published_at: DS.attr('string')

  publishedAt: Ember.computed.alias('published_at')
  authorImage: Ember.computed.alias('author_image')
  audioURL: Ember.computed.alias('audio_url')

  sizedAuthorImage: (->
    "#{@get('authorImage')}?s=64x64" if @get('authorImage')?
  ).property('authorImage')

  isPublished: (->
    !!@get('publishedAt')
  ).property('publishedAt')

  hasMarkdown: (->
    !!@get('body')
  ).property('body')

