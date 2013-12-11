Training.Router.map ->
  @resource "course", { path: '/courses/:course_id' }, ->
    @route "purchase"
    @resource "chapters", ->
      @resource "chapter", path: ":chapter_id"