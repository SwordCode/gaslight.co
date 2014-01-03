Training.CourseController = Ember.ObjectController.extend
  needs: ['chapter', 'application']
  isModalActive: false

  actions: 
    register: ->
      @set('isModalActive', false)
      @transitionToRoute('course.register', @get('model'))

  barStyle: (->
    "width: #{@get('controllers.chapter.progress') * 100}%"
  ).property('controllers.chapter.progress')

  purchase: ->
    @set('isModalActive', true)

  currentRoute: (->
    @get('controllers.application.currentRouteName')
  ).property('controllers.application.currentRouteName')

  isRegistering: (->
    @get('currentRoute') == 'course.register'
  ).property('currentRoute')

  showBlurb: (->
    @get('demo') && !@get('isRegistering')
  ).property('demo', 'isRegistering')

Training.CourseIndexController = Ember.Controller.extend
  needs: ['course']