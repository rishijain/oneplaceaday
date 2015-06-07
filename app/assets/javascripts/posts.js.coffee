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

onEvents = ->
  $('body').on 'click', '.btn-state', ->

    if $('#state_change_form').length is 1
      $('#next_state').val $(this).data('next-state')
      $('#state_change_form').submit()
    else if $('.edit_post').length is 1
      $('#post_aasm_state').val $(this).data('next-state')
      $('.edit_post').submit()
    else if $('.new_post').length is 1
      $('#post_aasm_state').val $(this).data('next-state')
      $('.new_post').submit()

  $('.btn').tooltip()

$ ->
  onEvents()
