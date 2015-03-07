# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

enableTinyMCE = ->
  tinymce.init {
    selector:     "#post_description",
    plugins:      ["advlist autolink lists link anchor searchreplace wordcount table contextmenu paste"],
    content_css:  "/assets/posts.css",
    browser_spellcheck: true
  }

$(document).on "ready page:load", ->
  enableTinyMCE()

$(document).on "page:receive", ->
  tinymce.remove()
