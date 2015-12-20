# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $("body").on "click", "li", (ev)->
    console.log($(ev.target).data() )
    console.log( ev )
    data = $(ev.target).data()
    url = data.bigUrl

    $("#photo_holder").css("background-image", 'url(' + url + ')' )
    $('#photo_email_photo_id').val(data.id)
    #elem = document.getElementById("container")
    #elem.webkitRequestFullscreen()

  $("#photo_holder").on("click", (ev)->
    screenfull.request()
    $('#shooter').submit()
    docElm = document.documentElement;
    docElm.webkitRequestFullScreen()
  )

  $("body").on "ajax:send", "form", (ev)->
    console.log("Photo sent!")

  docElm = document.documentElement;
  docElm.webkitRequestFullScreen()

  if screenfull.enabled
    screenfull.request()
