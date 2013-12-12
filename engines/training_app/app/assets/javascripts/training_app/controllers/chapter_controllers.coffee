Training.ChapterController = Ember.ObjectController.extend()

Training.ChaptersController = Ember.ArrayController.extend
  needs: ['course']
  sectionsBinding: 'controllers.course.sections'
  isSidebarActive: true

Training.ChaptersIndexController = Ember.ArrayController.extend
  needs: ['course']

  courseTitle: (->
    @get('controllers.course.title')
  ).property('controllers.course')

  firstChapter: (->
    @get('store').all('chapter').findBy('demo', true)
  ).property('controllers.course')
