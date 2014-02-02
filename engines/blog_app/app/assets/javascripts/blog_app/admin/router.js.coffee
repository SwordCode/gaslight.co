BlogAdmin.Router.map ->
  @resource 'posts', ->
    @route 'new'
    @resource 'post', path: "/:post_id", ->
      @route 'edit'

