BlogAdmin.Router.map ->
  @resource 'posts', ->
    @resource 'post', path: "/:post_id", ->
      @route 'edit'

