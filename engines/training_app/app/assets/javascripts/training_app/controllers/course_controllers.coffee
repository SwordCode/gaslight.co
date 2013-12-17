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

Training.CourseIndexController = Ember.Controller.extend
  needs: ['course']