# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

submitForm = (url, method, data) ->
  $.ajax({
    url: url,
    method: method,
    data: { post: data },
    dataType: 'json'
  }).always( (response) ->
    if response.status == 200
      $('.' + Object.keys(data)[0]).removeClass('bg-danger')
    else
      $('.' + Object.keys(data)[0]).addClass('bg-danger')
  )

registerEditor = (element, options = { disableReturn: true }) ->
  data = {}
  editor = new MediumEditor(element, options)
  $(element).on "focusout", ->
    data[$(this).data('field')] = $(this).text()
    submitForm(post_url, post_method, data)

$(document).on "ready page:load", ->
  registerEditor(".editable .title em")
  registerEditor(".editable .description", { disableReturn: false })
  registerEditor(".editable .visited-on", { disableReturn: true, disableToolbar: true })
  registerEditor(".editable .place", { disableReturn: true, disableToolbar: true })
  registerEditor(".editable .country", { disableReturn: true, disableToolbar: true })
